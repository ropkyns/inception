FROM debian:bookworm

RUN apt update -y && \
	apt upgrade -y && \
	apt-get -y install wget \
	php \
	php-fpm \
	php-mysql \
	mariadb-client \
	default-mysql-client

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www && \
	cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz && \
	# chown -R root:root /var/www/html && \
	mkdir -p /run/php && chown -R www-data:www-data /var/www/wordpress

# add configuration file for php
COPY /conf/www.conf /etc/php/8.2/fpm/pool.d/.

COPY /conf/auto_config.sh /tmp/auto_config.sh

# install CLI to conf wp 
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

ENTRYPOINT ["sh", "/tmp/auto_config.sh"]