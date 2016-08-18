FROM debian:jessie
MAINTAINER Philip Berndroth <p.berndroth@philuweb.de>

#update debian
RUN apt-get update && apt-get -y upgrade

# Installing the 'apt-utils' package gets rid of the 'debconf: delaying package configuration, since apt-utils is not installed'
# error message when installing any other package with the apt-get package manager.
RUN apt-get -y install apt-utils

#install some tools
RUN apt-get -y install curl 

#install webserver
RUN apt-get -y install apache2

#install php modules
RUN apt-get -y install libapache2-mod-php5 php-pear php5-curl php5-mysql php5-json php5-gmp php5-mcrypt php5-ldap

#remove tmp files
RUN apt-get clean

RUN /usr/sbin/php5enmod mcrypt

COPY test.php /var/www/html/

WORKDIR /
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
