.PHONY: test


deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt


lint:
	flake8 hello_world test


test:
	PYTHONPATH=. py.test --verbose -s

test_cov:
	PYTHONPATH=. py.test --verbose -s --cov=.

test_xunit:
	PYTHONPATH=. py.test --verbose -s --cov=. --cov-report xml --junit-xml=test_results.xml

run:
	python main.py

docker_build:
	docker build -t hello-world-printer .

docker_run: docker_build
	docker run \
		--name hello-world-printer-dev \
		-p 5000:5000 \
		-d hello-world-printer

USERNAME=imbrra
TAG=$(USERNAME)/hello-world-se_hello_printer_app

docker_push: docker_build
	@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
	docker tag hello-world-printer $(TAG); \
	docker push $(TAG); \
	docker logout;
