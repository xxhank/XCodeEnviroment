#!/usr/bin/env sh

RUN_DIR=`dirname $0`
RUN_DIR=`PWD`

#local o=$IFS
#IFS=$(echo -en "\n\b")

function safe_ln( ){
    source=$1
    targetDir=$HOME/$2
    mkdir -p "${targetDir}"

    if [[ -e "${targetDir}"/"$1" ]]; then
        mv  "${targetDir}"/"$1" "${targetDir}"/"$1"-{`date "+%Y%m%d-%H%M%S"`}.bak
    fi

    ln -s "$RUN_DIR"/"$source" "${targetDir}"
}

safe_ln "Plug-ins"    "/Library/Application Support/Developer/Shared/Xcode"
safe_ln "Templates"   "/Library/Developer/Xcode"
safe_ln "UserData"    "/Library/Developer/Xcode"


#IFS=o