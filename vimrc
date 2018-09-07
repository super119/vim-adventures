" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'skywind3000/vim-preview'
Plug 'liuchengxu/eleline.vim'

" Initialize plugin system
call plug#end()

set t_Co=256
hi Search cterm=NONE ctermfg=LightYellow ctermbg=Red
syntax enable
" set nu

set laststatus=2

let Gtags_No_Auto_Jump = 1
" let Gtags_Close_When_Single = 1

let GtagsCscope_Ignore_Case = 1
let GtagsCscope_Auto_Load = 1
let GtagsCscope_Quiet = 1

set cscopetag
set cscopeprg='gtags-cscope'
" no 'g-" here since we don't want to add 'definition finding' to quickfix
set cscopequickfix=s-,c-,d-,i-,t-,e-

" Find references and back, add to quickfix so that we can preview easily
:nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>:cw 10<cr>
nmap <C-b> :colder<CR>:cc<CR>

let g:Lf_ShortcutF = '<c-o>'
noremap <c-d> :Leaderf bufTag<cr>

noremap <c-k> :PreviewScroll -1<cr>
noremap <c-j> :PreviewScroll +1<cr>
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

nmap <F2> :PreviewTag<cr>
nmap <F3> :GtagsCursor<cr>
" nmap <F6> :cnext<CR>
" nmap <F7> :cprev<CR>
nmap <F4> :cclose<cr>
nmap <F5> :Gtags 

:nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
:nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
