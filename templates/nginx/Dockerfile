FROM benlumia007/ubuntu:20.04

# Here, we are going to set the frontend to no interactive.
ENV DEBIAN_FRONTEND=noninteractive

# Here we are going to run and update to make sure packages are up to date.
RUN sudo apt-get update -y

# Here, we are going to install Apache2 Server and install mysql-client
RUN sudo apt-get install --no-install-recommends \
    nginx \
    -y

ADD templates/nginx/config/supervisord/nginx.conf /etc/supervisor/conf.d/nginx.conf
ADD templates/nginx/config/supervisord/start.sh /usr/local/bin/start

RUN sudo chmod +x /usr/local/bin/start

CMD [ "start" ]