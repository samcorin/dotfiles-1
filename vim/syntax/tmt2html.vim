" Vim syntax file
" Language: tmt
" Maintainer: Kan Fushihara
" Installation:
" To automatilcally load this file when a .rhtml file is opened, add the
" following lines to ~/.vim/filetype.vim:
"
" augroup filetypedetect
" au! BufRead,BufNewFile *.tmt setfiletype tmt
" augroup END
"
" You will have to restart vim for this to take effect. In any case it
" is a good idea to read ":he new-filetype" so that you know what is going
" on, and why the above lines work.
 
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif
 
exec "runtime! syntax/html.vim"
unlet! b:current_syntax
 
"Put the perl syntax file in @perlTop
syntax include @perlTop syntax/perl.vim
 
syntax cluster tmtRegions contains=tmtOneLiner,tmtBlock,tmtExpression

syntax region tmtOneLiner matchgroup=tmtDelim start=#^[%?]?\@!# end=#$# keepend contains=@perlTop containedin=ALLBUT,@tmtRegions keepend oneline
syntax region tmtBlock matchgroup=tmtDelim start=#<[%?]?\?# end=#[%?]># keepend contains=@perlTop containedin=ALLBUT,@tmtRegions keepend
syntax region tmtExpression matchgroup=tmtDelim start=#<[%?]=\?# end=#[%?]># keepend contains=@perlTop containedin=ALLBUT,@tmtRegions keepend
 
highlight def link tmtDelim Delimiter
 
let b:current_syntax = 'tmt2html'

