FROM debian:bookworm

#install mariadb database
RUN apt update -y && apt upgrade -y && apt-get install mariadb-server -y && rm -rf /var/lib/mysql/*

# add .conf file for mariadb
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# add and exec script mariadb installation
COPY /tools/init-mariadb.sh /tmp/init-mariadb.sh
COPY /conf/init.sql /tmp/init.sql

RUN chown -R mysql:mysql /etc/mysql && chmod +x /tmp/init-mariadb.sh

ENTRYPOINT ["sh", "/tmp/init-mariadb.sh"]