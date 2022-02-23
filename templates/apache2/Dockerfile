FROM benlumia007/ubuntu:20.04

# Here, we are going to set the frontend to no interactive.
ENV DEBIAN_FRONTEND=noninteractive

# Here we are going to run and update to make sure packages are up to date.
RUN sudo apt-get update -y

# Here, we are going to install Apache2 Server and install mysql-client
RUN sudo apt-get install --no-install-recommends \
    apache2 \
    -y

# Here, we are going to install fcgid so that we can use multiple PHP versions.
RUN sudo apt-get install --no-install-recommends \
    libapache2-mod-fcgid \
    -y

# Here, we are going to enabled some features for apache2 server
RUN sudo a2enmod headers ssl rewrite actions fcgid alias proxy_fcgi

# Here, we are going to disable and remove the default sites
RUN sudo a2dissite 000-default.conf
RUN sudo a2dissite default-ssl.conf 
RUN sudo rm -rf /etc/apache2/sites-available/000-default.conf
RUN sudo rm -rf /etc/apache2/sites-available/default-ssl.conf

ADD templates/apache2/config/supervisord/apache2.conf /etc/supervisor/conf.d/apache2.conf
ADD templates/apache2/config/supervisord/start.sh /usr/local/bin/start

RUN sudo chmod +x /usr/local/bin/start

CMD [ "start" ]