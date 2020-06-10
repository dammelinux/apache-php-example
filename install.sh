#!/bin/bash
yum -y install php php-mbstring php-pear httpd \
&& mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.bk \
&& cp httpd.conf /etc/httpd/conf/ \
&& cp index.php /var/www/html/

systemctl start httpd