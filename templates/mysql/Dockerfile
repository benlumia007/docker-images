FROM benlumia007/ubuntu:20.04

# Here, we are going to set the frontend to no interactive.
ENV DEBIAN_FRONTEND=noninteractive

# Here, we are going to updae the package to grab the latest.
RUN apt-get update -y

# Here, we are going to install the latest mysql-server 8.0.
RUN apt-get install --no-install-recommends \
	mysql-server \
	-y

# Here we are going to remove some folders and recreate them
# while changing its permissions as well.
RUN rm -rf /var/lib/mysql && \
	rm -rf /var/run/mysqld && \
	mkdir -p /var/lib/mysql /var/run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
	chmod 777 /var/lib/mysql /var/run/mysqld

# Config files
COPY templates/mysql/.my.cnf /root/.my.cnf
RUN chmod +x /root/.my.cnf
COPY templates/mysql/config /etc/mysql
COPY templates/mysql/docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 33060
CMD [ "mysqld" ]