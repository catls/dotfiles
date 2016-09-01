# Arch Linuxの場合、/etc/profileが.zshenvのpathを上書きするため、
# pathの設定はこっちでやるようにする

# ・いつも忘れるのでメモ
# (N-/): 存在しないディレクトリは登録しない。
#    パス(...): ...という条件にマッチするパスのみ残す。
#            N: NULL_GLOBオプションを設定。
#               globがマッチしなかったり存在しないパスを無視する。
#            -: シンボリックリンク先のパスを評価。
#            /: ディレクトリのみ残す。

# $PATH
path=(
    /bin(N-/)
    /usr/bin(N-/)
    /usr/local/bin(N-/)

    # home
    $HOME/bin(N-/)
    $HOME/sh(N-/)

    # --prefix=$HOME/localでインストールしたもの
    $HOME/local/bin(N-/)

    # ruby
    # gem install --user-installでインストールしたもの
    $HOME/.gem/ruby/*/bin(N-/)
    # rbenv
    $HOME/.rbenv/bin(N-/)

    # perl
    /usr/bin/core_perl(N-/)
    /usr/bin/site_perl(N-/)
    /usr/bin/vendor_perl(N-/)

    # PHP
    $HOME/.composer/vendor/bin(N-/)
    $HOME/.phpenv/bin(N-/)

    # cabal
    $HOME/.cabal/bin(N-/)

    # kerberos
    /usr/kerberos/bin(N-/)

    # TeX
    /usr/local/texlive/2014/bin/x86_64-linux(N-/)

    # sbin
    /sbin(N-/)
    /usr/sbin(N-/)
    /usr/local/sbin(N-/)
    /usr/kerberos/sbin(N-/)
)

# $MANPATH
manpath=(
    /usr/local/share/man/ja(N-/)
    /usr/local/man/ja(N-/)
    /usr/local/man/jp(N-/)
    /usr/share/man/ja(N-/)
    /usr/share/man/jp(N-/)
    /usr/share/man/C(N-/)
    /usr/local/texlive/2014/texmf-dist/doc/man(N-/)
)

# $FPATH
fpath=(
    $fpath
    $HOME/.zsh/functions(N-/)
    $HOME/.zsh/completion(N-/)
)

# $CDPATH
cdpath=(
    $cdpath
    ${HOME}/links(N-/)
)

# $INFOPATH
infopath=(
    /usr/local/texlive/2014/texmf-dist/doc/info(N-/)
)

typeset -U path
typeset -U manpath
typeset -U fpath
typeset -U cdpath
typeset -U infopath


export path manpath fpath infopath


# $TERM
if [ ! -z "`locate '*terminfo*screen-256color'`" ];then
    export TERM=screen-256color
else
    export TERM=screen
fi


[ -d ${HOME}/.rbenv  ]  && eval "$(rbenv init --no-rehash -)"
[ -d ${HOME}/.phpenv  ] && eval "$(phpenv init -)"
