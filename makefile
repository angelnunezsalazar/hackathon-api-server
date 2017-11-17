unit-tests:
	docker build -t alarmareloj .
	docker run -t alarmareloj rspec tests/unit_tests.rb

api-tests:
	docker build -t alarmareloj .
	docker run -t alarmareloj rspec tests/api_tests.rb

web-tests:
	docker build -t alarmareloj .
	docker run -t alarmareloj rspec tests/web_tests.rb