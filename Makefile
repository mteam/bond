test:
	./node_modules/.bin/mocha \
		--compilers coffee:coffee-script \
		--require should \
		test/**/*.coffee

.PHONY: test
