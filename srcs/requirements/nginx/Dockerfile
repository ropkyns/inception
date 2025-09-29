FROM debian:bookworm

#install nginx & openssl
RUN apt update -y && \
	apt upgrade -y && \
	apt install -y nginx \
	openssl && \
	mkdir -p /etc/nginx/ssl && \
#creation certificat openssl sans action requise pour ne pas bloquer au build
	openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=paulmart.42.fr/UID=paulmart" && \
#cree un dossier pour nginx et copie le .conf dedans
	mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

#assure les droits 
RUN chmod 755 /var/www/html && \
	chown -R www-data:www-data /var/www/html

#lance le nginx en premier plan pour que le container ne se stop pas
CMD [ "nginx", "-g", "daemon off;" ]