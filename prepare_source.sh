#!/bin/bash

set -e

. $( dirname $0 )/vars.sh
. $( dirname $0 )/functions.sh

#Remove output file and define repo file and repos path
rm -rf ${OUTPUT} ${TMP_FILE} ${REPOS_PATH} \
    && mkdir -p ${REPOS_PATH} \
    && touch ${OUTPUT} \
    && touch ${TMP_FILE}

#Read each line of file with repos
while IFS= read -r var
do
    # $1 = src
    # $2 = default branch (if not master)
    REPOSRC=$(echo ${var} | awk '{print $1}')
    DEFAULT_BRANCH=$(echo ${var} | awk '{print $2}')
    LOCALREPO=${REPOS_PATH}/${REPOSRC}

    if [ -z ${DEFAULT_BRANCH} ]; then
        DEFAULT_BRANCH=master
    fi

    git clone --branch ${DEFAULT_BRANCH} ${REPOSRC} ${LOCALREPO}

    (
        cd ${LOCALREPO};

        writeRepoData ${REPOSRC};

        for BRANCH in `getActiveBranches`
        do
            refreshRepo ${BRANCH};

            writeRepoData ${REPOSRC};
        done
    )
done < "${REPOS_FILE}"

echo "Contributions OF ${AUTHOR} for last ${DAYS} days saved to file ${OUTPUT}:"
cat ${TMP_FILE} | sort | uniq
cat ${TMP_FILE} | sort | uniq > ${OUTPUT}

rm -rf ${TMP_FILE}

exit 0
