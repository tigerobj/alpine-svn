FROM alpine:3.8
MAINTAINER jeff chou <tigerobj@gmail.com>

# Proxy settings if necessary
# ENV http_proxy=http://proxy:8080
# ENV https_proxy=http://proxy:8080
# ENV no_proxy="127.0.0.1,localhost,.mydomain.com"

# Install and configure Apache WebDAV and Subversion
RUN apk --no-cache add bash apache2 apache2-utils apache2-webdav subversion
RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

# Modify repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.7/main' >> /etc/apk/repositories

# change mod_dav_svn version (alpine 3.7)
RUN apk update
RUN apk --no-cache add mod_dav_svn=1.9.12-r0


ADD vh-davsvn.conf /etc/apache2/conf.d/
ADD davsvn.htpasswd /etc/apache2/conf.d/

RUN mkdir -p /run/apache2

ADD run.sh /
RUN chmod +x /run.sh
EXPOSE 80

# Define default command
CMD ["/run.sh"]
