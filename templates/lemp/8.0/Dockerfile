FROM benlumia007/ubuntu:20.04

# Here, we are going to set the frontend to no interactive.
ENV DEBIAN_FRONTEND=noninteractive

# Here, we are going to grab some ppa packages
RUN sudo add-apt-repository ppa:ondrej/php -y

## Here we are going to run and update for the latest packages.
RUN sudo apt-get update -y

# Here, we are going to install the nginx server.
RUN sudo apt-get install --no-install-recommends \
    nginx \
    -y

# Here, we are going to install the basic mysql server.
RUN sudo apt-get install --no-install-recommends \
    mysql-server \
    -y

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
    php8.0-intl \
    php8.0-mbstring \
    php8.0-mysql \
    php8.0-soap \
    php8.0-sqlite3 \
    php8.0-xml \
    php8.0-zip \
    -y

# Here, we are gong to make sure tht some of the configurations are set for php8.0-fpm.
ADD templates/lemp/8.0/config/nginx/nginx.conf /etc/nginx/nginx.conf
ADD templates/lemp/8.0/config/php/custom/custom.ini /etc/php/8.0/mods-available/php8.0-custom.ini
ADD templates/lemp/8.0/config/php/upstream/upstream.conf /etc/nginx/upstream/php8.0-fpm.conf
ADD templates/lemp/8.0/config/php/fpm/fpm.conf /etc/php/8.0/fpm/pool.d/www.conf

# Here, we are gong to make sure tht some of the configurations are set for php8.0-fpm.
ADD templates/lemp/8.0/config/supervisord/main.conf /etc/supervisor/conf.d/main.conf
ADD templates/lemp/8.0/config/supervisord/start.sh /usr/local/bin/start
ADD templates/lemp/8.0/config/mysql/my.cnf /root/.my.cnf
ADD templates/lemp/8.0/config/mysql/my.cnf /home/docker/.my.cnf
RUN sudo mkdir -p /run/php && \
    sudo chmod +x /usr/local/bin/start

# Here, we are going to enable some php features
RUN sudo phpenmod php8.0-custom

# Here, we are going to setup mysql server configurations, the stupid way but works.
RUN sudo service mysql start 2> /dev/null && \
    sudo service mysql reload && \
    sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'root';" && \
    sudo mysql -u root -e "GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" && \
    sudo mysql -u root -e "FLUSH PRIVILEGES;" && \
    sudo service mysql stop

CMD [ "start" ]