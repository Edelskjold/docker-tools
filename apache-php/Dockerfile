FROM ubuntu:latest

MAINTAINER Mads K. Edelskjold <mads@edelskjold.dk>

# Update and Upgrade to get newest mirror files
RUN apt-get update
RUN apt-get -y upgrade

# Install dependencies for apache and php webbased container
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client apache2 libapache2-mod-php5 php5-gd php-apc php5-curl curl lynx-cur php5-mysql php-pear

# Run a2enmod to enable apache modules
RUN a2enmod rewrite
RUN a2enmod php5

# Enable php short tags, and set silent logging in php.ini
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php5/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php5/apache2/php.ini

# Setup the variables for the apache environment
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2


EXPOSE 80

ADD www /var/www/site

# Update the default apache configuration
ADD apache-sites.conf /etc/apache2/sites-enabled/000-default.conf

# By default, simply start apache.
CMD /usr/sbin/apache2ctl -D FOREGROUND
