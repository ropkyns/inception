FROM alpine:3.22

#install mariadb database
RUN apk add --no-cache mariadb mariadb-client

RUN mkdir /data

#initialize new database
RUN mariadb-install-db --datadir=/data

#start mariadb when system reboots
RUN rc-update add mariadb default

#start database
RUN exec mariadb &
