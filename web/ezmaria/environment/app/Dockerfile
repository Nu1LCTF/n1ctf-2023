FROM registry.cn-hangzhou.aliyuncs.com/ctfhub_base/web_httpd_mysql_php_8.0
# 出题者信息一定需要
LABEL Organization="CTFHub"
LABEL Author="lolita <llt@xswl.io>"

ENV LANG="C.UTF-8"

#copy file 1
RUN mkdir /app
COPY src /app/src
COPY files/ /app/files
RUN rm /usr/local/bin/docker-php-entrypoint


# copy source file and set priv

RUN rm /var/www/html/* && \
    #setup web file
    cp /app/src/* /var/www/html/ && \
    chown root:root -R /var/www && \
    chmod 755 -R /var/www
    #setup db
RUN mkdir -p /run/mysqld /mysql/data /mysql/base /mysql/plugin && \
    #useradd mysql && \
    usermod -s /bin/bash mysql && \
    chown mysql:mysql -R /run/mysqld /mysql && \
    su mysql -c "mariadbd --skip-grant-tables --secure-file-priv='' --datadir /mysql/data &" && \
    sleep 5s && \
    mysql -e "source /app/files/init.sql" && \
    killall mariadbd && \
    #set uid priv
    #chmod u+s /usr/sbin/mariadbd && \
    #copy start.sh and clean up
    cp /app/files/start.sh /start.sh && \
    cp /app/files/init.sql /init.sql && \
    cp /app/files/mysql.sh /mysql.sh && \
    chmod 700 /start.sh /mysql.sh && \
    chmod 600 /init.sql && \
    rm -rf /app

WORKDIR /
#CMD /start.sh && sleep infinity
#CMD /start.sh && bash
ENTRYPOINT ["/bin/bash", "-c", "/start.sh && sleep infinity"]