FROM centos:centos7

MAINTAINER wangchuang<mail.wangchuang@gmail.com>

EXPOSE 80 443

COPY nginx.repo /etc/yum.repos.d/

RUN  yum install yum-utils \
    && yum-config-manager --enable nginx-stable \
    && yum -y install nginx \
    && yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && yum-config-manager --enable remi-php73 \
    && yum -y install php  php-mysqlnd php-devel php-pear  php-pdo  php-fpm git php-mbstring php-gd php-pecl-zip \
    && sed -i 's@memory_limit.*@memory_limit = 2048M@g' /etc/php.ini \
    && mkdir /run/php-fpm \
    && curl -sS https://getcomposer.org/installer | /usr/bin/php -- --install-dir=/usr/local/bin --filename=composer \
    && yum clean all 

COPY start.sh /start.sh

CMD ["/bin/sh", "/start.sh"]