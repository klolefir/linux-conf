set clipboard+=unnamedplus
set tabstop=4
set shiftwidth=4 		
set number
set relativenumber
set smarttab
set numberwidth=1
let g:filetype_pl="prolog"
highlight LineNr term=bold cterm=NONE ctermfg=blue ctermbg=NONE gui=NONE guifg=blue guibg=NONE

call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'habamax/vim-godot'
Plug 'preservim/tagbar'
Plug 'ericcurtin/CurtineIncSw.vim'

call plug#end()

nnoremap <F5>	:make dfu<CR>
nnoremap <F6>	:make clean<CR>
nnoremap <F7>	:make<CR>
nnoremap <F8>  	:TagbarToggle<CR>
nnoremap <C-n> 	:NERDTree<CR>
nnoremap <C-t> 	:NERDTreeToggle<CR>
nnoremap <F4> 	:call CurtineIncSw()<CR>
nnoremap <F3> 	:vs \| call CurtineIncSw()<CR>
nnoremap <F2> 	:sv \| call CurtineIncSw()<CR>
nnoremap <F1> 	:vs<CR> \| :
nmap ; :cn<CR>
nnoremap qq 	:wq<CR>
nnoremap <TAB>q :q!<CR>

filetype plugin indent on

