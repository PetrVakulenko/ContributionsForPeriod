#!/bin/bash

### set configuration parameters

set -e

CURRENT_PATH=$(realpath $(dirname $0))/

REPOS_FILE=${CURRENT_PATH}repos.config

if [[ ! -f ${CURRENT_PATH}/.env ]]; then
    echo "File '${CURRENT_PATH}/.env' not found. For creation use `make .env` and fill the variables."

    exit 1
fi

source ${CURRENT_PATH}/.env

if [ -z ${REPOS_PATH} ]; then
    echo 'Repos path not defined. Please, add it to .env file.'

    exit 1
fi

if [ -z ${OUTPUT} ]; then
    echo 'Output file not defined. Please, add it to .env file.'

    exit 1
fi

OUTPUT=${CURRENT_PATH}/${OUTPUT}
TMP_FILE=${CURRENT_PATH}/tmp.txt

if [ -z ${AUTHOR} ]; then
    echo 'Author not defined. Please, add it to .env file.'

    exit 1
fi

if [ -z ${AUTHOR_EMAIL} ]; then
    echo 'Author email not defined. Please, add it to .env file.'

    exit 1
fi

if [ -z ${DAYS} ]; then
    echo 'Days not defined. Please, add it to .env file.'

    exit 1
fi
