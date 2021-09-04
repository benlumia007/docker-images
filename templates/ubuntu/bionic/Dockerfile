FROM ubuntu:18.04

# Here, we are going to set the frontend to no interactive.
ENV DEBIAN_FRONTEND=noninteractive

# Here we are going to run and update and upgrade packages.
RUN apt-get update -y
RUN apt-get upgrade -y

# Here, we are going to add some basic requirements
RUN apt-get install --no-install-recommends \
    build-essential \
    curl \
    dkms \
    gnupg \
    less \
    nano \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    software-properties-common \
    supervisor \
    sudo \
    unzip \
    wget \
    zip \
    -y