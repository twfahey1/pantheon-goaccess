FROM ubuntu:16.04

# Set up core utilities.
RUN apt-get update
RUN apt-get install wget build-essential libncursesw5-dev php curl git zip unzip php-xml -y
# Set up GoAccess
RUN wget https://tar.goaccess.io/goaccess-1.3.tar.gz
RUN tar -xzvf goaccess-1.3.tar.gz
RUN cd goaccess-1.3/ && ./configure --enable-utf8 --enable-geoip && make && make install

# Set up Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Set up Terminus
RUN composer require pantheon-systems/terminus:2.3
