DIR="./docker-compose.yml"

up:
	@sudo docker compose -f $(DIR) up --build -d

down:
	@sudo docker compose -f $(DIR) down -v

fclean:
	@sudo docker compose -f $(DIR) down -v
	@sudo docker system prune -af
	@sudo rm -rf /home/paulmart/data/mariadb/*
	@sudo rm -rf /home/paulmart/data/wordpress/*