#!/bin/bash
while :
do
    su mysql -c "mariadbd --skip-grant-tables --secure-file-priv='' --datadir=/mysql/data --plugin_dir=/mysql/plugin --user=mysql"
done

