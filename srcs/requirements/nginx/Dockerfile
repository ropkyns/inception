FROM alpine:3.22

#install nginx
RUN apk add --no-cache nginx

RUN adduser -D -g 'www' www

#start nginx when system reboots
RUN rc-update add nginx default

#start the nginx server
RUN service nginx start