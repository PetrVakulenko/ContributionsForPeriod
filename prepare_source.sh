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
    # $2 = default branches with delimiter `;` (or master, if $2 not defined)
    REPOSRC=$(echo ${var} | awk '{print $1}')
    DEFAULT_BRANCHES=$(echo ${var} | awk '{print $2}')
    LOCALREPO=${REPOS_PATH}/${REPOSRC}

    if [ ! -d "${LOCALREPO}/.git" ]; then
        git clone --branch master ${REPOSRC} ${LOCALREPO}
    else
        (
            cd ${LOCALREPO};

            refreshRepo master;
        )
    fi

    if [ -z ${DEFAULT_BRANCHES} ]; then
        (
            cd ${LOCALREPO};

            writeRepoData ${REPOSRC};
        )
    else
        IFS=';' read -ra ADDR <<< "${DEFAULT_BRANCHES}"
        for BRANCH in "${ADDR[@]}"; do
            (
                cd ${LOCALREPO};

                refreshRepo ${BRANCH};

                writeRepoData ${REPOSRC};
            )
        done
    fi

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

echo "Contributions OF ${EMAIL} for last ${DAYS} days saved to file ${OUTPUT}:"
cat ${TMP_FILE} | sort | uniq
cat ${TMP_FILE} | sort | uniq > ${OUTPUT}

rm -rf ${TMP_FILE}

exit 0
