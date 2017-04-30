![vim sass colors sample](https://raw.githubusercontent.com/shmargum/vim-sass-colors/master/vim-sass-color-sample-6.png)

This is a vim plugin to highlight sass color variables.

Install via pathogen

This currently only works for hex values.

This is currently optimized to recursively call all imports.
If the file path contains /scss/ /sass/ /stylesheets/ the plugin will search imports relative to that folder, otherwise will look for imports relative to the folder rhat the file is in.

To get true 24-bit colors you should use a flavor of vim that supports the `termguicolors` option
This option is available in iTerm2 and neovim (at least)
