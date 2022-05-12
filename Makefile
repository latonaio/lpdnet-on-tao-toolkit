# Self-Documented Makefile
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

tao-docker-run: ## TAO用コンテナを建てる
	docker-compose -f docker-compose.yaml up -d

tao-docker-build: ## TAO用コンテナをビルド
	docker-compose -f docker-compose.yaml build

tao-convert:
	docker exec -it lpdnet-tao-toolkit tao-converter -k nvidia_tlt -p Input,1x3x480x640,4x3x480x640,16x3x480x640 \
		-t fp16 -d 3,480,640 -e /app/src/lpdnet_usa.engine /app/src/yolov4_tiny_usa_deployable.etlt

tao-docker-login: ## TAO用コンテナにログイン
	docker exec -it lpdnet-tao-toolkit bash
