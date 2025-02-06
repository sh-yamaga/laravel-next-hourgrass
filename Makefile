COMPOSE_FILE := ./local-dev/docker-compose.yml
DOCKER_COMPOSE := docker compose -f $(COMPOSE_FILE)

.PHONY: build
build:
	@$(DOCKER_COMPOSE) build --no-cache

.PHONY: up
up:
	@$(DOCKER_COMPOSE) up -d

.PHONY: down
down:
	@$(DOCKER_COMPOSE) down

.PHONY: init api-init front-init
init: api-init front-init

api-init:
	@$(DOCKER_COMPOSE) run --rm api-service /bin/sh -c "npm install && composer install && cp .env.local .env && php artisan key:generate && php artisan migrate:fresh --seed"

front-init:
	@$(DOCKER_COMPOSE) run --rm front-web /bin/sh -c "npm install"