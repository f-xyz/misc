.PHONY: compile test watch clean

all: compile test clean

compile:
	coffee -c *.coffee test/*.coffee

test:
	mocha --compilers coffee:coffee-script/register -R spec
	istanbul cover _mocha

watch:
	mocha --compilers coffee:coffee-script/register -R spec --watch

clean:
	rm validation.js test/*.js