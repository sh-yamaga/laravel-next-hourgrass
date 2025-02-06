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

.PHONY: init api-init front-init cache-clear
init: build api-init cache-clear front-init down

api-init:
	@$(DOCKER_COMPOSE) run --rm api-service /bin/sh -c "npm install && composer install && composer update && cp .env.local .env && php artisan key:generate && php artisan migrate:fresh --seed"

front-init:
	@$(DOCKER_COMPOSE) run --rm front-web /bin/sh -c "rm -r .next && npm install"

cache-clear:
	@$(DOCKER_COMPOSE) run --rm api-service /bin/sh -c "composer dump-autoload && php artisan clear-compiled && php artisan optimize && php artisan config:cache"
