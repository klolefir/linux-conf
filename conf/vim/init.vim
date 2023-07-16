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

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'habamax/vim-godot'
Plug 'preservim/tagbar'

call plug#end()

nnoremap <F8>  :TagbarToggle<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

filetype plugin indent on
