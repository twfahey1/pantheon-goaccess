FROM ubuntu:16.04

# Setup core utilities.
RUN apt-get update
RUN apt-get install wget build-essential libncursesw5-dev -y
# Set up GoAccess
RUN wget https://tar.goaccess.io/goaccess-1.3.tar.gz
RUN tar -xzvf goaccess-1.3.tar.gz
RUN cd goaccess-1.3/ && ./configure --enable-utf8 --enable-geoip && make && make install