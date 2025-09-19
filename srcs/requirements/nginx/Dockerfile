FROM alpine:3.22

#start nginx when system reboots
RUN rc-update add nginx default

#install nginx
RUN apk add --no-cache -y nginx 
RUN apk add --no-cache -y OpenSSL

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=paulmart.42.fr/UID=paulmart"

RUN mkdir -p /var/run/nginx

RUN adduser -D -g 'www' www

#start the nginx server
RUN service nginx start
