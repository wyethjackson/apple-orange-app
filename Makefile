# Container names
FRONTEND_CONTAINER=apple-orange-web-app
GATEWAY_CONTAINER=apple-orange-gateway
BACKEND_CONTAINER=apple-orange-api
POSTGRES_CONTAINER=apple-orange-postgres

# Docker image tags
FRONTEND_IMAGE=apple-orange-web-app
GATEWAY_IMAGE=apple-orange-gateway
BACKEND_IMAGE=apple-orange-api
POSTGRES_IMAGE=postgres:16-alpine

# Build all Docker images
build-all: build-frontend build-backend build-gateway

build-frontend:
	@echo "🟢 Building frontend Docker image..."
	cd apple-orange-web-app && docker build -t $(FRONTEND_IMAGE) .

build-backend:
	@echo "🟣 Building backend Docker image..."
	cd apple-orange-api && docker build -t $(BACKEND_IMAGE) .

build-gateway:
	@echo "🔵 Building gateway Docker image..."
	cd apple-orange-gateway && docker build -t $(GATEWAY_IMAGE) .

# Run all Docker containers
run-all: run-db run-backend run-frontend run-gateway

run-db:
	@echo "🐘 Running PostgreSQL container..."
	docker run -d \
		--name $(POSTGRES_CONTAINER) \
		-e POSTGRES_USER=postgres \
		-e POSTGRES_PASSWORD=password \
		-e POSTGRES_DB=apple_orange \
		-p 5432:5432 \
		$(POSTGRES_IMAGE)

run-backend:
	@echo "🟣 Running backend container..."
	docker run -d \
		--name $(BACKEND_CONTAINER) \
		--link $(POSTGRES_CONTAINER):postgres \
		-e DB_HOST=postgres \
		-p 4000:4000 \
		$(BACKEND_IMAGE)

run-frontend:
	@echo "🟢 Running frontend container..."
	docker run -d \
		--name $(FRONTEND_CONTAINER) \
		-p 3000:3000 \
		$(FRONTEND_IMAGE)

run-gateway:
	@echo "🔵 Running gateway container..."
	docker run -d \
		--name $(GATEWAY_CONTAINER) \
		--link $(BACKEND_CONTAINER):apple-orange-api \
		--link $(FRONTEND_CONTAINER):apple-orange-web-app \
		-p 80:80 \
		$(GATEWAY_IMAGE)

# Stop all containers
stop-all:
	@echo "🛑 Stopping all containers..."
	docker stop $(GATEWAY_CONTAINER) $(FRONTEND_CONTAINER) $(BACKEND_CONTAINER) $(POSTGRES_CONTAINER)

# Remove all containers
clean-containers:
	@echo "🗑️ Removing all containers..."
	docker rm $(GATEWAY_CONTAINER) $(FRONTEND_CONTAINER) $(BACKEND_CONTAINER) $(POSTGRES_CONTAINER)

# Remove all images
clean-images:
	@echo "🧹 Removing Docker images..."
	docker rmi $(GATEWAY_IMAGE) $(FRONTEND_IMAGE) $(BACKEND_IMAGE)

# Full clean-up
clean: stop-all clean-containers clean-images

# Rebuild and run everything fresh
restart: clean build-all run-all

.PHONY: build-all build-frontend build-backend build-gateway \
        run-all run-db run-backend run-frontend run-gateway \
        stop-all clean-containers clean-images clean restart
