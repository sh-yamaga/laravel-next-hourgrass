## docker: Define Docker Compose file and command.
COMPOSE_FILE := ./local-dev/docker-compose.yml
DOCKER_COMPOSE := docker compose -f $(COMPOSE_FILE)

## command list: Define commands for initializing and caching.
API_INIT_CMDS := npm install && composer install && cp .env.local .env && php artisan key:generate && php artisan migrate:fresh --seed
API_CACHE_CMDS := composer dump-autoload && php artisan clear-compiled && php artisan optimize && php artisan config:cache
FRONT_INIT_CMDS := rm -r .next && npm install

## targets: Define Makefile targets for Docker operations and service initialization.
### build: Build the Docker container images without using cache.
.PHONY: build
build:
	@$(DOCKER_COMPOSE) build --no-cache

### up: Start and attach the Docker container images in detached mode.
.PHONY: up
up:
	@$(DOCKER_COMPOSE) up -d

### down: Stop and remove containers and networks.
.PHONY: down
down:
	@$(DOCKER_COMPOSE) down

### api-init: Initialize api-service by installing packages, setting up Laravel, and migrating the database.
.PHONY: api-init
api-init:
	@$(DOCKER_COMPOSE) run --rm api-service /bin/sh -c "$(API_INIT_CMDS)"

### front-init: Initialize front-web by installing packages and removing caches.
.PHONY: front-init
front-init:
	@$(DOCKER_COMPOSE) run --rm front-web /bin/sh -c "$(FRONT_INIT_CMDS)"

### cache-clear: Clear caches for the api-service.
.PHONY: cache-clear
cache-clear:
	@$(DOCKER_COMPOSE) run --rm api-service /bin/sh -c "$(API_CACHE_CMDS)"

### init: Initialize the entire application by building, initializing services, clearing caches, and shutting down.
.PHONY: init
init: build api-init cache-clear front-init down
