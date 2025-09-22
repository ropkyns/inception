FROM debian:bookworm

#install mariadb database
RUN apt update -y
RUN apt upgrade -y
RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.cond.d/50-server.cnf

COPY /tools/init-mariadb.sh /tmp/init-mariadb.sh
ENTRYPOINT ["sh", "/tmp/init-mariadb.sh"]
