# Makefile of Inception

name = inception

# make
# docker-compose to start the services in the background (-d)
# --env-file flag loads environment variables from srcs/.env
all:
	@printf "Launch configuration ${name}...\n"
	@bash srcs/requirements/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

# make build
# similar to all but forces a rebuild of images using --build
build:
	@printf "Building configuration ${name}...\n"
	@bash srcs/requirements/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

# make down
# stops and removes containers defined in docker-compose.yml
down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

# make re
# runs down first to stop everything then rebuilds and restarts all services
re: down
	@printf "Rebuild configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

# make clean
# runs down to stop containers
# cleans unused Docker resources (docker system prune -a)
# deletes local data stored for WordPress and MariaDB
clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

# make fclean
# stops all running Docker containers
# removes all Docker resources (containers, images, networks, volumes)
# deletes WordPress and MariaDB data directories
fclean:
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

# marks these targets as always executable, preventing conflicts with existing files
.PHONY	: all build down re clean fclean
