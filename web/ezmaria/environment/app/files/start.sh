#!/bin/bash
# sed -i "s/FLAG{ISHERE}/$FLAG/" /tmp/db.sql
# rm -f /build.sql
# mv /tmp/db.sql /build.sql
# mv /tmp/* /app/public
# echo "Enjoy Your CTF Time~"

echo $FLAG > /flag
chmod 600 /flag
unset FLAG

setcap CAP_SETFCAP=ep /usr/bin/mariadb

/mysql.sh &
apache2ctl start

echo "start.sh finished"
rm -rf /start.sh