FROM benlumia007/ubuntu:20.04

# Here, we are going to set the frontend to no interactive.
ENV DEBIAN_FRONTEND=noninteractive

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

# Here, we are gong to make sure tht some of the configurations are set for php7.4-fpm.
ADD templates/lemp/7.4/config/nginx/nginx.conf /etc/nginx/nginx.conf
ADD templates/lemp/7.4/config/php/custom/custom.ini /etc/php/7.4/mods-available/php7.4-custom.ini
ADD templates/lemp/7.4/config/php/upstream/upstream.conf /etc/nginx/upstream/php7.4-fpm.conf
ADD templates/lemp/7.4/config/php/fpm/fpm.conf /etc/php/7.4/fpm/pool.d/www.conf

# Here, we are gong to make sure tht some of the configurations are set for php8.0-fpm.
ADD templates/lemp/7.4/config/supervisord/lemp.conf /etc/supervisor/conf.d/lemp.conf
ADD templates/lemp/7.4/config/supervisord/start.sh /usr/local/bin/start_lemp
ADD templates/lemp/7.4/config/mysql/my.cnf /root/.my.cnf
ADD templates/lemp/7.4/config/mysql/my.cnf /home/docker/.my.cnf
RUN sudo mkdir -p /run/php && \
    sudo chmod +x /usr/local/bin/start_lemp

# Here, we are going to enable some php features
RUN sudo phpenmod php7.4-custom

# Here, we are going to setup mysql server configurations, the stupid way but works.
RUN sudo service mysql start 2> /dev/null && \
    sudo service mysql reload && \
    sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'root';" && \
    sudo mysql -u root -e "GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" && \
    sudo mysql -u root -e "FLUSH PRIVILEGES;" && \
    sudo service mysql stop

CMD [ "start_lemp" ]