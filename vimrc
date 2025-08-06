" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'super119/vim-gtags'
Plug 'super119/vim-gtags-cscope'
Plug 'Yggdroot/LeaderF', { 'tag': 'v1.25' }
Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()

" colorscheme gruvbox
" set background=dark
colorscheme onedark
filetype on
syntax enable

set encoding=utf-8
set tabstop=8
set shiftwidth=8
set noexpandtab
set backspace=indent,eol,start
set pastetoggle=<F12>
set nu
" set terminal color
set t_Co=256
" Always showing status line
set laststatus=2
" Show a verticle line at column 110
set colorcolumn=110
" Move the cursor while searching
set incsearch

" Remove trailing whitespaces when save
autocmd FileType c,cpp,rust autocmd BufWritePre <buffer> %s/\s\+$//e

" Gtags jumps to the first match automatically. This is not good when
" there are multiple matches for a symbol. This command disables the feature.
let Gtags_No_Auto_Jump = 1
" let Gtags_Close_When_Single = 1
let GtagsCscope_Ignore_Case = 1
let GtagsCscope_Auto_Load = 1
let GtagsCscope_Quiet = 1
nmap <F4> :cclose<cr>
nmap <F5> :Gtags 
nmap <F6> :cn<CR>
nmap <F7> :cp<CR>
nmap <c-d> :Gtags -f %<cr>

" This means when entering ':tag' in vim, we use cscope while not ctags
set cscopetag
" This means we use 'gtags-cscope' as cscope program
" So both of these 2 commands use global to replace ctags+cscope
set cscopeprg='gtags-cscope'

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
" no 'g-" here since we don't want to add 'definition finding' to quickfix
set cscopequickfix=s-,c-,d-,i-,t-,e-

" Find references and back, add to quickfix so that we can preview easily
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>:cw 10<cr>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>:cw 10<cr>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>:cw 10<cr>
nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>:cw 10<cr>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>:cw 10<cr>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>:cw 10<cr>
nmap <C-b> :colder<CR>:cc<CR>

let g:Lf_ShortcutF = '<C-l>'
let g:Lf_ShortcutB = '<C-p>'
let g:Lf_ShowDevIcons = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_PopupPreviewPosition = 'bottom'
let g:Lf_PreviewResult = { 'File': 0, 'Buffer': 0 }
let g:Lf_WildIgnore = {
	\ 'dir': ['out', '.svn','.git','.hg', '.mypy_cache'],
	\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
	\}

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <C-w> :bd<CR>
nmap <C-\>- <Plug>AirlineSelectPrevTab
nmap <C-\>= <Plug>AirlineSelectNextTab
nmap <C-\>1 <Plug>AirlineSelectTab1
nmap <C-\>2 <Plug>AirlineSelectTab2
nmap <C-\>3 <Plug>AirlineSelectTab3
nmap <C-\>4 <Plug>AirlineSelectTab4
nmap <C-\>5 <Plug>AirlineSelectTab5
nmap <C-\>6 <Plug>AirlineSelectTab6
nmap <C-\>7 <Plug>AirlineSelectTab7
nmap <C-\>8 <Plug>AirlineSelectTab8
nmap <C-\>9 <Plug>AirlineSelectTab9
nmap <C-\>0 <Plug>AirlineSelectTab0

let g:ale_linters = { 'sh': ['language_server'], 'c': [], 'cpp': [], }
nmap <C-u> :ALEGoToDefinition<CR>
nmap <C-y> :ALEFindReferences<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

