filetype off
if !isdirectory(expand("~/.vim/bundle/neobundle.vim"))
    !mkdir -p ~/.vim/bundle
    !git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
    let s:bootstrap=1
elseif !isdirectory(expand("~/.vim/bundle/vimdoc-ja"))
    let s:bootstrap=1
endif

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))

" let NeoBundle manage NeoBundle
NeoBundle 'Shougo/neobundle.vim'

"---------  vim-scripts リポジトリ ----------------------------------------
" syntax
NeoBundle "xoria256.vim"
NeoBundle "chriskempson/vim-tomorrow-theme"

"---------  github リポジトリ ----------------------------------------
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'scrooloose/syntastic'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'Shougo/neosnippet'
"NeoBundle 'Shougo/vimshell'
"NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \     'unix' : 'make -f make_unix.mak',
            \    },
            \ }
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'vim-scripts/MultipleSearch'

" php
NeoBundle 'StanAngeloff/php.vim'
NeoBundle 'karakaram/vim-quickrun-phpunit'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'vim-scripts/PDV--phpDocumentor-for-Vim' " phpdoc自動作成
NeoBundle 'stephpy/vim-php-cs-fixer'

" vim-ref
NeoBundle 'thinca/vim-ref'
"NeoBundle 'mojako/ref-sources.vim'
"NeoBundle 'mustardamus/jqapi'
"NeoBundle 'tokuhirom/jsref'

"javascript
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'heavenshell/vim-jsdoc'

" css
NeoBundle 'csscomb/vim-csscomb'

" twig
"NeoBundle 'Jinja'
"NeoBundle 'ocim/htmljinja.vim'
call neobundle#end()

if exists("s:bootstrap") && s:bootstrap
    unlet s:bootstrap
    NeoBundleInstall
endif
filetype plugin indent on
