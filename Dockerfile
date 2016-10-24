FROM ubuntu:16.04

RUN rm /var/lib/apt/lists/* -f && apt-get update && apt-get install -y php \
	php-fpm \
	nginx \
	php-mysql \
	curl \
	tar \
	php-curl \
	php-gd \
	php-intl \
	php-pear \
	php-imagick \
	php-imap \
	php-mcrypt \
	php-memcache \
	php-pspell \
	ca-certificates \
	--no-install-recommends apt-utils

RUN curl https://wordpress.org/latest.tar.gz | tar xz \
	&& mv wordpress/* /var/www/html 

COPY ./nginx-default /etc/nginx/sites-available/default
COPY ./start.sh /start.sh

RUN chown -R www-data:www-data /var/www/html \
	&& chmod g+w /var/www/html/wp-content \
	&& chmod -R g+w /var/www/html/wp-content/themes \
	&& chmod -R g+w /var/www/html/wp-content/plugins \
	&& echo "cgi.fix_pathinfo=0" >> /etc/php/7.0/fpm/php.ini \
	&& chmod 755 /start.sh

EXPOSE 80

CMD bash -c './start.sh'; 'bash'
