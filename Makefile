.PHONY: install test lint run build up down helm-lint

install:
	python -m pip install -r requirements-dev.txt

test:
	pytest -q

lint:
	ruff check app tests

run:
	uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload

build:
	docker build -t devops-platform-lab:local .

up:
	cp -n .env.example .env || true
	docker compose up --build -d

down:
	docker compose down

helm-lint:
	helm lint helm/devops-platform
