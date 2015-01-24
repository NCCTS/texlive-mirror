#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export HOME=/root

# Install phusion/baseimage service to invoke the http mirror-server
mkdir -p /etc/service/texlive-mirror
cp /docker-build/support/mirror_service.sh /etc/service/texlive-mirror/run

# Create a local mirror of TeX Live
/docker-build/support/mirror.sh
mv /docker-build/support/texlive-mirror /home/sailor
chown -R sailor:sailor /home/sailor/texlive-mirror
chmod -R 555 /home/sailor/texlive-mirror
pushd .
cd /home/sailor/texlive-mirror
find . -type f -exec chmod 444 '{}' \;
popd
mkdir -p /home/sailor/bin
cp /docker-build/support/mirror_server.sh /home/sailor/bin
chown -R sailor:sailor /home/sailor/bin
chmod -R 755 /home/sailor/bin

# Install node.js http-server as unprivileged user 'sailor'
sudo -i -u sailor -- bash -i -c /docker-build/support/user_sailor.sh
