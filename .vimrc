" leader
let mapleader=','

" display
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

set encoding=utf-8

set title
set ruler
set number

set backspace=indent,eol,start " intuitive backspacing in insert mode

" scrolling
set scrolloff=5

" search
set incsearch
set hlsearch
set ignorecase
set smartcase
" clear search 
noremap <silent><leader>cs :nohls<CR>

" tab completion
set iskeyword+=: " allows completion of namespaces
set wildmenu
set wildmode=list:longest " only completes up to the point of ambiguity

" tabs
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab

" indenting
set autoindent
set smartindent
set cindent
set cinkeys-=0# " stops VIM from indenting comments

set showmatch

let $wrapOn=0
let $indentOn=1

" pasting
set pastetoggle=<F8>

" sudo write
ca w!! w !sudo tee >/dev/null "%"

" mappings
map ; :
map :W :w
map :Q :q
map :ack :Ack

map <F1> <ESC>
map <F2> :NERDTreeToggle<CR>
map <F5> :tabe 
map <S-F5> :tabe<CR>
map <F6> :qa<CR>
map <S-F6> :qa!<CR>
map <F7> :set nonumber!<CR>
nmap <F10> :setlocal spell! spelllang=en_us<CR>
imap <F10> <C-o>:setlocal spell! spelllang=en_us<CR>

" easier number increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

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

" Clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" shortcuts via misspell
iabbrev al@ aaron.lasseigne@gmail.com

" multilingual editting
filetype plugin on
filetype indent on

" vim tabs
set showtabline=2

" vim addon manager
fun ActivateAddons()
  set runtimepath+=~/.vim-addons/vim-addon-manager
  try
    call vam#ActivateAddons(['ack', 'matchit.zip', 'rails', 'The_NERD_tree', 'delimitMate', 'fugitive', 'tabular', 'vim-coffee-script', 'ctrlp', 'extradite', 'tComment', 'vim-ruby', 'neocomplcache', 'YankRing', 'IndexedSearch', 'endwise', 'neocomplcache-snippets-complete'])
  catch /.*/

    echoe v:exception
  endtry
endf
call ActivateAddons()

" for YankRing
let g:yankring_history_file = '.yankring_history'

" for neocomplchache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" for ctrlp
let g:ctrlp_map = '<leader>t'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so,*.swp
let g:ctrlp_open_multi = '1t'

" for nerd tree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" for fugitive
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

" for the ack.vim plugin
let g:ackprg="ack -H --nocolor --nogroup --column"

" rails file opening
map gn <C-W>gf
map go gf

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

" Tabular mappings
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

function BetterComments ()
  setlocal comments-=:# " remove standard comments
  setlocal comments+=f:# " replace with comments that don't get automatically created on a return
endfunction

autocmd FileType ruby,eruby,perl call BetterComments()

" link file types
autocmd FileType eruby set filetype=eruby.html.javascript
autocmd FileType scss set filetype=css
autocmd FileType cfm set filetype=cfm
