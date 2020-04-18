vim-sass-colors
===============

This is a vim plugin to highlight sass/scss/less/css colors and color variables.  It works with imports!

![vim sass colors sample](https://raw.githubusercontent.com/shmargum/vim-sass-colors/master/vim-sass-color-sample-8.png)

## Installation

Install via [pathogen](https://github.com/tpope/vim-pathogen)
```bash
cd ~/.vim/bundle
git clone https://github.com/shmargum/vim-sass-colors.git
```

Install via [Vundle](https://github.com/VundleVim/Vundle.vim)
```vim
Plugin 'https://github.com/shmargum/vim-sass-colors.git'
```

## Dependencies
This plugin uses ruby

## Features
* Highlights 3 and 6 digit hex, rgb(a), hsl(a), and regular css colors
* Uses 24 bit colors if available; fallback to a 256 colors approximation otherwise
* Automatically tries to process imports
* Automatically tries to import master color definition files

## Configuration options
### Env Vars
* `VIM_SASS_COLORS_BASE_FOLDERS`
  * Set the base stylesheet directories
  * default: `sass,scss,less,css,stylesheets,style,styles`
* `VIM_SASS_COLORS_BASE_FILES`
  * Set the default/base file to automatically import
  * default: `colors,variables`

Example in .zshrc (or .bashrc)
```bash
export VIM_SASS_COLORS_BASE_FILES="colors,variables,custom-file-name"
export VIM_SASS_COLORS_BASE_FOLDERS="sass,scss,less,css,stylesheets,style,styles,custom-folder-name"
```
### Vim Options
Disable by adding `autocmd BufReadPre,BufNewFile * let b:did_vim_sass_colors = 1` to your .vimrc before the `filetype plugin on` line.

## Notes
* To get true 24-bit colors you should use a flavor of vim that supports the `termguicolors` option
* This option is available in iTerm2 and neovim (at least)

## Contributing
Submit an issue or PR

## License
MIT License
