" leader
let mapleader=','

" turn on filetype detection
filetype plugin indent on

" ==== DISPLAY ====

" encoding
set encoding=utf-8

" colors
set t_Co=256
syntax enable
colorscheme my_colors

" show the tab line
set showtabline=2

" show the ruler
set ruler

" show line numbers
set number

" add lines above and below the current scroll point
set scrolloff=5

" highlight the opening/closing parens, braces, etc
set showmatch

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

" Ack for the last search.
nnoremap <silent> <leader>? :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

" clear search highlighting
noremap <silent><leader>cs :nohls<CR>

" /==== SEARCH ====


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

" autoinstall script
fun! SetupVAM()
  " YES, you can customize this vam_install_path path and everything still works!
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " * unix based os users may want to use this code checking out VAM
  " * windows users want to use http://mawercer.de/~marc/vam/index.php
  " to fetch VAM, VAM-known-repositories and the listed plugins
  " without having to install curl, unzip, git tool chain first
  " -> BUG [4] (git-less installation)
  if !filereadable(vam_install_path.'/vim-addon-manager/.git/config') && 1 == confirm("git clone VAM into ".vam_install_path."?","&Y\n&N")
    " I'm sorry having to add this reminder. Eventually it'll pay off.
    call confirm("Remind yourself that most plugins ship with documentation (README*, doc/*.txt). Its your first source of knowledge. If you can't find the info you're looking for in reasonable time ask maintainers to improve documentation")
    exec '!p='.shellescape(vam_install_path).'; mkdir -p "$p" && cd "$p" && git clone --depth 1 git://github.com/MarcWeber/vim-addon-manager.git'
    " VAM run helptags automatically if you install or update plugins
    exec 'helptags '.fnameescape(vam_install_path.'/vim-addon-manager/doc')
  endif

  " Example drop git sources unless git is in PATH. Same plugins can
  " be installed form www.vim.org. Lookup MergeSources to get more control
  " let g:vim_addon_manager['drop_git_sources'] = !executable('git')

  call vam#ActivateAddons([], {'auto_install' : 0})
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
  " - look up source from pool (<c-x><c-p> complete plugin names):
  " ActivateAddons(["foo", ..
  " - name rewritings:
  " ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
  " ..ActivateAddons(["github:user/repo", .. => github://user/repo
  " Also see section "2.2. names of addons and addon sources" in VAM's documentation
endfun
call SetupVAM()

" vim addon manager
"
" ack                             = adds support for the ack command
" matchit.zip                     = more complete '%' matching
" rails                           = RoR support
" The_NERD_tree                   = file browsing
" delimitMate                     = automatically adds closing paren, quote, etc
" fugitive                        = built in support for git
" extradite                       = plugin for fugitive that provides tig like interface
" Tabular                         = alignment helper
" vim-coffee-script               = cs support
" ctrlp                           = file searching
" tComment                        = easily add/remove commenting
" vim-ruby                        = ruby support
" YankRing                        = cycle through previous pastes after pasting
" IndexedSearch                   = shows 'Nth match out of M' when searching
" endwise                         = adds 'end' to Ruby blocks
" neocomplcache                   = completion as you type
" neocomplcache-snippets-complete = expandable snippets
" surround                        = change surrounding stuff (parens, quotes, tags, etc)
" repeat                          = adds "." support for surround
" tagbar                          = ctag support
" textobj-rubyblock               = use "ar" and "ir" to select ruby blocks
" zencoding                       = easy html creation using css selector like syntax
" vim-powerline                   = better vim statusline
fun ActivateAddons()
  set runtimepath+=~/.vim-addons/vim-addon-manager
  try
    call vam#ActivateAddons(['ack', 'matchit.zip', 'rails', 'The_NERD_tree', 'delimitMate', 'fugitive', 'Tabular', 'vim-coffee-script', 'ctrlp', 'extradite', 'tComment', 'github:vim-ruby/vim-ruby', 'neocomplcache', 'YankRing', 'IndexedSearch', 'endwise', 'neocomplcache-snippets-complete', 'surround', 'repeat', 'Tagbar', 'textobj-rubyblock', 'ZenCoding', 'Powerline'])
  catch /.*/

    echoe v:exception
  endtry
endf
call ActivateAddons()

" == YankRing ==

" I had to set this as a fix for version 13
let g:yankring_manual_clipboard_check = 0

" make the history file a dotfile so it disappears
let g:yankring_history_file = '.yankring_history'

" /== YankRing ==

" == neocomplcache-snippets-complete ==

let g:neocomplcache_snippets_dir = '~/.vim/snippets'

" /== neocomplcache-snippets-complete ==

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

" tab key completion
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" /== neocomplcache ==

" == ctrlp ==

" ignore stuff when searching
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so,*.swp,*/doc/*

" map the search command
let g:ctrlp_map = '<leader>t'

" allow more than one file to be opened at a time
let g:ctrlp_open_multi = '1t'

" increase the max height
let g:ctrlp_max_height = 20

" enable cache between sessions (reset with F5 in a search)
let g:ctrlp_clear_cache_on_exit = 0

" /== ctrlp ==

" == The_NERD_tree ==

" reduces clutter in the UI
let NERDTreeMinimalUI = 1

" use prettier arrows
let NERDTreeDirArrows = 1

map <F2> :NERDTreeToggle<CR>

" /== The_NERD_tree ==

" == fugitive (and extradite) ==

nnoremap <leader>gd :Gdiff<cr>
nnoremap <Leader>gD :diffoff!<cr><c-w>h:bd<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gb :Gblame<cr>
vnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gl :Extradite<cr>

" /== fugitive ==

" == ack ==

" -H = print filename
" --nogroup = do not group results by file
" --column = show the column number of the first match
let g:ackprg="ack -H --nocolor --nogroup --column"

" no shift needed
map :ack :Ack

" /== ack ==

" == rails ==

" open in a new tab
map gn <C-W>gf

" open in the current tab
map go gf

" /== rails ==

" == tabular ==

" auto align pipes using tabular
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>palign()<CR>a
function! s:palign()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" FIX - does not work with nested blocks
function! s:colonAlign()
  let regexp = '^\s*[a-zA-Z0-9_-]\+:'

  let prev_line_match     = getline(line('.') - 1) =~ regexp
  let prev_line_has_curly = getline(line('.') - 1) =~ '{'
  let next_line_match     = getline(line('.') + 1) =~ regexp
  let next_line_has_curly = getline(line('.') + 1) =~ '}'

  if !(prev_line_has_curly && next_line_has_curly) && (prev_line_match || next_line_match) && getline('.') =~ regexp
    let save_cursor = getpos('.')

    let cmd = 'Tabularize /'. regexp .'\zs/l0l1l0'

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
" auto align colons using tabular
inoremap  <silent> :  :<Esc>:call <SID>colonAlign()<CR>a
" manual align
nmap <Leader>a: :call <SID>colonAlign()<CR>
" visual align
vmap <Leader>a: :Tabularize /^\s*[a-zA-Z0-9_-]\+:\zs/l0l1l0<CR>

" FIX - does not work with nested blocks
function! s:hashRocketAlign()
  let regexp = '^\s*\S\+\s*'

  let prev_line_match     = getline(line('.') - 1) =~ regexp . '=>'
  let prev_line_has_curly = getline(line('.') - 1) =~ '{'
  let next_line_match     = getline(line('.') + 1) =~ regexp . '=>'
  let next_line_has_curly = getline(line('.') + 1) =~ '}'

  if !(prev_line_has_curly && next_line_has_curly) && (prev_line_match || next_line_match) && getline('.') =~ regexp
    let save_cursor = getpos('.')

    let cmd = 'Tabularize /'. regexp .'\zs=>'

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

" == Powerline ==

" always show the status line
set laststatus=2

" use some custom symbols
let g:Powerline_symbols_override = {
      \ 'BRANCH': [0x2213]
      \ }

" /== Powerline ==

" /==== Addons ====

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

" easier number increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

" clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" shortcuts via misspell
iabbrev al@ aaron.lasseigne@gmail.com

function BetterComments ()
  setlocal comments-=:# " remove standard comments
  setlocal comments+=f:# " replace with comments that don't get automatically created on a return
endfunction
autocmd FileType ruby,eruby,perl call BetterComments()

" link file types
autocmd FileType eruby set filetype=eruby.html.javascript
autocmd FileType scss set filetype=css
autocmd FileType cfm set filetype=cfm
