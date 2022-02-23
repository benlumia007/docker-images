FROM benlumia007/ubuntu:20.04

# Here, we are going to set the frontend to no interactive.
ENV DEBIAN_FRONTEND=noninteractive

# Here, we are going to grab some ppa packages
RUN sudo add-apt-repository ppa:ondrej/php -y

# Here, we are going to install some basic packages to get the server going.
RUN sudo apt-get install --no-install-recommends \
    php-imagick \
    php-memcache \
    php-memcached \
    php-pear \
    php-ssh2 \
    -y

# Here, we are going to install PHP 8.0 and 8.0
RUN sudo apt-get install --no-install-recommends \
    php8.0-bcmath \
    php8.0-cli \
    php8.0-common \
    php8.0-curl \
    php8.0-dev \
    php8.0-fpm \
    php8.0-gd \
    php8.0-imap \
    php8.0-imagick \
    php8.0-mbstring \
    php8.0-mysql \
    php8.0-soap \
    php8.0-xml \
    php8.0-zip \
    -y

# Here, we are going to amke sure the /run/php is available.
RUN sudo mkdir -p /run/php && \
    sudo rm -rf /etc/apache2/conf-available/other-vhosts-access-log.conf

# Here we are going to add some basic files
ADD templates/php/8.0/config/supervisord/php8.0-fpm.conf /etc/supervisor/conf.d/php8.0-fpm.conf
ADD templates/php/7.4/config/supervisord/start.sh /usr/local/bin/start

RUN sudo chmod +x /usr/local/bin/start

CMD [ "start" ]