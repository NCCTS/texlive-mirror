# Docker version 1.4.1, build 5bc2ff8
FROM nccts/node:0.0.11

# nccts/texlive-mirror
# Version: 2014
MAINTAINER "Michael Bradley" <michael.bradley@nccts.org>
# Magnificat anima mea Dominum, et exsultavit spiritus meus in Deo salvatore meo.

# Cache buster
ENV REFRESHED_AT [2015-01-23 Fri 14:47]

# Set environment variables
ENV HOME /root

# Add supporting files for the build
ADD . /docker-build

# Run main setup script, cleanup supporting files
RUN chmod -R 777 /docker-build
RUN /docker-build/setup.sh && rm -rf /docker-build

# node.js http-server will be listening on port 8080
EXPOSE 8080

# Use phusion/baseimage's init system as the entrypoint:
# 'entry.sh' starts shell (or tmux) as the 'sailor' user
# (tmux: with a session named 'texlive')
ENTRYPOINT ["/sbin/my_init", "--", "/usr/local/bin/entry.sh", "texlive"]
CMD http.sh

# example usage
# --------------------------------------------------
# docker run -it --rm -p 8080:8080 nccts/texlive-mirror
