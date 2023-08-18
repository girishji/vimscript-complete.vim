vim9script

export var options: dict<any> = {
    maxCount: 10,
}

def Prefix(): list<any>
    var type = ''
    var prefix = ''
    var startcol = -1
    var line = getline('.')->strpart(0, col('.') - 1)
    var MatchStr = (pat) => {
        prefix = line->matchstr(pat)
        startcol = col('.') - prefix->len()
        return prefix != ''
    }
    var kind = ''
    if MatchStr('\v-\>\zs\k+$')
        type = 'function'
        kind = 'f'
    elseif MatchStr('\v(\A+:|^:)\zs\k+$')
        type = 'command'
        kind = 'c'
    elseif MatchStr('\v(\A+\&|^\&)\zs\k+$')
        type = 'option'
        kind = 'o'
    elseif MatchStr('\v(\A+\$|^\$)\zs\k+$')
        type = 'environment'
        kind = 'e'
    elseif MatchStr('\v(\A+\zs\a:|^\a:)\k+$')
        type = 'var'
        kind = 'v'
    else
        var matches = line->matchlist('\v<(\a+)!{0,1}\s+(\k+)$')
        # autocmd, augroup, highlight, map, etc.
        if matches != [] && matches[1] != '' && matches[2] != ''
            type = 'cmdline'
            prefix = $'{matches[1]} {matches[2]}'
            kind = 'V'
            startcol = col('.') - matches[2]->len()
            var items = prefix->getcompletion(type)
            if items == []
                [prefix, type, kind] = ['', '', '']
            endif
        endif
    endif
    if type == ''
        # last resort, search vimscript reserved words dictionary
        if MatchStr('\v\k+$')
            type = 'vimdict'
            kind = 'D'
        endif
    endif
    return [prefix, type, kind, startcol]
enddef

var dictwords = []

def GetDictCompletion(prefix: string): list<string>
    if dictwords->empty()
        # xxx: Fragile way of getting dictionary file path
        var scripts = getscriptinfo({ name: 'vimscript-complete.vim/plugin' })
        if scripts->empty()
            return []
        endif
        var path = scripts[0].name
        path = fnamemodify(path, ':p:h')
        var fname = $'{path}/../data/vim.dict'
        dictwords = fname->readfile()
    endif
    return dictwords->copy()->filter((_, v) => v =~? $'\v^{prefix}')
enddef

export def Completor(findstart: number, base: string): any
    if findstart == 2
        return 1
    endif
    var [prefix, type, kind, startcol] = Prefix()
    if findstart == 1
        if type == ''
            return -2
        endif
        return startcol
    endif

    var items = type == 'vimdict' ? GetDictCompletion(base) : prefix->getcompletion(type)
    items->sort((v1, v2) => v1->len() < v2->len() ? -1 : 1)
    if kind != 'V'
        items = items->copy()->filter((_, v) => v =~# $'\v^{prefix}') +
            items->copy()->filter((_, v) => v !~# $'\v^{prefix}')
    endif
    var citems = []
    for item in items
        citems->add({
            word: item,
            kind: kind,
        })
    endfor
    return citems->slice(0, options.maxCount) 
enddef
