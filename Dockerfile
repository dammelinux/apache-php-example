FROM centos:7

LABEL maintainer="KAI VO"

RUN yum update -y
# Install sshd service
RUN yum install openssh-server -y && \
	ssh-keygen -A && \
	echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "root:123456" | chpasswd
# Install apache php service
RUN yum -y install php php-mbstring php-pear httpd \ 
    && mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.bk
# Install supervisor service
RUN yum install -y python-setuptools && \
    easy_install supervisor && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /etc/supervisor/conf.d 

COPY supervisor.conf /etc/supervisor.conf
COPY source/httpd.conf /etc/httpd/conf/
COPY source/index.php /var/www/html/

EXPOSE 80
CMD ["supervisord", "-c", "/etc/supervisor.conf"]