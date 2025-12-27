#!/bin/bash

#System up to date:

sudo apt update
sudo apt upgrade -y

#Download and Install the docker repository:

sudo apt install -y ca-certificates curl gnupg lsb-release

#After the package installation, we need to add Docker’s GPG Key to our system by running the following commands:

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

#Now we can install the docker repository by running the following commands:

sudo echo  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

#Installing Docker:

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

#Start Docker:

sudo systemctl start docker

sudo docker run hello-world

#To install docker-compose run the following commands:

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#Creating directories:
mkdir -p /home/ubuntu/wordpress /home/ubuntu/apache-php

#Create dockerfiles in each directory:

cat <<'EOL' > /home/ubuntu/wordpress/Dockerfile
FROM wordpress:latest

WORKDIR /var/www/html

RUN rm -rf *

COPY . /var/www/html/
EOL

cat <<'EOL' > /home/ubuntu/apache-php/Dockerfile
FROM php:apache

RUN a2enmod rewrite

RUN docker-php-ext-install mysqli pdo pdo_mysql

WORKDIR /var/www/html
EOL

#Docker compose file:

cat <<'EOL' > /home/ubuntu/compose.yaml
version: "3"

services:
  wordpress:
    image: wordpress:latest
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: ${rds_endpoint}
      WORDPRESS_DB_USER: ${db_username}
      WORDPRESS_DB_PASSWORD: ${db_password}
      WORDPRESS_DB_NAME: ${db_name}
    volumes:
      - wordpress_data:/var/www/html

volumes:
  wordpress_data:
EOL
# my-rds-instance.c7ueomi6yzcn.eu-west-2.rds.amazonaws.com
# Build images (even though WP uses official image)

sudo docker build -t my-wordpress-image -f /home/ubuntu/wordpress/Dockerfile /home/ubuntu/wordpress
sudo docker build -t my-apache-php-image -f /home/ubuntu/apache-php/Dockerfile /home/ubuntu/apache-php

# Start services

sudo docker compose -f /home/ubuntu/compose.yaml up -d






