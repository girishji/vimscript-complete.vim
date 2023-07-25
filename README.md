# Vimscript Language Completion Helper for Vimcomplete Plugin

This plugin is a helper for Vim completion plugin
[Vimcomplete](https://github.com/girishji/vimcomplete). It completes Vimscript
function names, arguments, variables, reserved words and the like.


# Requirements

- Vim >= 9.0

# Installation

Install this plugin after [Vimcomplete](https://github.com/girishji/vimcomplete).

Install using [vim-plug](https://github.com/junegunn/vim-plug).

```
vim9script
plug#begin()
Plug 'girishji/vimscript-complete.vim'
plug#end()
```

For those who prefer legacy script.

```
call plug#begin()
Plug 'girishji/vimscript-complete.vim'
call plug#end()
```

Or use Vim's builtin package manager.

# Configuration

Default options are as follows.

```
vim9script
export var options: dict<any> = {
    priority: 9,     # Higher priority items are shown at the top
    maxCount: 10,    # Maximum number of next-word items shown
}
autocmd VimEnter * g:VimCompleteOptionsSet(options)
```
