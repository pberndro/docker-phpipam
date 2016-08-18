FROM debian:jessie
MAINTAINER Philip Berndroth <p.berndroth@philuweb.de>

# Make Debconf less annoying
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

#update debian
RUN apt-get update && apt-get -y upgrade

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
