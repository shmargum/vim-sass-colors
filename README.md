![vim sass colors sample](https://raw.githubusercontent.com/shmargum/vim-sass-colors/master/vim-sass-color-sample-6.png)

This is a vim plugin to highlight sass colors and color variables.

Install via pathogen
```
cd ~/.vim/bundle
git clone https://github.com/shmargum/vim-sass-colors.git
```

This currently only works for hex and rgb values.

This is currently optimized to recursively call all imports.
If the file path contains /scss/ /sass/ /stylesheets/ the plugin will search imports relative to that folder, otherwise will look for imports relative to the folder that the file is in.

To get true 24-bit colors you should use a flavor of vim that supports the `termguicolors` option
This option is available in iTerm2 and neovim (at least)
