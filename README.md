vim-sass-colors
===============

This is a vim plugin to highlight sass colors and color variables.

This is not meant for regular css files which do not use sass style variables -- there are alternatives with support for more color literal formats out there currently such as [vim-coloresque](https://github.com/gko/vim-coloresque)

![vim sass colors sample](https://raw.githubusercontent.com/shmargum/vim-sass-colors/master/vim-sass-color-sample-7.png)

### Instalation

Install via [pathogen](https://github.com/tpope/vim-pathogen)
```
cd ~/.vim/bundle
git clone https://github.com/shmargum/vim-sass-colors.git
```

Install via [Vundle](https://github.com/VundleVim/Vundle.vim)
```
Plugin 'https://github.com/shmargum/vim-sass-colors.git'
```

### Dependencies
* This plugin uses ruby

### Motivation

Do you like to keep a color palette in your projects using sass? Do you like to see colorvalues highlighted in pretty colors? Would you find it helpful to quickly scroll through your sass files and see what colors are being used where? Ever find it hard to locate instances of old colors that need to be updated?
If the answer to any of these questions is 'yes' then this plugin will make you happy.

There are several plugins out there that can highlight color literals, but for my projects using sass where we import a common color palette, or import sass partials with color definitions, they were of little use.  This plugin was created for projects like this.  The goal is to be able to use this across projects that use imports and use sass variables to store color values to make it easier to quickly look at one of your stylesheets and update specific colors.

### Features
* Highlights inline 6 digit hex, rgb, and rgba colors
* Uses 24 bit colors if available, fallback to a 256 colors approximation otherwise
* Highlights $sass-variables that are assigned a color
* Highlights $sass-variables that are assigned another $sass-variable that is a color
* Automatically looks for a default color definition file to include if the current file is within a stylesheets directory
* Automatically parses and looks for imports (using globbing) relative to a stylesheet directory if the current file is within one, or relative to the folder the current file is in otherwise
* Looks for files with and without leading underscore `_`

### Definitions, constants, and options
* Default stylesheet directories: `/scss/`, `/sass/`, `/stylesheets/`
* Default color imports: `colors` or `_colors` (.scss or .sass)
* Default color palette: 24 bits, 256 color (approximation) fallback
* Supported color formats: 6 digit hex, rgb, rgba
* Disable by adding `autocmd BufReadPre,BufNewFile * let b:did_vim_sass_colors = 1` to your .vimrc before the `filetype plugin on` line.

### Future Plans
* Add option to toggle 24 bit color mode
* Add support for hsl, hsla, 3 digit hex, maybe other formats
* Add option to specify alternative default color file import
* Add option to specify directory imports
* Maybe add option to exclude certian import paths
* Maybe port ruby to vimscript

### Notes
* 24-bit colors
  * To get true 24-bit colors you should use a flavor of vim that supports the `termguicolors` option
  * This option is available in iTerm2 and neovim (at least)
  * Switching over for the first time may change your color scheme, though I just added 3 lines to my .vimrc to set 3 24 bit highlight groups to their former 256 xterm color value
* 256 colors
  * If you do not have 24 bit color support enabled in your vim the highlight colors will fallback to a 256 color approximation
  * This approximation is based on the sum of the squared differences between each r, g, and b value

### Contributing
Submit an issue or PR

### License
MIT License
