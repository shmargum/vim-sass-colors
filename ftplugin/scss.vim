if exists("b:did_vim_sass_colors")
  finish
endif
let b:did_vim_sass_colors = 1
call vim_sass_colors#init()
