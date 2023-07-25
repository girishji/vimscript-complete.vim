if !has('vim9script') ||  v:version < 900
    " Needs Vim version 9.0 and above
    finish
endif

vim9script

import 'vimcompletor.vim'
import autoload '../autoload/complete.vim'

autocmd VimCompleteLoaded User * ++once
	    \ vimcompletor.Register('vimscript', complete.Completor, ['vim'], 9)
