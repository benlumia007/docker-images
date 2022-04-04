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
    php7.4-intl \
    php7.4-json \
    php7.4-mbstring \
    php7.4-mysql \
    php7.4-soap \
    php7.4-xml \
    php7.4-zip \
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
    php8.0-xml \
    php8.0-zip \
    -y

# Here, we are going to install PHP 8.1 and 8.1
RUN sudo apt-get install --no-install-recommends \
    php8.1-bcmath \
    php8.1-cli \
    php8.1-common \
    php8.1-curl \
    php8.1-dev \
    php8.1-fpm \
    php8.1-gd \
    php8.1-imap \
    php8.1-imagick \
    php8.1-intl \
    php8.1-mbstring \
    php8.1-mysql \
    php8.1-soap \
    php8.1-xml \
    php8.1-zip \
    -y

# Here, we are gong to make sure tht some of the configurations are set for php8.1-fpm.
ADD templates/lemp/latest/config/nginx/nginx.conf               /etc/nginx/nginx.conf
ADD templates/lemp/latest/config/php/custom/custom.ini          /etc/php/8.1/mods-available/php8.1-custom.ini
ADD templates/lemp/latest/config/mailhog/mailhog.ini            /etc/php/8.1/mods-available/php8.1-mailhog.ini
ADD templates/lemp/latest/config/php/upstream/8.1/upstream.conf /etc/nginx/upstream/php8.1-fpm.conf
ADD templates/lemp/latest/config/php/fpm/8.1/fpm.conf           /etc/php/8.1/fpm/pool.d/www.conf

ADD templates/lemp/latest/config/php/upstream/8.0/upstream.conf /etc/nginx/upstream/php8.0-fpm.conf
ADD templates/lemp/latest/config/php/fpm/8.0/fpm.conf /etc/php/8.0/fpm/pool.d/www.conf

ADD templates/lemp/latest/config/php/upstream/7.4/upstream.conf /etc/nginx/upstream/php7.4-fpm.conf
ADD templates/lemp/latest/config/php/fpm/7.4/fpm.conf /etc/php/7.4/fpm/pool.d/www.conf

# Here, we are gong to make sure tht some of the configurations are set for php8.1-fpm.
ADD templates/lemp/latest/config/supervisord/main.conf /etc/supervisor/conf.d/main.conf
ADD templates/lemp/latest/config/supervisord/start.sh /usr/local/bin/start

ADD templates/lemp/latest/config/mysql/my.cnf /root/.my.cnf
ADD templates/lemp/latest/config/mysql/my.cnf /home/docker/.my.cnf
RUN sudo mkdir -p /run/php && \
    sudo chmod +x /usr/local/bin/start

RUN sudo curl --silent -L -o /usr/local/bin/mailhog https://github.com/mailhog/MailHog/releases/download/v1.0.1/MailHog_linux_amd64 -o /usr/local/bin/mailhog && \
    sudo curl --silent -L -o /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 -o /usr/local/bin/mhsendmail && \
    sudo chmod +x /usr/local/bin/mailhog && \
    sudo chmod +x /usr/local/bin/mhsendmail

# Here, we are going to enable some php features
RUN sudo phpenmod php8.1-custom && \
    sudo phpenmod php8.1-mailhog

# Here, we are going to setup mysql server configurations, the stupid way but works.
RUN sudo service mysql start 2> /dev/null && \
    sudo service mysql reload && \
    sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'root';" && \
    sudo mysql -u root -e "GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" && \
    sudo mysql -u root -e "FLUSH PRIVILEGES;" && \
    sudo service mysql stop

CMD [ "start" ]