#!/usr/bin/env bash

set -e

if [ "$NODE_ENV" = "production" ]
then
  echo ">>> WARNING: Building in Production Mode!"
fi

mkdir -p theme/static/build/js/lib

echo ">> Building Libraries..."
cp node_modules/bootstrap/dist/js/bootstrap.min.js theme/static/build/js/lib/bootstrap.js

uglifyjs theme/static/build/js/lib/* --stats --keep-fnames -o theme/static/build/js/libs.js
rm -rf theme/static/build/js/lib
cp node_modules/jquery/dist/jquery.js theme/static/build/js/jquery.js


echo ">> Building Application JS..."
browserify -t [ babelify --presets [ es2015 ] ] theme/static/src/js/app.js -o theme/static/build/js/app.js

if [ "$NODE_ENV" = "production" ]
then
  echo ">> Compressing Application..."
  uglifyjs theme/static/build/js/app.js --compress --screw-ie8 --define --stats --keep-fnames -o theme/static/build/js/app.js
  uglifyjs theme/static/build/js/libs.js --compress --screw-ie8 --define --stats --keep-fnames -o theme/static/build/js/libs.js
  uglifyjs theme/static/build/js/jquery.js --compress --screw-ie8 --define --stats --keep-fnames -o theme/static/build/js/jquery.js
fi

echo "> JS Built!"
