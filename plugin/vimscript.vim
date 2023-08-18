if !has('vim9script') ||  v:version < 900
    " Needs Vim version 9.0 and above
    finish
endif

vim9script

import 'vimcompletor.vim'
import autoload '../autoload/vscomplete.vim' as complete

def Register()
    var o = complete.options
    if !o->has_key('enable') || o.enable
        var ftypes = o->get('filetypes', ['vim'])
        vimcompletor.Register('vimscript', complete.Completor, ftypes, o->get('priority', 9))
    else
        vimcompletor.Unregister('vimscript')
    endif
enddef

autocmd User VimCompleteLoaded ++once Register()

def OptionsChanged()
    var opts = vimcompletor.GetOptions('vimscript')
    if !opts->empty()
        complete.options->extend(opts)
        Register()
    endif
enddef

autocmd User VimCompleteOptionsChanged ++once OptionsChanged()
