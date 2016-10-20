#!/usr/bin/env bash

set -e

if [ "$NODE_ENV" = "production" ]
then
  echo ">>> WARNING: Building in Production Mode!"
fi

mkdir -p theme/static/build/js/lib

if [ "$NODE_ENV" = "production" ]
then
  echo ">> Compressing Libraries..."
  uglifyjs node_modules/bootstrap/dist/js/bootstrap.min.js --compress --screw-ie8 --define --stats --keep-fnames -o theme/static/build/js/lib/bootstrap.js
  uglifyjs theme/static/build/js/lib/* --compress --screw-ie8 --define --stats --keep-fnames -o theme/static/build/js/libs.js
else
  echo ">> Building Libraries..."
  cp node_modules/bootstrap/dist/js/bootstrap.min.js theme/static/build/js/lib/bootstrap.js
  uglifyjs theme/static/build/js/lib/* --screw-ie8 --stats --keep-fnames -o theme/static/build/js/libs.js
fi

rm -rf theme/static/build/js/lib

if [ "$NODE_ENV" = "production" ]
then
  echo ">> Compressing jQuery..."
  uglifyjs node_modules/jquery/dist/jquery.js --compress --screw-ie8 --define --stats --keep-fnames -o theme/static/build/js/jquery.js
else
  echo ">> Building jQuery..."
  cp node_modules/jquery/dist/jquery.js theme/static/build/js/jquery.js
fi


echo ">> Building Application JS..."
browserify -t [ babelify --presets [ es2015 ] ] theme/static/src/js/app.js -o theme/static/build/js/app.js

if [ "$NODE_ENV" = "production" ]
then
  echo ">> Compressing Application..."
  uglifyjs theme/static/build/js/app.js --compress --screw-ie8 --define --stats --keep-fnames -o theme/static/build/js/app.js
fi

echo "> JS Built!"
