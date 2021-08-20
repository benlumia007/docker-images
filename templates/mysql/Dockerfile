FROM benlumia007/ubuntu:20.04

RUN apt-get update -y

RUN apt-get install --no-install-recommends \
	mysql-server \
	-y

# Config files
COPY templates/mysql/.my.cnf /root/.my.cnf
COPY templates/mysql/config /etc/mysql
COPY templates/mysql/docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 33060
CMD [ "mysqld" ]