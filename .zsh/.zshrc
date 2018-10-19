
# 履歴の保存先
HISTFILE=${HOME}/.zsh_history
HISTSIZE=10000              # メモリに展開する履歴の数
SAVEHIST=10000000           # 保存する履歴の数
if [[ $UID -eq 0 ]] then    # root のコマンドはヒストリに追加しない
    unset HISTFILE
    SAVEHIST=0
fi

setopt extended_history     # zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt share_history        # 稼働中のすべてのzshでヒストリを共有
setopt hist_ignore_dups     # 直前と同じコマンドをヒストリに追加しない
setopt hist_reduce_blanks   # 余分な空白は詰めて記録
setopt hist_no_store        # historyコマンドは履歴に登録しない
setopt hist_ignore_space    # コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_verify          # ヒストリを呼び出してから実行する間に一旦編集
#setopt hist_ignore_all_dups # ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
#setopt hist_save_no_dups    # 古いコマンドと同じものは無視
setopt hist_expand          # 補完時にヒストリを自動的に展開
setopt inc_append_history   # 履歴をインクリメンタルに追加

# ヒストリの補完
autoload history-search-end # 補完した際、カーソル位置を行末にする
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# pushd/popd
DIRSTACKSIZE=100            # 記憶するディレクトリスタックの数
setopt auto_pushd           # cd 時に自動で push
setopt pushd_ignore_dups    # 同じディレクトリを pushしない

# dircolors
if whence dircolors >/dev/null; then
    DIRCOLORS=.dircolors-`tput colors`
    if [[ -r ${HOME}/${DIRCOLORS} ]] then
        eval `dircolors ${HOME}/${DIRCOLORS}`
    elif [[ -r ${HOME}/.dircolors ]] then
        eval `dircolors ${HOME}/.dircolors`
    elif [[ -x '/usr/bin/dircolors' ]] then
        eval $(dircolors)
    fi
else
    export CLICOLOR=1
fi

# 補完機能
autoload -U compinit
compinit

# default
setopt auto_menu            # TAB で順に補完候補を切り替える
setopt auto_list            # 補完候補を一覧表示
setopt always_last_prompt   # 補完を出しても元のプロンプトに留まる
setopt list_types           # 補完候補一覧でファイルの種別をマーク表示
setopt auto_param_keys      # カッコの対応などを自動的に補完
setopt auto_param_slash     # ディレクトリ補完時にスラッシュを補う
setopt auto_remove_slash    # ディレクトリ補完時に次の文字がデリミタなら削除する

unsetopt menu_complete        # 補完で直ちにメニュー補完に移行する
setopt list_packed          # 補完候補を詰めて表示

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# zstyle
# :completion:Func:Completer:Cmd-or-Context:Arg:Tag

# 補完候補の色づけ
#export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # 色をつける
zstyle ':completion:*:default' menu select=2 # 補完候補が2個以上あった場合、カーソル選択を有効に

# 補完方法毎にグループ化する。
zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix


# あいまい検索(typo用)
#zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# メッセージのフォーマット
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $yellow$bold'%d'$attr_end
zstyle ':completion:*:messages'     format $green'%d'$attr_end
zstyle ':completion:*:warnings'     format $red'No matches for: '$bold'%d'$attr_end
zstyle ':completion:*:corrections'  format $red'%d (errors: %e)'$attr_end
#zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''

# order
# zstyle ':completion:*' file-sort name
zstyle ':completion:*:*:cd:*' group-order local-directories users named-directories path-directories
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:expand:*' tag-order all-expansions
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補
zstyle ':completion:*:cd:*' tag-order local-directories path-directories

# completion caching
zstyle ':completion::complete:*' use-cache yes
zstyle ':completion::complete:*' cache-path ${ZDOTDIR}/.zcompcache/$HOST

# どうしようか悩み中
# ## case-insensitive (uppercase from lowercase) completion
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ## case-insensitive (all) completion
# #zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# ## case-insensitive,partial-word and then substring completion
# #zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# ## ignore completion functions (until the _ignored completer)
# zstyle ':completion:*:functions' ignored-patterns '_*'
#
#
# ## don't complete backup files as executables
# zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
#
# ## filename suffixes to ignore during completion (except after rm command)
# zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns \
# '*?.(o|c~|old|pro|zwc)' '*~'
#
# ## completions for some progs. not in default completion system
#
# zstyle ':completion:*:*:mpg123:*' file-patterns \
# '*.(mp3|MP3):mp3\ files *(-/):directories'
#
# zstyle ':completion:*:*:ogg123:*' file-patterns \
# '*.(ogg|OGG):ogg\ files *(-/):directories'
#

## processesの補完
zstyle ':completion:*:processes' command 'ps -au $USER'
## killコマンドの時にprocess番号を色付けする
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

## ユーザ名の補完
users=( `whoami` root )
zstyle ':completion:*' users $users

# netctlの補完
zstyle ':completion::*:netctl:*' file-patterns '/etc/netctl/*(.\:t):netctl\ profiles'

# hostnames
hosts=( $(cat /etc/hosts | grep -v "^#" | awk '{print $1}'| cut -d"," -f1), $([ -f $HOME/.ssh/known_hosts ] && cat $HOME/.ssh/known_hosts | grep -v "^|1|" | awk '{print $1}'| cut -d"," -f1))
zstyle ':completion:*' hosts $hosts

# ## (user,host) pairs
# ## all my accounts:
# my_accounts=(
# #        {root foobar}@localhost ## EDIT ##
# )
#
# zstyle ':completion:*:my-accounts' users-hosts $my_accounts


limit coredumpsize 0        # コアダンプサイズを制限
unsetopt promptcr           # 出力の文字列末尾に改行コードが無い場合でも表示
setopt prompt_subst         # 色を使う
setopt nobeep               # ビープを鳴らさない
setopt long_list_jobs       # 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt auto_resume          # サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt equals               # =command を command のパス名に展開する
setopt magic_equal_subst    # --prefix=/usr などの = 以降も補完
setopt print_eight_bit      # 出力時8ビットを通す
setopt auto_cd              # ディレクトリ名だけで cd
setopt correct              # スペルチェック
setopt NO_flow_control      # Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt interactive_comments # コマンドラインでも # 以降をコメントと見なす
setopt mark_dirs            # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt noautoremoveslash    # 最後のスラッシュを自動的に削除しない
setopt CHASE_LINKS          # CHASE_DOTSの効果を..以外にも適応する
setopt rm_star_silent       # rm *等のワイルドカードを用いたrmコマンドでも警告を出さない

# glob
setopt brace_ccl            # {a-c} を a b c に展開する機能を使えるようにする
setopt numeric_glob_sort    # ファイル名の展開で辞書順ではなく数値的にソート
setopt extended_glob        # ファイル名で #, ~, ^ の 3 文字を正規表現として扱う

# zmv
autoload -Uz zmv
alias zmv='noglob zmv -W'
alias zcp='noglob zmv -W -C'
alias zln='noglob zmv -W -L'

zsh_files=(
    'zshrc'
    'bindkey'
    'alias'
    'functions'
    'antigen'
    'prompt'
    'hooks'
    'completion'
)
for file in ${zsh_files[@]}; do
    if [ -f ${ZDOTDIR}/zshrc.${file} ]; then
        source ${ZDOTDIR}/zshrc.${file}
    fi

    # ローカルzshrcの読み込み
    if [ -f ${HOME}/.private/private.${file} ]; then
        source ${HOME}/.private/private.${file}
    fi
done
