# systemdに変えてから.xinitrc時点では読み込まれなくなった
if [ $DISPLAY ];then
    setxkbmap -layout jp -model jp106
    [ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap > /dev/null 2>&1
    [ -f ~/.private/private.Xmodmap ] && xmodmap ~/.private/private.Xmodmap > /dev/null 2>&1

    # Xを使用する時だけja_JP.UTFにする
    export LANG=ja_JP.utf8
    export LC_ALL=ja_JP.utf8
else
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
fi

export EDITOR='vim'
export SHELL='/bin/zsh'

# ruby
#export GEM_HOME="~/.gem/ruby/1.9.1"

# w3m
export WWW_HOME="google.co.jp"

# optional
export APACHEUSER=`ps aux | grep -E '[a]pache|[h]ttpd' | grep -v root | head -1 | cut -d\  -f1`

# Man pages
if [ -x '/usr/bin/lv' ];then
    export PAGER="lv"
    export LV='-Ou8 -c'
else
    export PAGER="less"
    export VISUAL="vim"
    export LESS_TERMCAP_mb=$'\E[01;31m'   # begin blinking
    export LESS_TERMCAP_md=$'\E[01;31m'   # begin bold
    export LESS_TERMCAP_me=$'\E[0m'       # end mode
    export LESS_TERMCAP_se=$'\E[0m'       # end standout-mode
    export LESS_TERMCAP_so=$'\E[1;33;40m' # begin standout-mode - info box
    export LESS_TERMCAP_ue=$'\E[0m'       # end underline
    export LESS_TERMCAP_us=$'\E[1;32m'    # begin underline
fi

# colors
if tput setaf 0 &>/dev/null; then
    red=$(tput setaf 1)
    green=$(tput setaf 2)
    yellow=$(tput setaf 3)
    blue=$(tput setaf 4)
    magenta=$(tput setaf 5)
    cyan=$(tput setaf 6)
    white=$(tput setaf 7)
    bold=$(tput bold)
    reverse=$(tput rev)
    underline=$(tput smul)
    attr_end=$(tput sgr0)
fi

# mysql prompt
MYSQL_PS1="\u@\h:\d> "
# MYSQL_PS1=$(host=$(echo "\h>");[ $(echo "$host" | grep local ) ] && echo -e "\e[1;33{$host}[\d]\e[0m\n> " || echo $host)
export MYSQL_PS1

export ZDOTDIR=~/.zsh/
