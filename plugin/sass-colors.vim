if has("termguicolors")
  set termguicolors
endif

" run ruby script to parse sass color imports
let s:cout = system('ruby ' . expand('<sfile>:p:h') . '/sass-colors.rb ' . expand('%:p'))

let s:carr = split(s:cout)

for s:cline in s:carr
  let s:cvar = split(s:cline, ':')
  let s:g = 'SASS' . s:cvar[1]

  exe  'hi ' . s:g . ' ctermbg=' . s:cvar[2] . ' guibg=#' . s:cvar[1] . ' guifg=#' . s:cvar[3]
  let s:m = matchadd(s:g, '$'.s:cvar[0])

endfor
