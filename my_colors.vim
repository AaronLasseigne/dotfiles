" system

hi Normal       ctermfg=252 ctermbg=234

hi LineNr       ctermfg=236 ctermbg=234

hi CursorLine   ctermbg=233 cterm=NONE
hi CursorColumn ctermbg=233
hi CursorLineNr ctermfg=242

hi NonText      ctermfg=236

" code

" This doesn't work :(
syn match Braces display '[{}()\[\]]'
hi Braces       ctermfg=242

hi Comment      ctermfg=238
hi Todo         ctermfg=136 ctermbg=234

hi Constant     ctermfg=140

hi Identifier   ctermfg=252 cterm=NONE

hi Statement    ctermfg=220

hi PreProc      ctermfg=252

hi Function     ctermfg=34
hi Type         ctermfg=38

hi Special      ctermfg=168

hi Underlined   ctermfg=252

hi Search       ctermfg=0 ctermbg=136
hi Pmenu        ctermfg=0 ctermbg=137
hi PmenuSel     ctermfg=137 ctermbg=240

hi DiffChange   ctermbg=88
hi DiffText     ctermbg=54
