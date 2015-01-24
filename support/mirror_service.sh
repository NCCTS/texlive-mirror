#!/bin/sh

touch /var/log/mirror_server.log
chown root:sailor /var/log/mirror_server.log
chmod 664 /var/log/mirror_server.log

exec sudo -i -u sailor -- bash -i -c 'mirror_server.sh >>/var/log/mirror_server.log 2>&1'
