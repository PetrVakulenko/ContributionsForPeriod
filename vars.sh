#!/bin/bash

### set configuration parameters

set -e

CURRENT_PATH=$(realpath $(dirname $0))/

REPOS_FILE=${CURRENT_PATH}repos.config

if [[ ! -f ${CURRENT_PATH}/.env ]]; then
    echo "File '${CURRENT_PATH}/.env' not found.
For creation use `make .env` and fill the variables.
Or your variables will have default value"
fi

source ${CURRENT_PATH}/.env

if [ -z ${REPOS_PATH} ]; then
    REPOS_PATH=${CURRENT_PATH}/tmp/repos
fi

if [ -z ${OUTPUT} ]; then
    OUTPUT=${CURRENT_PATH}/tmp/output.txt
fi

OUTPUT=${CURRENT_PATH}/${OUTPUT}
TMP_FILE=${CURRENT_PATH}/tmp/tmp.txt

if [ -z ${EMAIL} ]; then
    EMAIL=$(git config user.email)

    if [ -z ${EMAIL} ]; then
        echo 'Email should be defined at the `.env` or at the `git config user.email` setting.'

        exit 1
    fi
fi

if [ -z ${DAYS} ]; then
    DAYS=7
fi
