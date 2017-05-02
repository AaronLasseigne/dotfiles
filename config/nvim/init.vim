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
nmap <F10> :setlocal spell! spelllang=en_us<CR>
imap <F10> <C-o>:setlocal spell! spelllang=en_us<CR>

" clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

Plug 'vim-scripts/matchit.zip' " more complete '%' matching

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " completion as you type

" turn it on
let g:deoplete#enable_at_startup = 1

" only search case when an uppercase letter appears
let g:deoplete#enable_smart_case = 1

" add completion for various file types
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

Plug 'jpalardy/vim-slime' " send text from vim to a tmux window (usually a repl)

let g:slime_target = "tmux"

Plug 'beloglazov/vim-online-thesaurus'

let g:online_thesaurus_map_keys = 0
nnoremap <leader>o :OnlineThesaurusCurrentWord<CR>

"" UI

" colors
set t_Co=256
syntax enable
let g:zenburn_high_Contrast = 1
colorscheme zenburn

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
Plug 'vim-airline/vim-airline-themes'

" always show the status line
set laststatus=2

" make it look powerline esque
let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'

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
set smartindent

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

Plug 'maxbrunsfeld/vim-yankstack'

let g:yankstack_map_keys = 0
nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-n> <Plug>yankstack_substitute_newer_paste

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

Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

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
let g:rg_command = "rg --vimgrep --smart-case $argv"

" Rg for the last search.
nnoremap <silent> <leader>? :execute "Rg '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
" Rg over Ruby files for the last search.
nnoremap <silent> <leader>?r :execute "Rg -truby '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
" Rg over HTML files for the last search.
nnoremap <silent> <leader>?h :execute "Rg -thtml '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
" Rg over JavaScript files for the last search.
nnoremap <silent> <leader>?j :execute "Rg -tjs '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

Plug 'henrik/vim-indexed-search' " shows 'Nth match out of M' when searching

"" Quickfix

nmap <C-J> :cnext<CR>
nmap <C-K> :cprevious<CR>
nmap <C-Q> :cclose<CR>

"" Editing Toggles

Plug 'tpope/vim-repeat' " adds '.' support for surround and speeddating

Plug 'tpope/vim-surround' " change surrounding stuff (parens, quotes, tags, etc)

Plug 'tpope/vim-commentary' " easily add/remove commenting

Plug 'AndrewRadev/switch.vim' " alternate between items in a predefined list (e.g. true, false)

let g:switch_mapping = "<leader>s"

" additional definitions
let g:switch_custom_definitions =
    \ [
    \   ['to ', 'to_not '],
    \   ['const ', 'let '],
    \   ['hide', 'show']
    \ ]

""" Increment and Decrement

" easier number increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

Plug 'tpope/vim-speeddating' " improved support

"" Typing Assistants

Plug 'jiangmiao/auto-pairs' " automatically adds closing paren, quote, etc

"" Version Control

" add spell checking to git commit messages
autocmd Filetype gitcommit setlocal spell

Plug 'tpope/vim-fugitive' " support for git

nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gD :diffoff!<cr><c-w>h:bd<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gb :Gblame<cr>
vnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gB :Gblame -w -M -C<cr>
vnoremap <leader>gB :Gblame -w -M -C<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove
nnoremap <leader>gr :Gremove<cr>


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

autocmd FileType eruby set filetype=eruby.html.javascript

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

""" F#

autocmd BufNewFile,BufReadPost *.fsx\= set filetype=fsharp
autocmd FileType fsharp setlocal commentstring=//\ %s

""" JavaScript

autocmd BufNewFile,BufReadPost *.es6 set filetype=javascript
autocmd BufNewFile,BufReadPost *.jsx set filetype=javascript
autocmd BufNewFile,BufReadPost *.hbs set filetype=html

""" CSS

autocmd FileType sass set filetype=css
autocmd FileType scss set filetype=css

""" Markdown

Plug 'reedes/vim-wordy', { 'for': 'markdown' }

"" Linting

Plug 'scrooloose/syntastic' " syntax checking

nnoremap <leader>el :Errors<cr>
nnoremap <leader>er :SyntasticReset<cr>
nnoremap <leader>et :SyntasticToggleMode<cr>

let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_ruby_rubocop_quiet_messages = { "level": [] }

let g:syntastic_elixir_checkers = ['elixir']
" Some checkers have security issues and have to be manually enabled.
let g:syntastic_enable_elixir_checker = 1

let g:syntastic_javascript_checkers = ['eslint']

"" EditorConfig

Plug 'editorconfig/editorconfig-vim' " generic per project editor configs

" don't mess with Fugitive or remote files
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"" Plug

call plug#end()
