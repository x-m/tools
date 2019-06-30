#!/bin/bash
#dependncys libxml2-utils

workpath=/mnt/az/Library
find $workpath -name "$1" -print0 | while IFS= read -r -d $'' line; do
    echo ${line}
    xmllint --xpath "/object/prologue/referenced-types/type/@name" ${line} | sed -e "s/ name=\"\([^\"]*\)\"/\1\n/g" | while read -r type; do
        target=${type}".type"
        echo ${target}
        find ${workpath} -name "${target}" -exec cp {} /mnt/az/creo  \;
    done

    xmllint --xpath "/object/prologue/referenced-snippets/snippet/@name" ${line} | sed -e "s/ name=\"\([^\"]*\)\"/\1\n/g" | while read -r snip; do
        target=${snip}".snippet"
        echo ${target}
        find ${workpath} -name "${target}" -exec cp {} /mnt/az/creo  \;
    done
done

find ${workpath} -name "$1" -exec cp {} /mnt/az/creo  \;
