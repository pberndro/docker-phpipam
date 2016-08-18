FROM debian:jessie
MAINTAINER Philip Berndroth <p.berndroth@philuweb.de>

RUN apt-get update && apt-get -y upgrade && apt-get clean
RUN apt-get -y install apache2 && apt-get clean
RUN apt-get -y install libapache2-mod-php5 php-pear php5-curl php5-mysql php5-json php5-gmp php5-mcrypt php5-ldap && apt-get clean
RUN /usr/sbin/php5enmod mcrypt

COPY test.php /var/www/html/

WORKDIR /
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
