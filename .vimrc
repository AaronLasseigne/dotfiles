" for VAM
set nocompatible | filetype indent plugin on | syn on

" leader
let mapleader=','

" turn the mouse on for all modes
set mouse=a
" copy text to the OS clipboard
set clipboard=unnamed

" ==== DISPLAY ====

" encoding
set encoding=utf-8

" colors
set t_Co=256
syntax enable
colorscheme my_colors

function! HighlightAnnotations()
  syn keyword vimTodo contained HACK OPTIMIZE REVIEW
  syn keyword rubyTodo contained HACK REVIEW
  syn keyword coffeeTodo contained HACK OPTIMIZE REVIEW
  syn keyword javaScriptCommentTodo contained HACK OPTIMIZE REVIEW
endfunction
autocmd Syntax * call HighlightAnnotations()

" show the tab line
set showtabline=2

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

" /==== DISPLAY ====


" ==== SEARCH ====

" find as you type
set incsearch

" highlight matches
set hlsearch

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

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
" Ag for the last search.
nnoremap <silent> <leader>? :execute "Ag! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
" Ag over Ruby files for the last search.
nnoremap <silent> <leader>?r :execute "Ag! --ruby '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
" Ag over HTML files for the last search.
nnoremap <silent> <leader>?h :execute "Ag! --html '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
" Ag over JavaScript files for the last search.
nnoremap <silent> <leader>?j :execute "Ag! --js '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

" clear search highlighting
noremap <silent><leader>cs :nohls<CR>

" /==== SEARCH ====

" ==== QUICKFIX ====

nmap <C-J> :cnext<CR>
nmap <C-K> :cprevious<CR>

" /==== QUICKFIX ====

" ==== SPACING ====

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

" /==== SPACING ====


" ==== Addons ====

" vim addon manager
"
" Language/Framework
"
" rails              = RoR support
" vim-clojure-static = clojure support
" vim-coffee-script  = cs support
" markdown@tpope     = markdown support
" vim-ruby           = ruby support
" vim-elixir         = elixir support
"
" Plugins
"
" ag            = adds support for the ag command
" airline       = better vim statusline
" matchit.zip   = more complete '%' matching
" delimitMate   = automatically adds closing paren, quote, etc
" fugitive      = built-in support for git
" extradite     = plugin for fugitive that provides tig like interface
" Tabular       = alignment helper
" ctrlp         = file searching
" tComment      = easily add/remove commenting
" YankRing      = cycle through previous pastes after pasting
" IndexedSearch = shows 'Nth match out of M' when searching
" endwise       = adds 'end' to Ruby blocks
" neocomplcache = completion as you type
" neosnippet    = expandable snippets
" surround      = change surrounding stuff (parens, quotes, tags, etc)
" repeat        = adds "." support for surround and speeddating
" speeddating   = improved inc/dec support
" switch.vim    = switch between items in a predefined list (e.g. true, false)
" Syntastic     = syntax checking

fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " Force your ~/.vim/after directory to be last in &rtp always:
  " let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons(['matchit.zip', 'rails', 'delimitMate', 'fugitive', 'Tabular', 'vim-coffee-script', 'ctrlp', 'extradite', 'tComment', 'vim-ruby', 'YankRing', 'IndexedSearch', 'endwise', 'neosnippet', 'surround', 'repeat', 'vim-airline', 'markdown@tpope', 'vim-clojure-static', 'switch', 'vim-elixir', 'speeddating', 'Syntastic', 'ag'], {'auto_install': 0})
endfun
call SetupVAM()

" == YankRing ==

" I had to set this as a fix for version 13
let g:yankring_manual_clipboard_check = 0

" make the history file a dotfile so it disappears
let g:yankring_history_file = '.yankring_history'

" /== YankRing ==

" == neosnippet ==

let g:neosnippet#snippets_directory = '~/.vim/snippets'
set completeopt-=preview

" /== neosnippet ==

" == neocomplcache ==

" turn it on
let g:neocomplcache_enable_at_startup = 1

" only search case when an uppercase letter appears
let g:neocomplcache_enable_smart_case = 1

" add completion for various file types
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" /== neocomplcache ==

" == ctrlp ==

" ignore stuff when searching
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so,*.swp,*/doc/*,*/_site/*,*/node_modules/*,*/target/*

" map the search command
let g:ctrlp_map = '<leader>t'

" map MRU search command
map <leader>r :CtrlPMRU<CR>

" map buffers search command
map <leader>b :CtrlPBuffer<CR>

" max MRU files to remember
let g:ctrlp_mruf_max = 15

" allow more than one file to be opened at a time
let g:ctrlp_open_multi = '1t'

" increase the max height
let g:ctrlp_max_height = 20

" enable cache between sessions (reset with F5 in a search)
let g:ctrlp_clear_cache_on_exit = 0

" /== ctrlp ==

" == fugitive (and extradite) ==

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
nnoremap <leader>gl :Extradite<cr>

" /== fugitive ==
"
" == ag ==

let g:agprg="ag --noheading --nocolor --nogroup --column --nobreak"

" /== ag ==

" == airline ==

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

" /== airline ==

" == rails ==

" open in a new tab
map gn <C-W>gf

" open in the current tab
map go gf

" /== rails ==

" == tabular ==

function! s:palign()
  let p = '^\s*|\s.*\s|\s*$'

  if getline('.') =~# '^\s*|' && (getline(line('.') - 1) =~# p || getline(line('.') + 1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')], '[^|]', '', 'g'))
    let position = strlen(matchstr(getline('.')[0:col('.')], '.*|\s*\zs.*'))

    Tabularize/|/l1

    normal! 0

    call search(repeat('[^|]*|', column) . '\s\{-\}' . repeat('.', position), 'ce', line('.'))
  endif
endfunction
" auto align pipes using tabular
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>palign()<CR>a

function! s:generalAlign(regexp, post_zs, spacing)
  let prev_line_match     = getline(line('.') - 1) =~ a:regexp . a:post_zs
  let prev_line_has_curly = getline(line('.') - 1) =~ '{'
  let next_line_match     = getline(line('.') + 1) =~ a:regexp . a:post_zs
  let next_line_has_curly = getline(line('.') + 1) =~ '}'

  if !(prev_line_has_curly && next_line_has_curly) && (prev_line_match || next_line_match) && getline('.') =~ a:regexp
    let save_cursor = getpos('.')

    let cmd = 'Tabularize /'. a:regexp .'\zs' . a:post_zs . a:spacing

    " select the area to align
    exe "norm! vi{\<Esc>"

    " I'm not sure why I need this but it fixes groups without parens. Otherwise
    " they end in visual mode and '> and '< aren't reset.
    exe "norm! \<Esc>"

    " start line != stop line
    if line("'<") != line("'>'")
      let cmd = "'<,'>" . cmd
    endif

    exe cmd

    call setpos('.', save_cursor)
  endif
endfunction

function! s:colonAlign()
  call <SID>generalAlign('^\s*[a-zA-Z0-9_-]\+:', '', '/l0l1l0')
endfunction
" auto align colons using tabular
inoremap  <silent> :  :<Esc>:call <SID>colonAlign()<CR>a
" manual align
nmap <Leader>a: :call <SID>colonAlign()<CR>
" visual align
vmap <Leader>a: :Tabularize /^\s*[a-zA-Z0-9_-]\+:\zs/l0l1l0<CR>

function! s:hashRocketAlign()
  call <SID>generalAlign('^\s*\S\+\s*', '=>', '')
endfunction
" auto align
inoremap <silent> =>  =><Esc>:call <SID>hashRocketAlign()<CR>a
" manual align
nmap <Leader>a> :call <SID>hashRocketAlign()<CR>
" visual align
vmap <Leader>a> :Tabularize /^\s*\S\+\s*\zs=><CR>

nmap <Leader>a= :Tabularize /^[^=]*\zs=\+<CR>
vmap <Leader>a= :Tabularize /^[^=]*\zs=\+<CR>
nmap <Leader>a, :Tabularize /,/l0l1<CR>
vmap <Leader>a, :Tabularize /,/l0l1<CR>
nmap <Leader>a\| :Tabularize /[^{]\|\+/l0l1<CR>
vmap <Leader>a\| :Tabularize /[^{]\|\+/l0l1<CR>

" /== tabular ==

" == vim-coffee-script ==

nmap <Leader>cc :CoffeeCompile 20<CR>
vmap <Leader>cc :CoffeeCompile 20<CR>

" == /vim-coffee-script ==

" == switch ==

nnoremap <leader>s :Switch<cr>

" additional definitions
let g:switch_custom_definitions =
    \ [
    \   ['to ', 'to_not ']
    \ ]

" /== switch ==

" == Syntastic ==

let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_ruby_rubocop_quiet_messages = { "level": [] }

let g:syntastic_elixir_checkers = ['elixir']

let g:syntastic_javascript_checkers = ['jshint']

" Some checkers have security issues and have to be manually enabled.
let g:syntastic_enable_elixir_checker = 1

nnoremap <leader>el :Errors<cr>
nnoremap <leader>er :SyntasticReset<cr>
nnoremap <leader>et :SyntasticToggleMode<cr>

" /== Syntastic ==

" /==== Addons ====

" easier ESC
imap kj <Esc>
imap jk <Esc>

" intuitive backspacing in insert mode
set backspace=indent,eol,start

" sudo write
ca w!! w !sudo tee >/dev/null "%"

" no more shift
map ; :

" arg!
map <F1> <ESC>

" new
map <F4> :tabe<CR>

" open
map <F5> :tabe

" close
map <F6> :qa<CR>

" toggle line numbers
map <F7> :set nonumber!<CR>

" toggle pasting
set pastetoggle=<F8>

" toggle spell checking
nmap <F10> :setlocal spell! spelllang=en_us<CR>
imap <F10> <C-o>:setlocal spell! spelllang=en_us<CR>

" add spell checking to git commit messages
autocmd Filetype gitcommit setlocal spell

" easier number increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

" never enter Ex mode
nnoremap Q <nop>

" clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" run elixir code
nmap <Leader>ec :!elixir %<CR>

" run elixir mix tasks
nmap <Leader>mt :!mix test<CR>

" shortcuts via misspell
iabbrev al@ aaron.lasseigne@gmail.com

function! BetterComments ()
  setlocal comments-=:# " remove standard comments
  setlocal comments+=f:# " replace with comments that don't get automatically created on a return
endfunction
autocmd FileType ruby,eruby,perl call BetterComments()

" link file types
autocmd FileType eruby set filetype=eruby.html.javascript
autocmd FileType scss set filetype=css
au BufRead,BufNewFile *.es6 set filetype=javascript
