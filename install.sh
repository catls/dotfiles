#!/bin/sh
set -e

BASE_DIR=$(cd $(dirname $0);pwd)

FILE_LIST=(
    .private/
    .tmux/
    .vim/
    .w3m/
    .zsh/
    .Xresources
    .jshintrc
    .tigrc
    .tmux.conf
    .vimrc
    .zshenv
    # .lftprc
    # .asoundrc
    # .ls++.conf
    # .muttrc
)
for FILE in "${FILE_LIST[@]}";do
    ln -is "$BASE_DIR/$FILE" $HOME
done

if [ $DISPLAY ];then
    X_FILE_LIST=(
        .Xmodmap
        .gvimrc
        .keysnail.js
        .vimperatorrc
        .xinitrc
        .xmonad
    )
    for FILE in "${X_FILE_LIST[@]}";do
        ln -is "$BASE_DIR/$FILE" $HOME
    done
fi

# dircolors
DIRCOLORS=.dircolors-`tput colors`
if [ -f $BASE_DIR/$DIRCOLORS ]; then
    ln -is "$BASE_DIR/$DIRCOLORS" $HOME
fi

# config
if [[ -d $HOME/.config ]];then
    # archey3
    ln -is "$BASE_DIR/.config/archey3.cfg" $HOME/.config/archey3.cfg
    # dfc
    if [[ -d $HOME/.config/dfc ]];then
        ln -is "$BASE_DIR/.config/dfc/dfcrc" $HOME/.config/dfc/dfcrc
    fi
    # mirage
    if [[ -d $HOME/.config/mirage ]];then
        ln -is "$BASE_DIR/.config/mirage/miragerc" $HOME/.config/mirage/miragerc
        ln -is "$BASE_DIR/.config/mirage/accel_map" $HOME/.config/mirage/accel_map
    fi
    # htop
    if [[ -d $HOME/.config/htop ]];then
        ln -is "$BASE_DIR/.config/htop/htoprc" $HOME/.config/htop/htoprc
    fi
fi

# submodule init
git submodule update --init --recursive
