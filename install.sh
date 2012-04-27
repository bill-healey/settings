#!/usr/bin/env bash
function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ]; then
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}

if [ "$1" = "vim" ]; then
    for i in _vim*
    do
       link_file $i
    done
else
    for i in _*
    do
        link_file $i
    done
fi

git submodule sync
git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule foreach git submodule init
git submodule foreach git submodule update

mkdir ~/.ssh
echo ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAi8sv6vPtx/KOh2P9sFYEWEGCTRQOuREkKPdzqjqNeCyyJc2Gq0DZCIlU5VsRNzQUphLdWZUQXIYJAdwGQUmDlFxyjo5vhbxKeSdXulh3yKXapTl4YMYzUpum6Srymrea//0vlrMKHmod/Xr80Pht018g3CJ6M7ws+d1YrnhZRX0= key.ppk >> ~/.ssh/authorized_keys
