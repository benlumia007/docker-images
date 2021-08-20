#!/bin/bash

_mysql_passfile() {
	if [ '--dont-use-mysql-root-password' != "$1" ] && [ -n "root" ]; then
		cat <<-EOF
			[client]
			password="root"
		EOF
	fi
}

# Here, we are going to setup some variables for later use. This allows us to use
# variables anywhere.
setup_environment_variables() {
	# declare a variable for data_directory and socket
	declare -g data_directory socket data_directory_exists

	# setup variable with data
	data_directory="var/lib/mysql"
	socket="/var/run/mysqld/mysqld.sock"

	if [[ -d "${data_directory}/mysql" ]]; then
		data_directory_exists='true'
	fi
}

# Here, we are going to initializes the database directory
initialize_database_directory() {
	"$@" --initialize-insecure --default-time-zone=SYSTEM
}

# Here, we are going to make sure that the root password is set up properly
processing_sql() {
	mysql --protocol=socket -uroot -hlocalhost --socket="${socket}"
}

# Initializes database with timezone info and root password, plus optional extra db/user
setup_database() {
	processing_sql --dont-use-mysql-root-password --database=mysql <<-EOSQL
		CREATE USER 'root'@'%' IDENTIFIED BY 'root';
		GRANT ALL ON *.* TO 'root'@'%' 	WITH GRANT OPTION;
		ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
		GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
		FLUSH PRIVILEGES;
		DROP DATABASE IF EXISTS test;
	EOSQL
}

# Do a temporary startup of the MySQL server, for init purposes
start_server() {
	if ! "$@" --daemonize --skip-networking --default-time-zone=SYSTEM --socket="${socket}"; then
		echo "Unable to start server."
	fi
}

# Stop the server. When using a local socket file mysqladmin will block until
# the shutdown is complete.
stop_server() {
	if ! mysqladmin --defaults-extra-file=<( _mysql_passfile ) shutdown -uroot --socket="${socket}"; then
		echo "Unable to shut down server."
	fi
}

start() {
	# skip setup if they aren't running mysqld or want an option that stops mysqld
	if [[ "$1" = 'mysqld' ]]; then
	
		# Load various environment variables
		setup_environment_variables "$@"

		# If container is started as root user, restart as dedicated mysql user
		if [ "$(id -u)" = "0" ]; then
			sudo -EH -u "mysql" "$BASH_SOURCE" "$@"
		fi

		# there's no database, so it needs to be initialized
		if [ -z "${data_directory_exists}" ]; then

			initialize_database_directory "$@"

			start_server "$@"

			setup_database

			stop_server
		fi
	fi
	exec "$@"
}

start "$@"