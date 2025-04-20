# Container names
FRONTEND_CONTAINER=apple-orange-frontend
GATEWAY_CONTAINER=apple-orange-gateway
BACKEND_CONTAINER=apple-orange-backend
POSTGRES_CONTAINER=apple-orange-postgres
REDIS_CONTAINER=apple-orange-redis

# Docker image tags
FRONTEND_IMAGE=apple-orange-frontend
GATEWAY_IMAGE=apple-orange-gateway
BACKEND_IMAGE=apple-orange-backend
POSTGRES_IMAGE=postgres:16-alpine
REDIS_IMAGE=redis:latest

# Docker network name
NETWORK_NAME=apple-orange-net

# Create the Docker network if it doesn't exist
network:
	@echo "Creating network $(NETWORK_NAME) if not exists..."
	-@docker network create $(NETWORK_NAME)

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

# Run all Docker containers (including Redis) on the network
run-all: network run-redis run-db run-backend run-frontend run-gateway

run-redis:
	@echo "🟢 Running Redis container..."
	docker run -d \
	  --name $(REDIS_CONTAINER) \
	  --network $(NETWORK_NAME) \
	  -p 6379:6379 \
	  $(REDIS_IMAGE)

run-db:
	@echo "🐘 Running PostgreSQL container..."
	docker run -d \
	  --name $(POSTGRES_CONTAINER) \
	  --network $(NETWORK_NAME) \
	  -e POSTGRES_USER=postgres \
	  -e POSTGRES_PASSWORD=password \
	  -e POSTGRES_DB=apple_orange \
	  -p 5432:5432 \
	  $(POSTGRES_IMAGE)

run-backend:
	@echo "🟣 Running backend container..."
	docker run -d \
	  --name $(BACKEND_CONTAINER) \
	  --network $(NETWORK_NAME) \
	  -e DATABASE_URL=postgres://postgres:password@$(POSTGRES_CONTAINER):5432/apple_orange \
	  -e REDIS_URL=redis://$(REDIS_CONTAINER):6379 \
	  -p 4000:4000 \
	  $(BACKEND_IMAGE)

run-frontend:
	@echo "🟢 Running frontend container..."
	docker run -d \
	  --name $(FRONTEND_CONTAINER) \
	  --network $(NETWORK_NAME) \
	  -p 3000:3000 \
	  $(FRONTEND_IMAGE)

run-gateway:
	@echo "🔵 Running gateway container..."
	docker run -d \
	  --name $(GATEWAY_CONTAINER) \
	  --network $(NETWORK_NAME) \
	  -e BACKEND_URL=http://$(BACKEND_CONTAINER):4000 \
	  -e FRONTEND_URL=http://$(FRONTEND_CONTAINER):3000 \
	  -p 80:80 \
	  $(GATEWAY_IMAGE)

# Stop all containers
stop-all:
	@echo "🛑 Stopping all containers..."
	docker stop $(GATEWAY_CONTAINER) $(FRONTEND_CONTAINER) $(BACKEND_CONTAINER) $(POSTGRES_CONTAINER) $(REDIS_CONTAINER) || true

# Remove all containers
clean-containers:
	@echo "🗑️ Removing all containers..."
	docker rm $(GATEWAY_CONTAINER) $(FRONTEND_CONTAINER) $(BACKEND_CONTAINER) $(POSTGRES_CONTAINER) $(REDIS_CONTAINER) || true

# Remove all images
clean-images:
	@echo "🧹 Removing Docker images..."
	docker rmi $(GATEWAY_IMAGE) $(FRONTEND_IMAGE) $(BACKEND_IMAGE)

# Full clean-up
clean: stop-all clean-containers clean-images

# Rebuild and run everything fresh
restart: clean build-all run-all

.PHONY: network build-all build-frontend build-backend build-gateway \
        run-all run-redis run-db run-backend run-frontend run-gateway \
        stop-all clean-containers clean-images clean restart
