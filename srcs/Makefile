DIR="./docker-compose.yml"

up:
	@sudo docker compose -f $(DIR) up --build -d

down:
	@sudo docker compose -f $(DIR) down -v

fclean:
	@sudo docker system prune -af