.PHONY: all

build: build-elixir build-golang build-javascript
build-%: $@
	docker build --tag "stress-test-demo/$(@:build-%=%)" --file "./$(@:build-%=%)/Dockerfile" "./$(@:build-%=%)"

launch: launch-elixir launch-golang launch-javascript
launch-%: $@
	docker-compose --project-name "stress-test-demo" --file "./$(@:launch-%=%)/docker-compose.yml" up -d

stop: stop-elixir stop-golang stop-javascript
stop-%: $@
	docker-compose --file "./$(@:stop-%=%)/docker-compose.yml" down

clear: clear-containers clear-images
clear-containers:
	EXITED="$(shell docker ps --quiet --filter status=exited)"; docker rm $$EXITED
clear-images:
	UNTAGGED="$(shell docker images | grep '<none>' | awk '{print $$3}')"; docker rmi $$UNTAGGED
