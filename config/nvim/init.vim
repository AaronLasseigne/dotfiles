"" vim and fish do not always get along
set shell=/bin/bash

"" Python

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

"" Plug

call plug#begin('~/.config/nvim/plugged')

"" Core

" leader
let mapleader=','

" no more shift
map ; :

" never enter Ex mode
nnoremap Q <nop>

" turn the mouse on for all modes
set mouse=a

" encoding
set encoding=utf-8

" intuitive backspacing in insert mode
set backspace=indent,eol,start

" sudo write
ca w!! w !sudo tee >/dev/null "%"

" new
map <F4> :tabe<CR>

" close
map <F6> :qa<CR>

" toggle pasting
set pastetoggle=<F8>

" toggle spell checking
setlocal spell spelllang=en_us
nmap <F10> :setlocal spell! spelllang=en_us<CR>
imap <F10> <C-o>:setlocal spell! spelllang=en_us<CR>

" clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" :CocInstall coc-solargraph
" :CocInstall coc-tsserver
" :CocInstall coc-css
" :CocInstall coc-snippets

nmap <leader>od <Plug>(coc-definition)
nmap <leader>td :call CocAction('jumpDefinition', 'tabe')<CR>
nmap <leader>ot <Plug>(coc-type-definition)
nmap <leader>oi <Plug>(coc-implementation)
nmap <leader>or <Plug>(coc-references)
nmap <leader>sd :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" add completion for various file types
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

Plug 'jpalardy/vim-slime' " send text from vim to a tmux window (usually a repl)

let g:slime_target = "tmux"

"" UI

" colors
Plug 'morhetz/gruvbox'

" show the tab line
set showtabline=2
" toggle line numbers
map <F7> :set nonumber!<CR>

" show the ruler
set ruler

" show line numbers
set number

" highlight the opening/closing parens, braces, etc
set showmatch

" highlight the current line and column
set cursorline
set cursorcolumn

" use single bar in insert mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

Plug 'vim-airline/vim-airline'

" enable coc support
let g:airline#extensions#coc#enabled = 1

" always show the status line
set laststatus=2

" make it look powerline esque
let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'

" pretty tabs
let g:airline#extensions#tabline#enabled=1

" do not how buffer counts
let g:airline#extensions#tabline#show_tab_nr=0

" do not show the buffer when only one tab exists
let g:airline#extensions#tabline#show_buffers=0

"" Spacing

" tabs are 2 spaces
set softtabstop=2
set tabstop=2

" use spaces when tabbing
set expandtab

" indent is 2 spaces
set shiftwidth=2

" keeps indentation going on the next line
set autoindent

" indent automatically when needed
set autoindent
filetype plugin indent on

" turns on the C indentation standard
set cindent

" stop comment indenting
set cinkeys-=0#

Plug 'junegunn/vim-easy-align'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

map <leader>a= gaip=
map <leader>a: gaip:

"" Cut, Copy, and Paste

" copy text to the OS clipboard
set clipboard=unnamed

" make Y work like C
nmap Y y$

Plug 'AaronLasseigne/yank-code'

map <leader>y <plug>YankCode

"" Search

Plug 'haya14busa/incsearch.vim'

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" clear search highlighting
noremap <silent><leader>cs :nohls<CR>

" only search case when an uppercase letter appears
set ignorecase
set smartcase

" make search results appear in the middle of the screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#z

" make * and # work with the current visual selection
Plug 'nelstrom/vim-visual-star-search'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

let g:fzf_command_prefix = 'Fzf'

" file search
map <silent> <leader>f :FzfGFiles<CR>

" MRU search
map <silent> <leader>r :FzfHistory<CR>

" buffer search
map <silent> <leader>b :FzfBuffers<CR>

" mark search
map <silent> <leader>m :FzfMarks<CR>

" git status search
map <silent> <leader>ge :FzfGFiles?<CR>

" window/tab search
map <silent> <leader>t :FzfWindows<CR>

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/gj %'<CR>:copen<CR>

Plug 'jremmen/vim-ripgrep'

let g:rg_derive_root = 1
let g:rg_highlight = 1

" Rg for the last search.
nnoremap <silent> <leader>? :execute "Rg '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
" Rg over Ruby files for the last search.
nnoremap <silent> <leader>?r :execute "Rg -truby '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
" Rg over HTML files for the last search.
nnoremap <silent> <leader>?h :execute "Rg -thtml '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
" Rg over JavaScript files for the last search.
nnoremap <silent> <leader>?j :execute "Rg -tjs '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

"" Quickfix

nmap <C-J> :cnext<CR>
nmap <C-K> :cprevious<CR>
nmap <C-Q> :cclose<CR>

"" Editing Toggles

Plug 'wellle/targets.vim' " adds lots of handy additional target options
Plug 'michaeljsmith/vim-indent-object' " adds vii and vaI for targeting around indentation

Plug 'tpope/vim-repeat' " adds '.' support for surround and speeddating

Plug 'tpope/vim-surround' " change surrounding stuff (parens, quotes, tags, etc)

Plug 'b3nj5m1n/kommentary' " easily add/remove commenting

Plug 'AndrewRadev/switch.vim' " alternate between items in a predefined list (e.g. true, false)

let g:switch_mapping = "<leader>s"

" additional definitions
let g:switch_custom_definitions =
    \ [
    \   ['to ', 'to_not '],
    \   ['const ', 'let '],
    \   ['hide', 'show'],
    \   ['TRUE', 'FALSE']
    \ ]

""" Increment and Decrement

" easier number increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

Plug 'tpope/vim-speeddating' " improved support

"" Typing Assistants

Plug 'jiangmiao/auto-pairs' " automatically adds closing paren, quote, etc

Plug 'honza/vim-snippets'
imap <C-e> <Plug>(coc-snippets-expand)

"" Version Control

" add spell checking to git commit messages
autocmd Filetype gitcommit setlocal spell

Plug 'tpope/vim-fugitive' " support for git

nnoremap <leader>gd :Gdiffsplit<cr>
nnoremap <leader>gD :diffoff!<cr><c-w>h:bd<cr>
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gb :Git blame -w -M -C<cr>
vnoremap <leader>gb :Git blame -w -M -C<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Git commit<cr>
nnoremap <leader>gm :Gmove<space>
nnoremap <leader>gr :GDelete<cr>


Plug 'junegunn/gv.vim'

nnoremap <leader>gl :GV!<cr>
vnoremap <leader>gl :GV!<cr>

Plug 'airblade/vim-gitgutter'

set updatetime=250
let g:gitgutter_realtime = 1

"" Languages

Plug 'sheerun/vim-polyglot'
" let g:polyglot_disabled = ['markdown']

""" Ruby

autocmd FileType eruby set filetype=eruby.html
autocmd BufNewFile,BufReadPost *.gemfile set filetype=ruby

Plug 'tpope/vim-endwise', { 'for': 'ruby' } " adds 'end' to Ruby blocks

"""" Rails

Plug 'tpope/vim-rails', { 'for': 'ruby' }

" open in a new tab
map gn <C-W>gf

" open in the current tab
map go gf

""" Elixir

" run code
nmap <Leader>ec :!elixir %<CR>

" run mix tasks
nmap <Leader>mt :!mix test<CR>

""" CSS

autocmd FileType sass set filetype=css
autocmd FileType scss set filetype=css

"" Linting

Plug 'dense-analysis/ale' " syntax checking

let g:ale_linters = { 'erb': [] }

let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_ruby_rubocop_options = '-D'

" nnoremap <leader>el :Errors<cr>
nnoremap <leader>ed :ALEDetail<cr>
nnoremap <leader>et :ALEToggle<cr>

"" Plug

call plug#end()

" has to be here so gruvbox is loaded
set termguicolors
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "hard"
colorscheme gruvbox
