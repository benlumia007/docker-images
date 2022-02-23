FROM benlumia007/ubuntu:20.04

# Here, we are going to set the frontend to no interactive.
ENV DEBIAN_FRONTEND=noninteractive

# Here, we are going to install some basic packages to get the server going.
RUN sudo apt-get install --no-install-recommends \
    php-imagick \
    php-memcache \
    php-memcached \
    php-pear \
    php-ssh2 \
    -y

# Here, we are going to install PHP 7.4 and 8.0
RUN sudo apt-get install --no-install-recommends \
    php7.4-bcmath \
    php7.4-cli \
    php7.4-common \
    php7.4-curl \
    php7.4-dev \
    php7.4-fpm \
    php7.4-gd \
    php7.4-imap \
    php7.4-imagick \
    php7.4-json \
    php7.4-mbstring \
    php7.4-mysql \
    php7.4-soap \
    php7.4-sqlite3 \
    php7.4-xml \
    php7.4-zip \
    -y

# Here, we are going to amke sure the /run/php is available.
RUN sudo mkdir -p /run/php && \
    sudo rm -rf /etc/apache2/conf-available/other-vhosts-access-log.conf

# Here we are going to add some basic files
ADD templates/php/7.4/config/supervisord/php7.4-fpm.conf /etc/supervisor/conf.d/php7.4-fpm.conf
ADD templates/php/7.4/config/supervisord/start.sh /usr/local/bin/start

RUN sudo chmod +x /usr/local/bin/start

CMD [ "start" ]