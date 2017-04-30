" enable 24 bit colors if available

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! vim_sass_colors#run()
  if has("termguicolors")
    set termguicolors
  endif

  " run ruby script to parse sass color imports
  let b:cout = system('ruby ' . s:path . '/sass-colors.rb ' . expand('%:p'))

  " loop over all output in format: 
  " name:guibg:ctermbg:guifg:ctermfg:rgb
  " rgb already comes in regex format so we don't have to worry about spaces
  let b:carr = split(b:cout)
  for b:cline in b:carr
    let b:cvar = split(b:cline, ':')
    let b:g = 'SASS' . b:cvar[1]

    exe  'hi ' . b:g . ' ctermbg=' . b:cvar[2] . ' guibg=#' . b:cvar[1] . ' guifg=#' . b:cvar[3] . ' ctermfg=' . b:cvar[4]
    if b:cvar[0] != 'placeholdervar'
      let b:m1 = matchadd(b:g, '$'.b:cvar[0])
    end
    let b:m2 = matchadd(b:g, '\c#'.b:cvar[1])
    let b:m3 = matchadd(b:g, b:cvar[5])
  endfor

endfunction
