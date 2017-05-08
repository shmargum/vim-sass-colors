" get path of script, ruby file is in the same dir
let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! vim_sass_colors#init()
  " enable 24 bit colors if available
  if has("termguicolors")
    "set termguicolors
  endif

  " run once on load and on save
  call vim_sass_colors#run()
  autocmd BufWritePost * call vim_sass_colors#run()
endfunction

function! vim_sass_colors#run()
  " run ruby script to parse sass color imports
  " argument is the absolute sass filename
  let l:ruby_output = system('ruby ' . s:path . '/sass-colors.rb ' . expand('%:p'))

  " loop over all output in format: 
  " name:guibg:ctermbg:guifg:ctermfg:rgb(a)(regex)
  " rgb already comes in regex format so we don't have to worry about spaces
  let l:colors = split(l:ruby_output)
  for l:color_string in l:colors
    let [l:cname, l:guibg, l:ctermbg, l:guifg, l:ctermfg, l:rgb] = split(l:color_string, ':')
    let l:group = 'SASS' . l:guibg

    " create highlight group
    exe  'hi ' . l:group . ' ctermbg=' . l:ctermbg . ' guibg=#' . l:guibg . ' guifg=#' . l:guifg . ' ctermfg=' . l:ctermfg

    " add $variable name to group, check for colors with no $variables
    if l:cname != 'placeholdervar'
      let l:m1 = matchadd(l:group, '$'.l:cname)
    end
    " add 6 digit hex match to group, case-insensitive
    let l:m2 = matchadd(l:group, '\c#'.l:guibg)
    " add rgb regex match to group
    let l:m3 = matchadd(l:group, l:rgb)
  endfor

endfunction
