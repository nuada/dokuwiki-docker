FROM ubuntu:14.04
MAINTAINER Piotr Radkowski <piotr.radkowski@uj.edu.pl>

ENV DEBIAN_FRONTEND noninteractive

# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
RUN echo 'force-unsafe-io' | tee /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN echo 'DPkg::Post-Invoke {"/bin/rm -f /var/cache/apt/archives/*.deb || true";};' | tee /etc/apt/apt.conf.d/no-cache

# Setup apache
RUN apt-get update && \
	apt-get install -y curl apache2 libapache2-mod-php5 php5-ldap php5-gd && \
	a2enmod rewrite
RUN apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/*

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOCK_DIR /var/run/apache2

# Install Dokuwiki
RUN mkdir -p /var/www && \
	curl http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz | \
		tar xz -C /var/www --strip 1
RUN find /var/www -type d | grep lang | \
		grep -v '/pl$' | grep -v '/en' | \
		grep -v '/lang$' | sort -u | xargs rm -rf && \
	rm /var/www/install.php
ADD dokuwiki/*.php /var/www/conf/
RUN chown -R www-data:www-data /var/www

# Add Active Directory CA certificate
RUN cat /var/www/conf/*.pem >> /etc/ssl/certs/ca-certificates.crt && \
	rm -f /var/www/conf/*.pem

# Default apache vhost
RUN rm /etc/apache2/sites-enabled/*
ADD apache/default.conf /etc/apache2/sites-enabled/

VOLUME /var/www/data
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
