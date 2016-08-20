FROM debian:jessie
MAINTAINER Philip Berndroth <p.berndroth@philuweb.de>

# Make Debconf less annoying
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

# update debian
RUN apt-get update && apt-get -y upgrade

# install some tools
RUN apt-get -y install curl

# install webserver
RUN apt-get -y install apache2

# install php modules
RUN apt-get -y install libapache2-mod-php5 php-pear php5-curl php5-mysql php5-json php5-gmp php5-mcrypt php5-ldap

# remove tmp files
RUN apt-get clean

# enable modules for php and apache
RUN /usr/sbin/php5enmod mcrypt
RUN a2enmod rewrite

# remove default apache index.html
RUN rm /var/www/html/index.html

# fill the environment variables with defaults
ENV PHPIPAM_SOURCE="https://github.com/phpipam/phpipam/archive/" \
    PHPIPAM_VERSION="1.2" \
    MYSQL_HOST="mysql" \
    MYSQL_USER="phpipam" \
    MYSQL_PASSWORD="phpipamadmin" \
    MYSQL_DB="phpipam" \
    MYSQL_PORT="3306"

# copy phpipam sources to web dir
ADD ${PHPIPAM_SOURCE}/${PHPIPAM_VERSION}.tar.gz /tmp/
RUN tar xzf /tmp/${PHPIPAM_VERSION}.tar.gz -C /var/www/html/ --strip-components=1

# create config file
RUN cp /var/www/html/config.dist.php /var/www/html/config.php

# copy system environment variables into config.php with the good old sed
RUN sed -i \ 
    -e "s/\['host'\] = \"localhost\"/\['host'\] = getenv(\"MYSQL_HOST\")/" \ 
        -e "s/\['user'\] = \"phpipam\"/\['user'\] = getenv(\"MYSQL_USER\")/" \ 
        -e "s/\['pass'\] = \"phpipamadmin\"/\['pass'\] = getenv(\"MYSQL_PASSWORD\")/" \ 
        -e "s/\['name'\] = \"phpipam\"/\['name'\] = getenv(\"MYSQL_DB\")/" \ 
        -e "s/\['port'\] = 3306/\['port'\] = getenv(\"MYSQL_PORT\")/" \ 
        /var/www/html/config.php

WORKDIR /
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
