"NeoBundle
if v:version > 700
     set nocompatible
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
    "NeoBundle 'Align' "html整形

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
    NeoBundle 'karakaram/vim-quickrun-phpunit'
    NeoBundle 'jelera/vim-javascript-syntax'
    NeoBundle 'nathanaelkane/vim-indent-guides'

    " vim-ref
    NeoBundle 'thinca/vim-ref'
    "NeoBundle 'mojako/ref-sources.vim'
    "NeoBundle 'mustardamus/jqapi'
    "NeoBundle 'tokuhirom/jsref'

    "NeoBundle 'Lokaltog/vim-easymotion'
    NeoBundle 'int3/vim-extradite'
    NeoBundle 'vim-scripts/MultipleSearch'
    NeoBundle 'vim-scripts/zoom.vim'

    "NeoBundle 'othree/html5.vim'
    "NeoBundle 'vim-scripts/php.vim-html-enhanced'
    NeoBundle 'StanAngeloff/php.vim'
    "NeoBundle 'vim-scripts/smarty.vim'
    NeoBundle 'vim-scripts/smarty-syntax'
    NeoBundle 'vim-scripts/PDV--phpDocumentor-for-Vim'  " phpdoc自動作成
    NeoBundle 'stephpy/vim-php-cs-fixer'
    "NeoBundle 'thinca/vim-qfreplace'

    NeoBundle 'thinca/vim-quickrun'
    NeoBundle 'kchmck/vim-coffee-script'

    " css
    NeoBundle 'csscomb/vim-csscomb'

    " twig
    "NeoBundle 'Jinja'
    "NeoBundle 'ocim/htmljinja.vim'

    " game
    "NeoBundle 'mfumi/snake.vim'

    " markdown
    "NeoBundle 'mattn/mkdpreview-vim'
    "NeoBundle 'mattn/webapi-vim'
    "NeoBundle 'vim-scripts/rest.vim'
    "NeoBundle 'Rykka/riv.vim'

    "NeoBundle 'mattn/benchvimrc-vim'
    " github 以外のリポジトリ ------------------------------------------------
    "Bundle 'git://git.wincent.com/command-t.git'

    call neobundle#end()

    filetype plugin indent on

    if exists("s:bootstrap") && s:bootstrap
        unlet s:bootstrap
        NeoBundleInstall
    endif
endif

"------------------------------------------------
"           エンコーディング
"------------------------------------------------
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp

"------------------------------------------------
"            表示の設定
"------------------------------------------------
syntax on
filetype plugin indent on

if &t_Co == 256
    colorscheme xoria256
else
    colorscheme desert
endif

set guifont=M+\ 1VM+\ IPAG\ circle\ 10
set printfont=M+\ 1VM+\ IPAG\ circle\ 10

set hlsearch
set number
set ruler
set guicursor=a:blinkon0 "カーソルの点滅 (blink) を止める
set laststatus=2
set showcmd
set ambiwidth=double     " ○☆などずれないようにする
set showmode " 対応する括弧を表示
set matchtime=5
set vb t_vb= " ビープ音をなくす

set notitle
set guioptions-=T
set guioptions-=m

if v:version >= 700
    " カーソル位置の強調
    set cursorline  "横
    "set cursorcolumn " 縦
    "highlight CursorLine guibg=#002A2A
    "highlight CursorColumn guibg=#002A2A
endif

"ステータスライン 文字コードの表示
function! GetStatusEx()
  let str = ''
  if &ft != ''
    let str = str . '[' . &ft . ']'
  endif
  if has('multi_byte')
    if &fenc != ''
      let str = str . '[' . &fenc . ']'
    elseif &enc != ''
      let str = str . '[' . &enc . ']'
    endif
  endif
"  if &ff != ''
"    let str = str . '[' . &ff . ']'
"  endif
  return str
endfunction

" 改行コードの表示
function! Getff()
    if &ff == 'unix'
        return 'LF'
    elseif &ff == 'dos'
        return 'CR+LF'
    elseif &ff == 'mac'
        return 'CR'
    else
        return '?'
    endif
endfunction

set statusline=%<%f\ %m%r%h%w%=%{GetStatusEx()}[%{Getff()}]\ \ %l,%c%V%8P

"------------------------------------------------
"           動作設定
"------------------------------------------------
" 検索関係
set incsearch
set ignorecase "大小区別なし
set smartcase  "大文字を入力した場合のみ大小区別
set nowrapscan " 検索した場合、n/Nの移動を繰り返さない

" インデント
set autoindent "新しい行のインデントを現在行と同じに
set smartindent
set tabstop=4     "すでにあるTab
set shiftwidth=4
set softtabstop=4 "Tabの挿入
set smarttab
set backspace=indent,eol,start
set expandtab
set modeline
set modelines=5
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.html.twig setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

"バックアップ, スワップファイル
set nobackup
set noswapfile

" undo
if has('persistent_undo')
  set undodir=~/.vim/vimundo
  set undofile
endif

"------------------------------------------------
"           etc
"------------------------------------------------
set foldmethod=marker " 折りたたみ
set helplang=ja,en " 日本語ヘルプを使用
"let g:neocomplcache_enable_at_startup = 1  "文字の補完

"カレントディレクトリを開いたファイルの場所に設定
au   BufEnter *   execute ":lcd " . expand("%:p:h")


" 表示行単位で上下移動するように
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
" 逆に普通の行単位で移動したい時のために逆の map も設定しておく
nnoremap gj j
nnoremap gk k

" J/K で5倍移動
noremap J 5j
vnoremap J 5j
noremap K 5k
vnoremap K 5k

" Alt-j/Alt-k でカーソルを中心に保ったまま移動
noremap <M-j> jzz
vnoremap <M-j> jzz
noremap <M-k> kzz
vnoremap <M-k> kzz

noremap <M-J> 5jzz
vnoremap <M-J> 5jzz
noremap <M-K> 5kzz
vnoremap <M-K> 5kzz

" 分割した画面を大きく
nnoremap <C-w>++ 50<C-w>+
" 分割した画面を小さく
nnoremap <C-w>-- 50<C-w>-

" <Space>j/<Space>kでページ移動
" noremap <Space>j <C-f>
" noremap <Space>k <C-b>


" C-jで画面移動
noremap <C-j> <C-E><C-E><C-E><C-E><C-E>
vnoremap <C-j> <C-E><C-E><C-E><C-E><C-E>

" H/L で単語移動
noremap L w
vnoremap L w
noremap H b
vnoremap H b

" タブの切り替え
noremap <C-n> :tabnext<CR>
noremap <C-p> :tabprevious<CR>
noremap <C-d> :tabclose<CR>
noremap <C-q> :tabonly<CR>
noremap <C-l> :tabmove+1<CR>
noremap <C-h> :tabmove-1<CR>


" 選択範囲の連番入力
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

vnoremap <silent> <C-a> :ContinuousNumber <C-a><CR>
vnoremap <silent> <C-x> :ContinuousNumber <C-x><CR>


" Esc２回で検索語のハイライトを消去する
"noremap <Esc><Esc> :nohlsearch<CR><Esc>:SearchReset<CR><Esc>:SearchBuffersReset<CR><Esc>
noremap <Esc><Esc> :nohlsearch<CR><Esc>


autocmd BufNewFile,BufRead *.skin set filetype=php
autocmd BufNewFile,BufRead *.inc set filetype=php
autocmd BufNewFile,BufRead .jshintrc set filetype=javascript

" Twig
autocmd BufNewFile,BufRead *.html.twig set filetype=htmldjango
autocmd BufNewFile,BufRead *.txt.twig set filetype=htmldjango
autocmd BufNewFile,BufRead *.js.twig set filetype=javascript


"------------------------------------------------
"           functions
"------------------------------------------------

"挿入モード時、ステータスラインの色を変更
"let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=#A3A3A3 gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

""スペースの可視化
""http://blog.remora.cx/2011/04/show-invisible-spaces-in-vim.html
set list
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

if has("syntax")
    " PODバグ対策
    syn sync fromstart

    function! ActivateInvisibleIndicator()
        " 下の行の"　"は全角スペース
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
        "syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
        "highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=NONE gui=undercurl guisp=darkorange
        "syntax match InvisibleTab "\t" display containedin=ALL
        "highlight InvisibleTab term=underline ctermbg=white gui=undercurl guisp=darkslategray
    endf
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif

"------------------------------------
" syntastic
"------------------------------------
let g:syntastic_check_on_open       = 0   " ファイルを開いた際にチェック
let g:syntastic_enable_signs        = 1   " エラー行にサインをつける
let g:syntastic_enable_highlighting = 1   " エラー箇所をハイライト
let g:syntastic_echo_current_error  = 1   " コマンド行にエラー内容を表示
let g:syntastic_auto_jump           = 0   " エラー行に自動でジャンプ
let g:syntastic_enable_balloons     = 1   " エラー時にバルーンポップを表示
let g:syntastic_auto_loc_list       = 1   " エラー発生時にエラーウィンドウ表示・エラー解消時にエラーウィンドウクローズ。
let g:syntastic_loc_list_height     = 5   " エラーウィンドウの高さ

let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes' : ['php','perl','javascript'],
    \ 'passive_filetypes': ['tpl','xml'] }
" ステータスラインの内容。
"let g:syntastic_stl_format = '[%E{E(%e):%fe}%B{ }%W{W(%w):%fw}]'
let g:syntastic_stl_format = '[%E{Error 1/%e: line %fe}%B{, }%W{Warning 1/%w: line %fw}]'
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_php_checkers = ['php','phpcs']
let g:syntastic_php_phpcs_args='--standard=PSR2'



"------------------------------------
" unite.vim
"------------------------------------
" " 入力モードで開始する
" let g:unite_enable_start_insert=0
" " バッファ一覧
" noremap <C-U><C-B> :Unite buffer<CR>
" " ファイル一覧
" noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
" " 最近使ったファイルの一覧
" noremap <C-U><C-R> :Unite file_mru<CR>
" " レジスタ一覧
" noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
" " ファイルとバッファ
" noremap <C-U><C-U> :Unite buffer file_mru<CR>
" " 全部
" noremap <C-U><C-A> :Unite UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" " ESCキーを2回押すと終了する
" au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
" au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>


""" unite.vim
" 入力モードで開始する
" let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q



"------------------------------------
" Bundle 'jelera/vim-javascript-syntax'
"------------------------------------
au FileType javascript call JavaScriptFold()


"------------------------------------
"Bundle 'nathanaelkane/vim-indent-guides'
"------------------------------------
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#121212 ctermbg=233
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#262626 ctermbg=235


"------------------------------------
" Bundle 'thinca/vim-ref'
"------------------------------------
let g:ref_phpmanual_path = $HOME.'/.vim/doc/php-docs-ja/php-chunked-xhtml'
"webdictサイトの設定
let g:ref_source_webdict_sites = {
\   'je': {
\     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
\   },
\   'ej': {
\     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
\   },
\   'wiki': {
\     'url': 'http://ja.wikipedia.org/wiki/%s',
\   },
\ }
let g:ref_jquery_doc_path     = $HOME.'/.vim/bundle/jqapi'
let g:ref_javascript_doc_path = $HOME.'/.vim/bundle/jsref/htdocs'


"デフォルトサイト
let g:ref_source_webdict_sites.default = 'ej'

"出力に対するフィルタ。最初の数行を削除
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction

nmap <Leader>rj :<C-u>Ref webdict je<Space>
nmap <Leader>re :<C-u>Ref webdict ej<Space>

"英和辞書を検索するコマンド例
":Ref webdict ej dictionary
"和英辞書を検索するコマンド例
":Ref webdict je 辞書
"webdictを呼び出すコマンドの書式は下記の通りです。少々長いので、キーにマップして呼び出すことが多いです。
":Ref webdict {site-name} {keyword}
"サイトのデフォルトを英和辞書に設定しているため、サイト名を省略した場合は英和辞書が呼び出されます。
":Ref webdict {keyword}
"

"------------------------------------
" Bundle 'Lokaltog/vim-easymotion'
"------------------------------------
let g:EasyMotion_leader_key = '<Space><Space>'
let g:EasyMotion_keys = 'fjdkslaureiwoqpvncm'

"------------------------------------
" QuickRun PHPUnit
"------------------------------------
" augroup QuickRunPHPUnit
"     autocmd!
"     autocmd BufWinEnter,BufNewFile *Test.php set filetype=phpunit
" augroup END
"
" let g:quickrun_config = {}
" let g:quickrun_config['_'] = {}
" let g:quickrun_config['_']['runner'] = 'vimproc'
" let g:quickrun_config['_']['runner/vimproc/updatetime'] = 100

"--------------------------------------------------
" 通常の表示（横分割して結果表示）
" let g:quickrun_config['phpunit'] = {}
" let g:quickrun_config['phpunit']['outputter/buffer/split'] = 'vertical 50'
" let g:quickrun_config['phpunit']['command'] = 'phpunit'
" let g:quickrun_config['phpunit']['cmdopt'] = ''
" let g:quickrun_config['phpunit']['exec'] = '%c %o %s'
"--------------------------------------------------

"--------------------------------------------------
" ステータスラインの下に結果を表示
" let g:quickrun_config['phpunit'] = {}
" let g:quickrun_config['phpunit']['outputter'] = 'phpunit'
" let g:quickrun_config['phpunit']['command'] = 'phpunit'
" let g:quickrun_config['phpunit']['exec'] = '%c %o %s'
"
" let g:quickrun_config['phpunit']['outputter/phpunit/height'] = 3
" let g:quickrun_config['phpunit']['outputter/phpunit/running_mark'] = 'running...'
" let g:quickrun_config['phpunit']['outputter/phpunit/auto_open'] = 0


"------------------------------------
"    NeoBundle 'stephpy/vim-php-cs-fixer'
"------------------------------------
let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer" " define the path to the php-cs-fixer.phar
" let g:php_cs_fixer_level = "all"                  " which level ?
" let g:php_cs_fixer_config = "default"             " configuration
" let g:php_cs_fixer_php_path = "php"               " Path to PHP
" " If you want to define specific fixers:
" "let g:php_cs_fixer_fixers_list = "linefeed,short_tag,indentation"
" let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
" let g:php_cs_fixer_dry_run = 1                    " Call command with dry-run option
" let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information
nnoremap ,pf :call PhpCsFixerFixFile()<CR>
"nnoremap ,pcd :call PhpCsFixerFixDirectory()<CR>


" 辞書ファイルを指定
"autocmd FileType php :set dictionary=~/.vim/dict/php.dict
"autocmd BufRead *.php\|*.ctp\|*.tpl :set dictionary=~/.vim/dict/php.dict filetype=php
"autocmd FileType javascript :set dictionary=~/.vim/dict/javascript.dict,dict/jQuery.dict

"------------------------------------
"   NeoBundle 'PDV--phpDocumentor-for-Vim'
"------------------------------------
let g:pdv_cfg_Type = "mixed"
let g:pdv_cfg_Package = ""
let g:pdv_cfg_Version = "$id$"
let g:pdv_cfg_Author = "catls <ss224r9d@gmail.com>"
let g:pdv_cfg_Copyright = "2014 catls"
let g:pdv_cfg_License = ""
let g:pdv_cfg_ReturnVal = "void"
inoremap ,pd <ESC>:call PhpDocSingle()<CR>i
nnoremap ,pd :call PhpDocSingle()<CR>
vnoremap ,pd :call PhpDocRange()<CR>

if filereadable(expand('~/.private/private.vimrc'))
    source ~/.private/private.vimrc
endif


" let g:indent_guides_enable_on_vim_startup=1
" let g:indent_guides_start_level=2
" let g:indent_guides_auto_colors=0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=234
" let g:indent_guides_color_change_percent = 30
" let g:indent_guides_guide_size = 1
