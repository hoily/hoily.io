BASEDIR=$(PWD)
ENV=$(BASEDIR)/env/bin
NODE_BIN=$(BASEDIR)/node_modules/.bin
PELICAN=$(ENV)/pelican

OUTPUTDIR=$(BASEDIR)/output
CONFIG_FILE=$(BASEDIR)/pelicanconf.py


build: install
	rm -rf $(OUTPUTDIR)/*
	mkdir -p theme/static/build/js/lib theme/static/build/fonts theme/static/build/css theme/static/build/img
	cp -R node_modules/font-awesome/fonts theme/static/build/
	npm run build-js
	npm run build-scss
	$(PELICAN) -o $(OUTPUTDIR) -vs $(CONFIG_FILE)

serve:
	cd output/ && $(ENV)/python3 -m pelican.server 8081


clean:
	rm -rf $(OUTPUTDIR)/*
	rm -rf $(BASEDIR)/env/
	rm -rf $(BASEDIR)/node_modules/


install: env node_modules

env:
	pyvenv env
	$(ENV)/pip install -r requirements.txt --upgrade

node_modules:
	npm install
