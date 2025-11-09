.PHONY: help init up down restart shell logs install migrate seed fresh test build build-prod verify

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: ## Initialize project (run this first!)
	@echo "Initializing project..."
	@bash init-project.sh

change-port: ## Change application port
	@echo "Changing port..."
	@bash change-port.sh

up: ## Start development environment
	docker compose up -d
	@echo "Containers started successfully!"
	@if [ -f .env ]; then \
		APP_PORT=$$(grep "^APP_PORT=" .env | cut -d'=' -f2); \
		VITE_PORT=$$(grep "^VITE_PORT=" .env | cut -d'=' -f2); \
		DB_PORT=$$(grep "^DB_PORT=" .env | cut -d'=' -f2); \
		if [ -n "$$APP_PORT" ]; then \
			echo "Application: http://localhost:$$APP_PORT"; \
			echo "Vite HMR: http://localhost:$$VITE_PORT"; \
			echo "MongoDB: mongodb://localhost:$${DB_PORT:-27017}"; \
		else \
			echo "Check your .env file for configured ports"; \
		fi \
	fi

down: ## Stop development environment
	docker compose down

restart: ## Restart all containers
	docker compose restart

shell: ## Access app container shell
	docker compose exec app bash

shell-node: ## Access vite container shell
	docker compose exec vite sh

logs: ## View container logs
	docker compose logs -f

logs-app: ## View app container logs
	docker compose exec app php artisan pail

logs-nginx: ## View nginx container logs
	docker compose logs -f nginx

install: ## Install PHP and Node dependencies
	docker compose exec app composer install --ignore-platform-reqs
	docker compose exec vite npm install

migrate: ## Run database migrations
	docker compose exec app php artisan migrate

seed: ## Run database seeders
	docker compose exec app php artisan db:seed

fresh: ## Fresh database with seeders
	docker compose exec app php artisan migrate:fresh --seed

test: ## Run tests
	docker compose exec app php artisan test

test-frontend: ## Run frontend tests
	docker compose exec vite npm run test

key-generate: ## Generate application key
	docker compose exec app php artisan key:generate

cache-clear: ## Clear all caches
	docker compose exec app php artisan cache:clear
	docker compose exec app php artisan config:clear
	docker compose exec app php artisan route:clear
	docker compose exec app php artisan view:clear

optimize: ## Optimize application for production
	docker compose exec app php artisan config:cache
	docker compose exec app php artisan route:cache
	docker compose exec app php artisan view:cache

build: ## Build Docker images
	docker compose build

build-prod: ## Build production Docker images
	docker compose -f docker-compose.prod.yml build

prod-up: ## Start production environment
	docker compose -f docker-compose.prod.yml up -d

prod-down: ## Stop production environment
	docker compose -f docker-compose.prod.yml down

status: ## Show container status
	docker compose ps

clean: ## Remove all containers, volumes and images
	docker compose down -v --rmi all

verify: ## Run automated verification tests
	@bash verify-setup.sh
