" leader
let mapleader=','

" turn on filetype detection
filetype plugin indent on

" ==== DISPLAY ====

" encoding
set encoding=utf-8

" colors
set t_Co=256
set background=dark
syntax on

hi TabLine      ctermfg=252 ctermbg=240
hi TabLineFill  ctermfg=240

hi Comment      ctermfg=114 cterm=bold

hi Constant     ctermfg=245
hi String       ctermfg=255
hi Character    ctermfg=255
hi Number       ctermfg=255
hi Boolean      ctermfg=255
hi Float        ctermfg=255

hi Identifier   ctermfg=38 cterm=NONE
hi Function     ctermfg=38 cterm=bold

hi Statement    ctermfg=160
hi PreProc      ctermfg=160

hi Type         ctermfg=38 cterm=bold

hi Special      ctermfg=245

hi Underlined   ctermfg=250

hi Search       ctermfg=0 ctermbg=228
hi Pmenu        ctermfg=0 ctermbg=137
hi PmenuSel     ctermfg=137 ctermbg=240

hi DiffChange   ctermbg=88
hi DiffText     ctermbg=54

hi LineNr       ctermfg=137 ctermbg=234

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

" vim addon manager
"
" ack                             = adds support for the ack command
" matchit.zip                     = more complete '%' matching
" rails                           = RoR support
" The_NERD_tree                   = file browsing
" delimitMate                     = automatically adds closing paren, quote, etc
" fugitive                        = built in support for git
" extradite                       = plugin for fugitive that provides tig like interface
" tabular                         = alignment helper
" vim-coffee-script               = cs support
" ctrlp                           = file searching
" tComment                        = easily add/remove commenting
" vim-ruby                        = ruby support
" YankRing                        = cycle through previous pastes after pasting
" IndexedSearch                   = shows 'Nth match out of M' when searching
" endwise                         = adds 'end' to Ruby blocks
" neocomplcache                   = completion as you type
" neocomplcache-snippets-complete = expandable snippets
fun ActivateAddons()
  set runtimepath+=~/.vim-addons/vim-addon-manager
  try
    call vam#ActivateAddons(['ack', 'matchit.zip', 'rails', 'The_NERD_tree', 'delimitMate', 'fugitive', 'tabular', 'vim-coffee-script', 'ctrlp', 'extradite', 'tComment', 'vim-ruby', 'neocomplcache', 'YankRing', 'IndexedSearch', 'endwise', 'neocomplcache-snippets-complete'])
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
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so,*.swp

" map the search command
let g:ctrlp_map = '<leader>t'

" allow more than one file to be opened at a time
let g:ctrlp_open_multi = '1t'

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
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
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

" auto align colons using tabular
inoremap <silent> : <Esc>:call <SID>calign()<CR>a
function! s:calign()
  let c = '^\s*[a-zA-Z0-9_-]\+'
  if exists(':Tabularize') && getline('.') =~# c."$" && (getline(line('.')-1) =~# c.":" || getline(line('.')+1) =~# c.":")
    let up_match_good = search('{', 'bnW')
    let up_match_bad  = search('}', 'bnW')
    let down_match    = search('}', 'nW')
    if down_match && up_match_good && up_match_good > up_match_bad
      if down_match - up_match_good != 2
        let current_line = line('.')
        normal! a:'
        :?{?+;/}/-call Tabularize('/'.c.':\zs/l0l1l0')
        call cursor(current_line, '0')
        normal! $xx
      else
        normal! a:
      endif
    else
      normal! a:'
      call Tabularize('/'.c.':\zs/l0l1l0')
      normal! $xx
    endif
  else
    normal! a:
  endif
endfunction

" auto align hash rocket using tabular
inoremap <silent> => <Esc>:call <SID>halign()<CR>a
function! s:halign()
  let h = '^\s*\S\+\s*'
  if exists(':Tabularize') && getline('.') =~# h."$" && (getline(line('.')-1) =~# h."\=\>" || getline(line('.')+1) =~# h."\=\>")
    let up_match_good = search('{', 'bnW')
    let up_match_bad  = search('}', 'bnW')
    let down_match    = search('}', 'nW')
    if down_match && up_match_good && up_match_good > up_match_bad
      if down_match - up_match_good != 2
        let current_line = line('.')
        normal! a=>'
        :?{?+;/}/-call Tabularize('/'.h.'=>')
        call cursor(current_line, '0')
        normal! $xx
      else
        normal! a=>
      endif
    else
      normal! a=>'
      call Tabularize('/'.h.'=>')
      normal! $xx
    endif
  else
    normal! a=>
  endif
endfunction

nmap <Leader>a= :Tabularize /=\+<CR>
vmap <Leader>a= :Tabularize /=\+<CR>
nmap <Leader>a: :Tabularize /^\s*[a-zA-Z0-9_-]\+:\zs/l0l1l0<CR>
vmap <Leader>a: :Tabularize /^\s*[a-zA-Z0-9_-]\+:\zs/l0l1l0<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>
nmap <Leader>a, :Tabularize /,/l0l1<CR>
vmap <Leader>a, :Tabularize /,/l0l1<CR>
nmap <Leader>a\| :Tabularize /[^{]\|\+/l0l1<CR>
vmap <Leader>a\| :Tabularize /[^{]\|\+/l0l1<CR>

" /== tabular ==

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
