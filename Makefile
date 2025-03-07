IMAGE_NAME:=jecklgamis/springboot-java-example
IMAGE_TAG:=latest

default:
	cat ./Makefile
dist: keystore
	./mvnw clean package
image:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .
run:
	docker run -p 8080:8080  -p 8443:8443 $(IMAGE_NAME):$(IMAGE_TAG)
run-bash:
	docker run -i -t $(IMAGE_NAME):$(IMAGE_TAG) /bin/bash
keystore:
	@./generate-keystore.sh
all: dist image
push:
	 docker push $(IMAGE_NAME):$(IMAGE_TAG)
	 docker push $(IMAGE_NAME):latest
tag:
	 git tag -m "springboot-java-example-v$(IMAGE_TAG)" -a "v$(IMAGE_TAG)"
	 git push --tags
release-it: dist image push
	cd deployment/k8s && ./create-k8s-files.py --version $(IMAGE_TAG)
	kubectl apply -f deployment/k8s/deployment-$(IMAGE_TAG).yaml

