BASEDIR=$(PWD)
ENV=$(BASEDIR)/env/bin
NODE_BIN=$(BASEDIR)/node_modules/.bin
PELICAN=$(ENV)/pelican

OUTPUTDIR=$(BASEDIR)/output
PLUGINS_DIR=$(BASEDIR)/pelican_plugins
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


install: env node_modules pelican_plugins

env:
	pyvenv env
	$(ENV)/pip install -r requirements.txt --upgrade

pelican_plugins: env
	rm -rf $(PLUGINS_DIR) || "No existing extensions"
	git clone --recursive https://github.com/getpelican/pelican-plugins $(PLUGINS_DIR) || "Git Fail"
	@echo ">> Hotfixing..."
	rm -rf $(PLUGINS_DIR)/pelican-jinja2content
	git clone https://github.com/RealOrangeOne/pelican-jinja2content -b patch-1 --depth=1 $(PLUGINS_DIR)/pelican-jinja2content

node_modules:
	npm install


.PHONY: build clean install
