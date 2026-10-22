" server.vimrc — generated from Hanaasagi's Neovim config (~/.config/nvim)
" For plain Vim on servers: no plugins, no external dependencies
" (the OSC52 copy function calls the system `base64` command).
"
" Sources:
"   lua/builtin/editor.lua    -> options + autocmds
"   lua/builtin/keymaps.lua   -> keymaps + TabToWindows
"   lua/builtin/clipboard.lua -> OSC52 copy
"
" Install: scp server.vimrc server:~/.vimrc

let mapleader = ","

" ======================================================================
" Options (from lua/builtin/editor.lua)
" ======================================================================

" Neovim enables these by default; Vim only enables them via defaults.vim
" when no vimrc exists, so a real vimrc must ask for them explicitly.
syntax enable
filetype plugin indent on

set encoding=utf-8

" signcolumn=yes:1 needs Vim 8.1.1564+; plain 'yes' (7.4.2201+) is the
" portable form and behaves the same once nothing is placing signs.
if exists('+signcolumn')
  set signcolumn=yes
endif

" suirenka (below) defines both truecolor (gui) and 256-palette (cterm)
" attributes; prefer truecolor when the terminal supports it.
if has('termguicolors')
  set termguicolors
endif

" xterm/screen/tmux support 256 colors even when $TERM is conservative
if &t_Co < 256 && $TERM =~# '^\(xterm\|screen\|tmux\)'
  set t_Co=256
endif

set number
set relativenumber
set ruler
set laststatus=2
set nowrap
set hidden

set ignorecase
set smartcase
set smartindent
set smarttab

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set nobackup
set noswapfile
set scrolloff=3

" mouse disabled, same as `vim.opt.mouse = nil`
set mouse=

set foldenable
set foldmethod=indent
set foldlevel=99

set wildmenu
set wildmode=longest,list,full

set splitbelow
set splitright

set cursorline
set cursorcolumn
set hlsearch
set incsearch

" ======================================================================
" Colorscheme: suirenka (inlined; modern rewrite with gui + cterm attrs)
" https://github.com/hanaasagi/suirenka (based on Molokai by Tomas Restrepo)
" Must come after 'syntax enable' so these definitions win.
" ======================================================================
if &t_Co >= 256 || &termguicolors || has('gui_running')

  " standard colorscheme prologue, kept inline so this section stays a
  " faithful embeddable theme
  set background=dark
  hi clear
  if exists('syntax_on')
    syntax reset
  endif
  let g:colors_name = 'suirenka'

  hi Normal guifg=#d0d0d0 guibg=#121212 ctermfg=252 ctermbg=233
  hi CursorLine guibg=#1c1c1c gui=NONE ctermbg=234 cterm=none
  hi CursorLineNr guifg=#ff8700 gui=NONE ctermfg=208 cterm=none

  hi Boolean guifg=#00ff5f ctermfg=47
  hi Character guifg=#af5f00 ctermfg=130
  hi Number guifg=#00ff5f ctermfg=47
  hi String guifg=#af5f00 ctermfg=130
  hi Conditional guifg=#d7005f gui=bold ctermfg=161 cterm=bold
  hi Constant guifg=#00ff5f gui=bold ctermfg=47 cterm=bold
  hi Cursor guifg=#000000 guibg=#dadada ctermfg=16 ctermbg=253
  hi Debug guifg=#ffd7ff gui=bold ctermfg=225 cterm=bold
  hi Define guifg=#5fd7ff ctermfg=81
  hi Delimiter guifg=#626262 ctermfg=241

  hi DiffAdd guibg=#005f87 ctermbg=24
  hi DiffChange guifg=#d7afaf guibg=#4e4e4e ctermfg=181 ctermbg=239
  hi DiffDelete guifg=#d70087 guibg=#5f005f ctermfg=162 ctermbg=53
  hi DiffText guibg=#878787 gui=bold ctermbg=102 cterm=bold

  hi Directory guifg=#af87ff gui=bold ctermfg=141 cterm=bold
  hi Error guifg=#ffafff guibg=#87005f ctermfg=219 ctermbg=89
  hi ErrorMsg guifg=#ff00af guibg=#000000 gui=bold ctermfg=199 ctermbg=16 cterm=bold
  hi Exception guifg=#af87ff gui=bold ctermfg=141 cterm=bold
  hi Float guifg=#00ff5f ctermfg=47
  hi FoldColumn guifg=#5f87af guibg=#000000 ctermfg=67 ctermbg=16
  hi Folded guifg=#5f87af guibg=#000000 ctermfg=67 ctermbg=16
  hi Function guifg=#af87ff ctermfg=141
  hi Identifier guifg=#ff8700 gui=NONE ctermfg=208 cterm=none
  hi Ignore guifg=#808080 guibg=#080808 ctermfg=244 ctermbg=232
  hi IncSearch guifg=#d7ffaf guibg=#000000 ctermfg=193 ctermbg=16

  hi Keyword guifg=#d7005f gui=bold ctermfg=161 cterm=bold
  hi Label guifg=#ffffaf gui=NONE ctermfg=229 cterm=none
  hi Macro guifg=#d7ffaf ctermfg=193

  hi MatchParen guifg=#121212 guibg=#ff8700 gui=bold ctermfg=233 ctermbg=208 cterm=bold
  hi ModeMsg guifg=#ffffaf ctermfg=229
  hi MoreMsg guifg=#ffffaf ctermfg=229
  hi Operator guifg=#d7005f ctermfg=161

  " complete menu
  hi Pmenu guifg=#5fd7ff guibg=#000000 ctermfg=81 ctermbg=16
  hi PmenuSel guifg=#eeeeee guibg=#6c6c6c ctermfg=255 ctermbg=242
  hi PmenuSbar guibg=#080808 ctermbg=232
  hi PmenuThumb guifg=#5fd7ff ctermfg=81

  hi PreCondit guifg=#af87ff gui=bold ctermfg=141 cterm=bold
  hi PreProc guifg=#af87ff ctermfg=141
  hi Question guifg=#5fd7ff ctermfg=81
  hi Repeat guifg=#d7005f gui=bold ctermfg=161 cterm=bold
  hi Search guifg=#000000 guibg=#ffd787 gui=NONE ctermfg=0 ctermbg=222 cterm=none

  " marks column
  hi SignColumn guifg=#af87ff guibg=#262626 ctermfg=141 ctermbg=235
  hi SpecialChar guifg=#d7005f gui=bold ctermfg=161 cterm=bold
  hi SpecialComment guifg=#8a8a8a gui=bold ctermfg=245 cterm=bold
  hi Special guifg=#5fd7ff ctermfg=81
  hi SpellBad guibg=#5f0000 ctermbg=52
  hi SpellCap guibg=#00005f ctermbg=17
  hi SpellLocal guibg=#00005f ctermbg=17
  hi SpellRare guifg=NONE guibg=NONE gui=reverse ctermfg=none ctermbg=none cterm=reverse
  hi Statement guifg=#d7005f gui=bold ctermfg=161 cterm=bold
  hi StatusLine guifg=#444444 guibg=#dadada ctermfg=238 ctermbg=253
  hi StatusLineNC guifg=#808080 guibg=#080808 ctermfg=244 ctermbg=232
  hi StorageClass guifg=#ff8700 ctermfg=208
  hi Structure guifg=#5fd7ff ctermfg=81
  hi Tag guifg=#d7005f ctermfg=161
  hi Title guifg=#afafff ctermfg=147
  hi Todo guifg=#ffffff guibg=#080808 gui=bold ctermfg=231 ctermbg=232 cterm=bold

  hi Typedef guifg=#5fd7ff ctermfg=81
  hi Type guifg=#5fd7ff gui=NONE ctermfg=81 cterm=none
  hi Underlined guifg=#808080 gui=underline ctermfg=244 cterm=underline

  hi VertSplit guifg=#808080 guibg=#080808 gui=bold ctermfg=244 ctermbg=232 cterm=bold
  hi VisualNOS guibg=#444444 ctermbg=238
  hi Visual guibg=#262626 ctermbg=235
  hi WarningMsg guifg=#ffffff guibg=#444444 gui=bold ctermfg=231 ctermbg=238 cterm=bold
  hi WildMenu guifg=#5fd7ff guibg=#000000 ctermfg=81 ctermbg=16

  hi Comment guifg=#5f5f5f ctermfg=59
  hi CursorColumn guibg=#303030 ctermbg=236
  hi ColorColumn guibg=#303030 ctermbg=236
  hi LineNr guifg=#bcbcbc guibg=#303030 ctermfg=250 ctermbg=236
  hi NonText guifg=#5f5f5f ctermfg=59

  hi SpecialKey guifg=#5f5f5f ctermfg=59

  " groups the old theme didn't cover, using theme palette colors
  hi TabLine guifg=#bcbcbc guibg=#262626 gui=NONE ctermfg=250 ctermbg=235 cterm=none
  hi TabLineSel guifg=#eeeeee guibg=#444444 gui=bold ctermfg=255 ctermbg=238 cterm=bold
  hi TabLineFill guibg=#080808 ctermbg=232
  hi! link CurSearch IncSearch
  hi! link EndOfBuffer NonText
  hi! link QuickFixLine Search
endif

" ======================================================================
" Keymaps (from lua/builtin/keymaps.lua)
" ======================================================================

" use regex search ('very magic')
" NOTE: the nvim config sets this with buffer=true, which only applies to
" the first buffer; here it is global, which was the actual intent.
nnoremap / /\v
xnoremap / /\v

" swap window position
nnoremap <Left>  <C-w>H
nnoremap <Right> <C-w>L
nnoremap <Up>    <C-w>K
nnoremap <Down>  <C-w>J

" disable Page Up/Down
nnoremap <PageUp>   <Nop>
nnoremap <PageDown> <Nop>

" disable backspace/delete in insert mode
" (the <Char-0x010>/<Char-0x07F> variants in the nvim config are just
" alternative encodings of BS/DEL; Vim's <BS>/<Del> cover them)
inoremap <BS>  <Nop>
inoremap <Del> <Nop>

" cancel highlight
nnoremap <silent> <leader>/ :nohlsearch<CR>

" move between windows
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l

nnoremap         <leader>w  :w<CR>
nnoremap <silent> <leader>wq :wq<CR>
nnoremap <silent> <leader>q  :q<CR>
nnoremap <silent> <leader>e  :cclose<CR>

" command-line movement
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" move current line down / up
nnoremap - :m .+1<CR>==
nnoremap _ :m .-2<CR>==

" tabs
nnoremap <silent> <leader>tn :tabnew<CR>
nnoremap <silent> <leader>tm <C-w>T
nnoremap <silent> <leader>tf :tabfirst<CR>
nnoremap <silent> <leader>tl :tablast<CR>
nnoremap <silent> <leader>tj :tabnext<CR>
nnoremap <silent> <leader>tk :tabprev<CR>

" jump to specific tab
for i in range(1, 9)
  execute 'nnoremap <silent> <leader>' . i . ' ' . i . 'gt'
endfor
unlet! i

" insert a single space
nnoremap <silent> <Space> i<Space><Esc>

" ======================================================================
" Autocmds (from lua/builtin/editor.lua)
" ======================================================================

augroup vimrc_rnu_toggle
  autocmd!
  autocmd FocusLost,InsertEnter * set norelativenumber number
  autocmd FocusGained,InsertLeave * set relativenumber
augroup END

" dim the cursor line/column in unfocused windows
" (nvim version also toggles guicursor, which is nvim-only and dropped)
augroup vimrc_dim_cursorline
  autocmd!
  autocmd WinLeave,FocusLost   * set nocursorline nocursorcolumn
  autocmd WinEnter,FocusGained * set cursorline cursorcolumn
augroup END

" go back to last edit position when reopening a file
augroup vimrc_restore_cursor
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
augroup END

" ======================================================================
" Tab -> windows (from lua/builtin/keymaps.lua)
" ======================================================================

" Close the current tab and reopen its buffers as split windows.
function! s:TabToWindows(split_type) abort
  if tabpagenr('$') == 1
    echo 'Only one tab page'
    return
  endif
  let l:bufnums = tabpagebuflist()
  tabclose
  execute 'topleft ' . a:split_type
  for l:buf in l:bufnums
    execute 'sbuffer ' . l:buf
    wincmd _
  endfor
  wincmd t
  quit
  wincmd =
endfunction

command! TabVSplit2Window call <SID>TabToWindows('vsplit')
command! TabSplit2Window  call <SID>TabToWindows('split')

nnoremap <silent> <leader>tv :TabVSplit2Window<CR>
nnoremap <silent> <leader>ts :TabSplit2Window<CR>

" ======================================================================
" OSC52 clipboard copy (from lua/builtin/clipboard.lua)
" ======================================================================

" Copy text to the *local* system clipboard through the terminal using
" OSC52 escape sequences. Works over SSH; wraps in a DCS passthrough
" under tmux (needs `set -g allow-passthrough on`, tmux >= 3.3).
"
" base64 output is stripped of newlines, so both GNU (`base64`, wraps at
" 76 columns) and BSD/macOS (`base64`, no wrapping) give the same result
" without needing platform-specific flags like -w0.
function! s:OSC52Copy(text) abort
  let l:b64 = substitute(system('base64', a:text), '\n', '', 'g')
  let l:seq = "\e]52;c;" . l:b64 . "\x07"
  if !empty($TMUX)
    let l:seq = "\ePtmux;\e" . l:seq . "\e\\"
  endif
  call writefile([l:seq], '/dev/tty', 'b')
  redraw!
endfunction

" visual: yank selection, then send it (mirrors the nvim remote branch)
xnoremap <silent> <C-c> y:call <SID>OSC52Copy(getreg('"'))<CR>
" normal: yank current line, then send it (mirrors the local `" +yy`)
nnoremap <silent> <C-c> yy:call <SID>OSC52Copy(getreg('"'))<CR>
