create-migration: ## Create a new migration file with the corresponding timestamp, pass "name=[name_of_migration]" as second argument
	touch migrations/$(shell date '+%s')_$(name).up.sql
	touch migrations/$(shell date '+%s')_$(name).down.sql


migrations-up: ## Run migrations defined on migrations folder using docker-compose
	@echo "Running docker compose migrations"
	docker-compose build --no-cache migrations
	docker-compose run migrations up

migrations-down: ## Run migrations folder with option down
	@echo "Running docker compose migrations"
	docker-compose build --no-cache migrations
	docker-compose run migrations down 1
