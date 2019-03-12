#!/bin/sh
JS_DIRECTORIES=$(find ./gen -name *.js)
ROOT_DIR=$(pwd)
TEMPLATE_DIR=${ROOT_DIR}/template
TEMPLATE=${TEMPLATE_DIR}
REPLACE_TXT='PB_MODULE_NAME'
WEB_TEXT='web'

for i in ${JS_DIRECTORIES}
do
  # set dirname
  DIR=$(dirname $i)
  # set filename
  FILE=$(basename $i)
  # copy module template
  cp -R ${TEMPLATE}/. ${DIR};
  # copy the js file if we are in web

  echo DIR: ${DIR}
  echo FILE: ${FILE}
  echo ROOT: ${ROOT_DIR}
  ISWEB=$(expr match "$i" '.*\(web\)')

  cd ${DIR}
  if [[  ! $ISWEB ]]
  then
    TARGET1=${DIR/\/js\//\/web\/}
    TARGET2=${TARGET1/\.\//$ROOT_DIR\/}/
    echo copying js file to final target dir: ${TARGET2}
    cp ${FILE} ${TARGET2}
  fi
  sed -i s/${REPLACE_TXT}/${FILE}/g package.json
  sed -i s/${REPLACE_TXT}/${FILE}/g webpack.config.js
  npm run build
  cd ${ROOT_DIR}

done
