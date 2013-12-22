test:
	./node_modules/.bin/mocha test/*_test.pogo

chromedriver:
	./node_modules/chromedriver/bin/chromedriver

example:
	./node_modules/.bin/pogo example.pogo

.PHONY :test