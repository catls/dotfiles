#!/bin/bash
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
    .gitconfig
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
# git submodule update --init --recursive

vim +PluginInstall +qall
VIM_VERSION=$(vim --version | head -1 | cut -d ' ' -f 5)
if [ ! $(echo "$VIM_VERSION <= 7.4" | bc -l) ]; then
    # vim <= 7.4
    cd $HOME/.vim/cache/dein/repos/github.com/Shougo/dein.vim/
    git checkout 1.0
    vim +PluginInstall +qall
fi

# for mac
# brew install coreutils
