#!/bin/bash

touch /var/log/mirror_server.log
chown root:sailor /var/log/mirror_server.log
chmod 664 /var/log/mirror_server.log

exec /sbin/setuser sailor bash -c 'cd /home/sailor && \
                                   source $HOME/.nvm/nvm.sh && \
                                   exec bin/mirror_server.sh \
                                   >>/var/log/mirror_server.log 2>&1'
