FROM benlumia007/ubuntu:20.04

RUN sudo apt-get update -y

RUN sudo apt-get install --no-install-recommends \
	mysql-server \
	-y

# Config files
ADD templates/mysql/.my.cnf /root/.my.cnf
ADD templates/mysql/.my.cnf /home/docker/.my.cnf
ADD templates/mysql/config/supervisord/mysqld.conf /etc/supervisor/conf.d/mysqld.conf
ADD templates/mysql/config/supervisord/start.sh /usr/local/bin/start

RUN sudo chmod +x /usr/local/bin/start

# Here, we are going to setup mysql server configurations, the stupid way but works.
RUN sudo service mysql start 2> /dev/null && \
    sudo service mysql reload && \
    sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'root';" && \
    sudo mysql -u root -e "GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" && \
    sudo mysql -u root -e "FLUSH PRIVILEGES;" && \
    sudo service mysql stop


CMD [ "start" ]