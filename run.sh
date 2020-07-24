#!/bin/sh

if [ -n "$SVN_REPO" ]; then
test ! -d "/var/svn/$SVN_REPO" && svnadmin create /var/svn/$SVN_REPO && chgrp -R apache /var/svn/$SVN_REPO && chmod -R 775 /var/svn/$SVN_REPO
echo "Creating the repository: $SVN_REPO into /var/svn/"
else
test ! -d "/var/svn/testrepo" && svnadmin create /var/svn/repo && chgrp -R apache /var/svn/repo && chmod -R 775 /var/svn/repo
echo "Warning: SVN_REPO variable not defined, starting with svn default repository: repo into /var/svn/"
fi

if [ -n "$DAV_SVN_USER" ] && [ -n "$DAV_SVN_PASS" ]; then
htpasswd -b /etc/apache2/conf.d/davsvn.htpasswd $DAV_SVN_USER $DAV_SVN_PASS
else
htpasswd -b /etc/apache2/conf.d/davsvn.htpasswd davsvn davsvn
echo "Warning: DAV_SVN_USER / DAV_SVN_PASS variables not defined, starting with default account"
fi

httpd -D FOREGROUND
