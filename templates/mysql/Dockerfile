FROM benlumia007/ubuntu:20.04

RUN apt-get update -y

RUN apt-get install --no-install-recommends \
	mysql-server \
	-y

RUN rm -rf /var/lib/apt/lists/* \
	&& rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
	&& chmod 1777 /var/run/mysqld /var/lib/mysql

RUN mkdir /docker-entrypoint-initdb.d

VOLUME /var/lib/mysql

# Config files
COPY templates/mysql/.my.cnf /root/.my.cnf
COPY templates/mysql/config /etc/mysql
COPY templates/mysql/docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 33060
CMD [ "mysqld" ]