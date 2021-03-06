#!/bin/bash

. $(dirname $0)/vars.sh

function writeRepoData {
    if [ -z $1 ]; then
        echo 'Repo src is necessary param of the function writeRepoData!'

        exit 1
    fi

    REPOSRC=$1

    TMP=$(git log --since=${DAYS}.days --author="<${EMAIL}>" --pretty=format:"[${REPOSRC}] %s");

    if [[ ! -z ${TMP} ]]; then
        echo -e "${TMP}\n" >> ${TMP_FILE};
    fi
}

function getActiveBranches {
    git for-each-ref \
        --sort=-committerdate \
        --format="%(committerdate:short) %(author) %(refname:short)" \
        | awk -v date_from=$(date --date="${DAYS} day ago" +%Y-%m-%d) '$0 > date_from' \
        | grep ${EMAIL} \
        | awk -F" " '{print $NF}'
}

function refreshRepo {
    if [ -z $1 ]; then
        echo 'Branch is necessary param of the function refreshRepo!'

        exit 1
    fi

    BRANCH=$1
    BRANCH=${1/origin\/}

    #in case of remote branch not found set +e for checkout and pull
    set +e
    git checkout ${BRANCH}
    git pull origin ${BRANCH}
    set -e
}
