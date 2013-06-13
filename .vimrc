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

" add lines above and below the current scroll point
set scrolloff=4

" highlight the opening/closing parens, braces, etc
set showmatch

" highlight the current line and column
set cursorline
set cursorcolumn

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

" vim addon manager
"
" ack                = adds support for the ack command
" matchit.zip        = more complete '%' matching
" rails              = RoR support
" delimitMate        = automatically adds closing paren, quote, etc
" fugitive           = built-in support for git
" extradite          = plugin for fugitive that provides tig like interface
" Tabular            = alignment helper
" vim-coffee-script  = cs support
" ctrlp              = file searching
" tComment           = easily add/remove commenting
" vim-ruby           = ruby support
" YankRing           = cycle through previous pastes after pasting
" IndexedSearch      = shows 'Nth match out of M' when searching
" endwise            = adds 'end' to Ruby blocks
" neocomplcache      = completion as you type
" neosnippet         = expandable snippets
" surround           = change surrounding stuff (parens, quotes, tags, etc)
" repeat             = adds "." support for surround
" vim-powerline      = better vim statusline
" markdown@tpope     = markdown support
" vim-clojure-static = clojure support

fun! EnsureVamIsOnDisk(vam_install_path)
  " windows users may want to use http://mawercer.de/~marc/vam/index.php
  " to fetch VAM, VAM-known-repositories and the listed plugins
  " without having to install curl, 7-zip and git tools first
  " -> BUG [4] (git-less installation)
  let is_installed_c = "isdirectory(a:vam_install_path.'/vim-addon-manager/autoload')"
  if eval(is_installed_c)
    return 1
  else
    if 1 == confirm("Clone VAM into ".a:vam_install_path."?","&Y\n&N")
      " I'm sorry having to add this reminder. Eventually it'll pay off.
      call confirm("Remind yourself that most plugins ship with ".
                  \"documentation (README*, doc/*.txt). It is your ".
                  \"first source of knowledge. If you can't find ".
                  \"the info you're looking for in reasonable ".
                  \"time ask maintainers to improve documentation")
      call mkdir(a:vam_install_path, 'p')
      execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.shellescape(a:vam_install_path, 1).'/vim-addon-manager'
      " VAM runs helptags automatically when you install or update 
      " plugins
      exec 'helptags '.fnameescape(a:vam_install_path.'/vim-addon-manager/doc')
    endif
    return eval(is_installed_c)
  endif
endf

fun! SetupVAM()
  " Set advanced options like this:
  " let g:vim_addon_manager = {}
  " let g:vim_addon_manager['key'] = value

  " Example: drop git sources unless git is in PATH. Same plugins can
  " be installed from www.vim.org. Lookup MergeSources to get more control
  " let g:vim_addon_manager['drop_git_sources'] = !executable('git')
  " let g:vim_addon_manager.debug_activation = 1

  " VAM install location:
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  if !EnsureVamIsOnDisk(vam_install_path)
    echohl ErrorMsg
    echomsg "No VAM found!"
    echohl NONE
    return
  endif
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " Tell VAM which plugins to fetch & load:
  call vam#ActivateAddons(['ack', 'matchit.zip', 'rails', 'delimitMate', 'fugitive', 'Tabular', 'vim-coffee-script', 'ctrlp', 'extradite', 'tComment', 'vim-ruby', 'neocomplcache', 'YankRing', 'IndexedSearch', 'endwise', 'neosnippet', 'surround', 'repeat', 'Powerline', 'markdown@tpope', 'vim-clojure-static'])
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})

  " Addons are put into vam_install_path/plugin-name directory
  " unless those directories exist. Then they are activated.
  " Activating means adding addon dirs to rtp and do some additional
  " magic

  " How to find addon names?
  " - look up source from pool
  " - (<c-x><c-p> complete plugin names):
  " You can use name rewritings to point to sources:
  "    ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
  "    ..ActivateAddons(["github:user/repo", .. => github://user/repo
  " Also see section "2.2. names of addons and addon sources" in VAM's documentation
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
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so,*.swp,*/doc/*

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
nnoremap <Leader>gD :diffoff!<cr><c-w>h:bd<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gb :Gblame<cr>
vnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gB :Gblame -w -M -C -C -C<cr>
vnoremap <leader>gB :Gblame -w -M -C -C -C<cr>
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

" never enter Ex mode
nnoremap Q <nop>

" clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

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
autocmd FileType cfm set filetype=cfm
