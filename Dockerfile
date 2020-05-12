FROM ubuntu:16.04

# Set up core utilities.
RUN apt-get update
RUN apt-get install wget build-essential libncursesw5-dev php curl git zip unzip php-xml vim-tiny -y
# Set up GoAccess
RUN wget https://tar.goaccess.io/goaccess-1.3.tar.gz
RUN tar -xzvf goaccess-1.3.tar.gz
RUN cd goaccess-1.3/ && ./configure --enable-utf8 --enable-geoip && make && make install
# Append necessary config for parsing Pantheon log files per https://pantheon.io/docs/nginx-access-log#edit-goaccess-configuration

RUN echo "time-format %H:%M:%S" >> /usr/local/etc/goaccess/goaccess.conf
RUN echo "date-format %d/%b/%Y" >> /usr/local/etc/goaccess/goaccess.conf
RUN echo 'log-format %^ - %^ [%d:%t %^]  "%r" %s %b "%R" "%u" %T ~h{," }' >> /usr/local/etc/goaccess/goaccess.conf

# Set up Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Set up Terminus
RUN composer require pantheon-systems/terminus:2.3
RUN mkdir ~/.terminus
RUN mkdir ~/.terminus/plugins
RUN git clone https://github.com/jfussion/terminus-get-logs.git ~/.terminus/plugins/terminus-get-logs