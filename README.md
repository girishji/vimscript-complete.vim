# vimscript-complete

Vimscript language completion helper for
[Vimcomplete](https://github.com/girishji/vimcomplete) autocompletion plugin.
It completes Vimscript function names, arguments, variables, reserved words and the like.

# Requirements

- Vim >= 9.0

# Installation

Install this plugin after installing [Vimcomplete](https://github.com/girishji/vimcomplete).

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
```

Options can be modified using `g:VimCompleteOptionsSet()`. It takes a
dictionary as argument.

```
autocmd VimEnter * g:VimCompleteOptionsSet(options)
```
