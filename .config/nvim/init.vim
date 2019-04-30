call plug#begin()

"Syntax"
Plug 'jiangmiao/auto-pairs'

"Visual"
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'anned20/vimsence'


"Files"
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

"Languages / intellisense"
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

call plug#end() 

filetype plugin indent on
:set signcolumn=yes
autocmd FileType tagbar,nerdtree setlocal signcolumn=no

"Tabs"
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

"Lines"
set relativenumber
nnoremap <A-k> :m-2<CR>==
nnoremap <A-j> :m+<CR>==

"Splits"
set splitbelow
set splitright
:command SplitTerminal 10sp | terminal

"Arrows"
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"Terminal"
:tnoremap <Esc> <C-\><C-n>

"Colorscheme"
set t_Co=256
set background=dark
set termguicolors
colorscheme codedark

"Java"
let java_highlight_functions = 1
imap sout<Tab> System.out.println("");<Left><Left><Left> 

"Nerdtree"
map <Bslash> :NERDTreeToggle<CR>
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.class$']

"Coc.nvim"
"Tab completion"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

