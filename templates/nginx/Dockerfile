FROM benlumia007/ubuntu:20.04

# Here, we are going to set the frontend to no interactive.
ENV DEBIAN_FRONTEND=noninteractive

# Here we are going to run and update to make sure packages are up to date.
RUN apt-get update -y

# Here, we are going to install Apache2 Server and install mysql-client
RUN apt-get install --no-install-recommends \
    mysql-client \
    nginx \
    -y

ADD templates/nginx/config/supervisord/nginx.conf /etc/supervisor/conf.d/nginx.conf

CMD [ "supervisord", "-n" ]