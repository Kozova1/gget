#!/bin/bash

function gget() {
    bold="\033[1m"
    normal="\033[0m"
    if [ "$1" == "-u" ]; then
        TO_DOWNLOAD="$3"
        USER_PSWD="$2"
    else
        if [ "$1" != "" ]; then
            TO_DOWNLOAD="$1"
            USER_PSWD="git:git"
        else
            echo -e "\033[0;31m${bold}error:\033[0m ${normal}please specify repo to download."
            return 1
        fi
    fi
    git ls-remote "https://$USER_PSWD@github.com/$TO_DOWNLOAD.git" > /dev/null 2>&1
    if [ "$?" -eq 0 ]; then
        git clone "https://$USER_PSWD@github.com/$TO_DOWNLOAD.git"

    else
        git ls-remote "https://$USER_PSWD@gitlab.com/$TO_DOWNLOAD.git" > /dev/null 2>&1
        if [ "$?" -eq 0 ]; then
            git clone "https://$USER_PSWD@gitlab.com/$TO_DOWNLOAD.git"
        else
            echo -e "\033[0;31m${bold}error:\033[0m ${normal}no git repo named '$TO_DOWNLOAD' was found."
            return 1
        fi

    fi
    D_DIR="$(cut -d'/' -f2 <<<"$TO_DOWNLOAD")"
    if [ -e  "$D_DIR/README.md" ]; then
        xdg-open "$D_DIR/README.md"
    fi

    if [ -e  "$D_DIR/README.MD" ]; then
        xdg-open "$D_DIR/README.MD"
    fi
}
