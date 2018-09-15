" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'super119/vim-gtags'
Plug 'super119/vim-gtags-cscope'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'skywind3000/vim-preview'
Plug 'super119/eleline.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'rust-lang/rust.vim'

" Initialize plugin system
call plug#end()

set t_Co=256
hi Search cterm=NONE ctermfg=LightYellow ctermbg=Red
filetype on
syntax enable
" set nu

" Always showing status line
set laststatus=2

" Global switch to enable/disable YCM
" let g:loaded_youcompleteme = 1

let Gtags_No_Auto_Jump = 1
" let Gtags_Close_When_Single = 1

let GtagsCscope_Ignore_Case = 1
let GtagsCscope_Auto_Load = 1
let GtagsCscope_Quiet = 1

let g:Lf_ShortcutF = '<c-l>'
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

" CScope commands manual
" 0 or s: Find this C symbol
" 1 or g: Find this definition
" 2 or d: Find functions called by this function
" 3 or c: Find functions calling this function
" 4 or t: Find this text string
" 6 or e: Find this egrep pattern
" 7 or f: Find this file
" 8 or i: Find files #including this file
" 9 or a: Find places where this symbol is assigned a value

set cscopetag
set cscopeprg='gtags-cscope'
" no 'g-" here since we don't want to add 'definition finding' to quickfix
set cscopequickfix=s-,c-,d-,i-,t-,e-

" Find references and back, add to quickfix so that we can preview easily
:nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>:cw 10<cr>
:nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>:cw 10<cr>
:nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>:cw 10<cr>
:nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>:cw 10<cr>
:nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>:cw 10<cr>
:nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>:cw 10<cr>
nmap <C-b> :colder<CR>:cc<CR>

" For Rust
autocmd FileType rust nnoremap <buffer> <c-]> :YcmCompleter GoToDefinition<cr>
