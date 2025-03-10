APP_NAME=sre-challenge
DOCKER_IMAGE=${DOCKER_USERNAME}/${APP_NAME}

.PHONY: build test lint run docker-build docker-run deploy clean

build:
	go build -o bin/${APP_NAME} ./cmd/main.go

test:
	go test ./...

lint:
	golint ./...

run:
	go run ./cmd/main.go

docker-build:
	docker build -t ${DOCKER_IMAGE}:latest .

docker-run:
	docker run -p 3000:3000 ${DOCKER_IMAGE}:latest

deploy:
	kubectl apply -f deployments/k8s/deployment.yaml
	kubectl apply -f deployments/k8s/service.yaml

clean:
	rm -rf bin/
