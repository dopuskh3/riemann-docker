

build:
	docker build -t riemann --rm .

run:
	docker run -p 4567:4567 -p 5555:5555 -p 5556:5556 -p 5555:5555/udp riemann

