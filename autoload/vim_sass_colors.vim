" get path of script, ruby file is in the same dir
let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! vim_sass_colors#init()
  let b:matches = []
  " enable 24 bit colors if available
  if has("termguicolors")
    set termguicolors
  endif

  " run once on load and on save
  call vim_sass_colors#run()
  autocmd BufWritePost * call vim_sass_colors#run()
endfunction

function! vim_sass_colors#run()
  " clear old color variable names so we can reassign if needed on save
  for l:old_match in b:matches
    call matchdelete(l:old_match)
  endfor
  let b:matches = []
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

    if hlexists(l:group) == 0
      " create highlight group if it doesn't exist
      exe  'hi ' . l:group . ' ctermbg=' . l:ctermbg . ' guibg=#' . l:guibg . ' guifg=#' . l:guifg . ' ctermfg=' . l:ctermfg
      " add 6 digit hex match to group, case-insensitive
      call matchadd(l:group, '\c#'.l:guibg)
      " add rgb regex match to group
      call matchadd(l:group, l:rgb)
    endif

    " only add $variable name to group
    if l:cname != 'placeholder'
      let l:new_match =  matchadd(l:group, '$'.l:cname)
      call add(b:matches, l:new_match)
    endif
  endfor

endfunction
