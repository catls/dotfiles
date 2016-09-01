
"colorscheme cottonmouse
"colorscheme xoria256

"set list
"set listchars=tab:>-,extends:<,trail:-,eol:<
highlight SpecialKey term=underline ctermfg=darkgray guifg=#444444


" タブの表示を変更
function! GuiTabLabel()
  let l:label = ''
  let l:bufnrlist = tabpagebuflist(v:lnum)
  let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
  let l:label .= l:bufname == '' ? 'No title' : l:bufname
  let l:wincount = tabpagewinnr(v:lnum, '$')
  if l:wincount > 1
    let l:label .= '[' . l:wincount . ']'
  endif
  for bufnr in l:bufnrlist
    if getbufvar(bufnr, "&modified")
      let l:label .= '[+]'
      break
    endif
  endfor

  return l:label
endfunction
set guitablabel=%N:\ %{GuiTabLabel()}


"IME 入力中のカーソル
if has('multi_byte_ime') || has('xim')
  hi CursorIM guifg=DarkRed guibg=DarkCyan
endif

" クリップボード
set clipboard=unnamed,autoselect
