FROM benlumia007/ubuntu:20.04

# Here, we are going to set the frontend to no interactive.
ENV DEBIAN_FRONTEND=noninteractive

# Here, we are going to grab some ppa packages
RUN sudo add-apt-repository ppa:ondrej/php -y

## Here we are going to run and update for the latest packages.
RUN sudo apt-get update -y

# Here, we are going to install the apache2 server.
RUN sudo apt-get install --no-install-recommends \
    apache2 \
    -y

# Here, we are going to install mysql server.
RUN sudo apt-get install --no-install-recommends \
    mysql-server \
    -y

# Here, we are going to install some basic packages to get the server going.
RUN sudo apt-get install --no-install-recommends \
    libapache2-mod-fcgid \
    php-imagick \
    php-memcache \
    php-memcached \
    php-pear \
    php-ssh2 \
    -y

# Here, we are going to install PHP 7.3 and 8.0
RUN sudo apt-get install --no-install-recommends \
    php7.3-bcmath \
    php7.3-cli \
    php7.3-common \
    php7.3-curl \
    php7.3-dev \
    php7.3-fpm \
    php7.3-gd \
    php7.3-imap \
    php7.3-imagick \
    php7.3-intl \
    php7.3-json \
    php7.3-mbstring \
    php7.3-mysql \
    php7.3-soap \
    php7.3-xml \
    php7.3-zip \
    -y

# Here, we are going to enabled some features for apache2 server
RUN sudo a2enmod headers ssl rewrite actions fcgid alias proxy_fcgi

# Here, we are going to disable and remove the default sites
RUN sudo a2dissite 000-default.conf && \
    sudo a2dissite default-ssl.conf && \
    sudo rm -rf /etc/apache2/sites-available/000-default.conf && \
    sudo rm -rf /etc/apache2/sites-available/default-ssl.conf

# Here, we are gong to make sure tht some of the configurations are set first.
ADD templates/lamp/7.3/config/apache2/envvars /etc/apache2/envvars
ADD templates/lamp/7.3/config/php/custom/php-custom.ini /etc/php/7.3/mods-available/php-custom.ini
ADD templates/lamp/7.3/config/php/fpm/www.conf /etc/php/7.3/fpm/pool.d/www.conf
ADD templates/lamp/7.3/config/mailhog/mailhog.ini /etc/php/7.3/mods-available/php-mailhog.ini
ADD templates/lamp/7.3/config/supervisord/lamp.conf /etc/supervisor/conf.d/lamp.conf
ADD templates/lamp/7.3/config/supervisord/start.sh /usr/local/bin/start
ADD templates/lamp/7.3/config/mysql/.my.cnf /root/.my.cnf
ADD templates/lamp/7.3/config/mysql/.my.cnf /home/docker/.my.cnf

RUN sudo mkdir -p /run/php && \
    sudo rm -rf /etc/apache2/conf-available/other-vhosts-access-log.conf && \
    sudo chmod +x /usr/local/bin/start

# Here, we are going to enable some php features
RUN sudo phpenmod php-custom && \
    sudo phpenmod php-mailhog

# Here, we are going to setup mysql server configurations, the stupid way but works.
RUN sudo service mysql start 2> /dev/null && \
    sudo service mysql reload && \
    sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'root';" && \
    sudo mysql -u root -e "GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" && \
    sudo mysql -u root -e "FLUSH PRIVILEGES;" && \
    sudo service mysql stop

RUN sudo curl --silent -L -o /usr/local/bin/mailhog https://github.com/mailhog/MailHog/releases/download/v1.0.1/MailHog_linux_amd64 -o /usr/local/bin/mailhog
RUN sudo curl --silent -L -o /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 -o /usr/local/bin/mhsendmail
RUN sudo chmod +x /usr/local/bin/mailhog
RUN sudo chmod +x /usr/local/bin/mhsendmail

USER docker

WORKDIR /home/docker

CMD [ "start" ]