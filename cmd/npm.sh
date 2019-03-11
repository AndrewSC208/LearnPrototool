#!/bin/sh
JS_DIRECTORIES=$(find ./gen -name *.js)
ROOT_DIR=$(pwd)
TEMPLATE_DIR=${ROOT_DIR}/template
TEMPLATE=${TEMPLATE_DIR}

for i in ${JS_DIRECTORIES}
do
  # set dirname
  DIR=$(dirname $i)
  # set filename
  FILE=$(basename $i)
  # copy module template
  cp -R ${TEMPLATE}/. ${DIR}; \
  # sed PB_MODULE_NAME for ${FILE} in package.json, and webpack.conf.js
  
  # npm run build

done