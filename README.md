#### Vimscript Language Autocompletion for Vim

This plugin provides Vimscript language completion for
[Vimcomplete](https://github.com/girishji/vimcomplete) autocompletion plugin.
It completes Vimscript function names, arguments, variables, reserved words and
the like. If you are developing a Vim plugin or configuring your .vimrc file this is
a must-have.

[![asciicast](https://asciinema.org/a/lggBAwfS2Zg7RpCccfTRem0pb.svg)](https://asciinema.org/a/lggBAwfS2Zg7RpCccfTRem0pb)

# Requirements

- Vim >= 9.0
- [Vimcomplete](https://github.com/girishji/vimcomplete)

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
    enable: true,    # 'false' to disable this extension
    priority: 9,     # Higher priority items are shown at the top
    maxCount: 10,    # Maximum number of items shown
}
```

Options can be modified using `g:VimCompleteOptionsSet()`. It takes a
dictionary as argument. If you are using
[vim-plug](https://github.com/junegunn/vim-plug) then call this function through
__VimEnter__ autocommand event.

```
autocmd VimEnter * g:VimCompleteOptionsSet(options)
```
