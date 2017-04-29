![vim sass colors sample](https://raw.githubusercontent.com/shmargum/vim-sass-colors/master/vim-sass-color-sample-2.png)

This is a vim plugin to highlight sass color variables.

This currently only works for hex values.

This is currently optimized to recursively call all imports, but assumes a rails file structure (app/assets/stylesheets)

To get true 24-bit colors you should use a flavor of vim that supports the `termguicolors` option
This option is available in iTerm2 and neovim (at least)
