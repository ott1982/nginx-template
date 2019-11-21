clean:
	@echo "clean"

run: run-docker

run-docker:
	@echo "run-docker"
	docker-compose -f docker/docker-compose.yml up --force-recreate --remove-orphans
