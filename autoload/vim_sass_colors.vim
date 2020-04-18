" get path of script, ruby file is in the same dir
let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! vim_sass_colors#init()
  " enable 24 bit colors if available
  if has("termguicolors")
    set termguicolors
  endif

  " run once on load and on save and reading new buffers
  call vim_sass_colors#run()
  autocmd BufWritePost * call vim_sass_colors#write()
  autocmd BufReadPost * call vim_sass_colors#run()

  " autocmd that will set up the w:created variable
  autocmd VimEnter * autocmd WinEnter * let w:created=1
  autocmd WinEnter * if !exists('w:created') | call vim_sass_colors#run() | endif
endfunction

" clear old color variable names so we can reassign if needed on save
function! vim_sass_colors#write()
  for l:old_match in w:vim_sass_color_matches
    call matchdelete(l:old_match)
  endfor
  call vim_sass_colors#run()
endfunction

" run ruby script and highlight things
function! vim_sass_colors#run()
  let w:vim_sass_color_matches = []
  " run ruby script to parse sass color imports
  " argument is the absolute sass filename
  let l:ruby_output = system('ruby ' . s:path . '/sass-colors.rb ' . expand('%:p'))

  " loop over all output in format:
  " name:guibg:ctermbg:guifg:ctermfg:rgb(a)(regex)
  " rgb already comes in regex format so we don't have to worry about spaces
  let l:colors = split(l:ruby_output)
  for l:color_string in l:colors
    let [l:cname, l:guibg, l:ctermbg, l:guifg, l:ctermfg, l:rgb, l:tdx, l:cssname, l:hsl] = split(l:color_string, ':')
    let l:group = 'SASS' . l:guibg

    if hlexists(l:group) == 0
      " create highlight group if it doesn't exist
      exe  'hi ' . l:group . ' ctermbg=' . l:ctermbg . ' guibg=#' . l:guibg . ' guifg=#' . l:guifg . ' ctermfg=' . l:ctermfg
      " add 6 digit hex match to group, case-insensitive
      call matchadd(l:group, '\c#'.l:guibg)
      " add rgb regex match to group
      call matchadd(l:group, l:rgb)
    endif

    if l:tdx != 'none'
      " add 3 digit hex match to group, case-insensitive
      call matchadd(l:group, '\c\v#'.l:tdx.'\ze([^a-zA-Z0-9-_]|$)')
    endif

    if l:cssname != 'none'
      " add css name digit, case-insensitive
      call matchadd(l:group, '\c\v([^a-zA-Z0-9-_$])\zs'.l:cssname.'\ze([^a-zA-Z0-9-_]|$)')
    endif

    if l:hsl != 'none'
      " add hsl regex match to group
      call matchadd(l:group, l:hsl)
    endif

    " only add $variable name to group
    if l:cname != 'placeholder'
      let l:new_match =  matchadd(l:group, '\v[$@]'.l:cname.'([^a-zA-Z0-9-_])@=')
      let l:new_match2 =  matchadd(l:group, '\v[$@]'.l:cname.'($)@=')
      call add(w:vim_sass_color_matches, l:new_match)
      call add(w:vim_sass_color_matches, l:new_match2)
    endif
  endfor

endfunction
