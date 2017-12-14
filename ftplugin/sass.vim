if exists("w:did_vim_sass_colors")
  finish
endif
let w:did_vim_sass_colors = 1
call vim_sass_colors#init()
