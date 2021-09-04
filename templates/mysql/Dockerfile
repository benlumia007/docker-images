FROM benlumia007/ubuntu:20.04

RUN apt-get update -y

RUN apt-get install --no-install-recommends \
	mysql-server \
	-y

# Config files
ADD templates/mysql/.my.cnf /root/.my.cnf
ADD templates/mysql/config/supervisord/mysqld.conf /etc/supervisor/conf.d/mysqld.conf

# Here, we are going to setup mysql server configurations, the stupid way but works.
RUN service mysql start 2> /dev/null && \
    service mysql reload && \
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'root';" && \
    mysql -u root -e "GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" && \
    mysql -u root -e "FLUSH PRIVILEGES;" && \
    service mysql stop


CMD [ "supervisord", "-n" ]