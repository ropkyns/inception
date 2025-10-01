FROM debian:bookworm

#install mariadb database
RUN apt update -y && apt upgrade -y && apt-get install mariadb-server -y

# add .conf file for mariadb
COPY conf/50-server.cnf /etc/mysql/mariadb.cond.d/50-server.cnf

# add and exec script mariadb installation 
COPY /tools/init-mariadb.sh /tmp/init-mariadb.sh

RUN chown -R mysql:mysql /etc/mysql && chmod 777 /tmp/init-mariadb.sh

ENTRYPOINT ["/tmp/init-mariadb.sh"]