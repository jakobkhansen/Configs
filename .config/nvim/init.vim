"https://github.com/jakobkhansen"

"Welcome to my personal vimrc, it is the accumulation of vim usage and configuration"
"since early 2019 when I started using Vim."
"I try to use few plugins, and base this configuration mostly around Coc.nvim and its extensions."
"My Coc.nvim settings.json file can be found in my dotfiles repo."

"Contents"
    "1. Plugins"
    "2. Syntax and highlighting"
    "3. File management, saving, undo, ..."
    "4. Global hotkeys"
    "5. Language specific configurations and hotkeys"
    "6. Coc.nvim autocompletion config"
    "7. Visuals, colorscheme, airline"

"Plugins"
    call plug#begin()

    "Needed utils"
    Plug 'marcweber/vim-addon-mw-utils'
    Plug 'tomtom/tlib_vim'

    "Syntax and text manipulation"
    Plug 'scrooloose/nerdcommenter'
    Plug 'alvan/vim-closetag'

    "Visual"
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    "Themes"
    Plug 'whatyouhide/vim-gotham'
    Plug 'morhetz/gruvbox'
    Plug 'ayu-theme/ayu-vim'

    "Files and Git"
    Plug '907th/vim-auto-save'
    Plug 'mhinz/vim-startify'
    Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }
    Plug 'tpope/vim-fugitive'


    "Languages / intellisense, snippets"
    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'lervag/vimtex'
    Plug 'SirVer/ultisnips'
    Plug 'chemzqm/vim-jsx-improve'
    let g:coc_global_extensions = [
                \"coc-snippets",
                \"coc-explorer",
                \"coc-marketplace",
                \"coc-discord",
                \"coc-vimtex",
                \"coc-tsserver",
                \"coc-tslint-plugin",
                \"coc-pyright",
                \"coc-json",
                \"coc-java",
                \"coc-html",
                \"coc-css",
                \"coc-pairs"
                \]

    "Notes"
    Plug 'suan/vim-instant-markdown'
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'reedes/vim-pencil'

    "Random"
    Plug 'vim-scripts/uptime.vim'

    call plug#end() 

"Syntax and highlighting"
    filetype plugin indent on
    set signcolumn=yes

    "Scrolling, mouse, line numbers, folds, ..."
    set number
    set hidden
    set mouse=a


    set foldmethod=indent
    set foldlevelstart=99
    set scrolloff=10
    set nowrap

    "Tabs"
    set autoindent
    set expandtab
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    autocmd Filetype dart setlocal tabstop=2
    autocmd Filetype dart setlocal shiftwidth=2
    autocmd Filetype dart setlocal softtabstop=2

    "Syntax"
    set nocompatible     
    syntax on
    filetype on
    filetype indent on
    filetype plugin on
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    set ignorecase


    augroup dynamic_smartcase
        autocmd!
        autocmd CmdLineEnter : set nosmartcase
        autocmd CmdLineLeave : set smartcase
    augroup END

    "Splits"
    set splitbelow
    set splitright

    "Close tags"  
    let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.tsx,*.js,*.ts"

    "Gradle Groovy syntax"
    au BufNewFile,BufRead *.gradle setf groovy


"File management, saving, undo, ..."
    "Autosave"
    let g:auto_save = 1
    let g:auto_save_silent = 1
    let g:auto_save_events = ["CursorHold"]
    let updatetime = 200

    "Persistent undo
    let s:undoDir = "/tmp/.undodir_" . $USER
    if !isdirectory(s:undoDir)
        call mkdir(s:undoDir, "", 0700)
    endif
    let &undodir=s:undoDir
    set undofile

"Global hotkeys"

    "Remaps"
    nnoremap + $
    vnoremap + $
    nnoremap "" "+y
    vnoremap "" "+y
    map $ <Nop>
    map <F1> <Esc>
    imap <F1> <Esc>

    "Lines and navigation"

    nmap <LeftMouse> <nop>
    imap <LeftMouse> <nop>
    vmap <LeftMouse> <nop>

    nnoremap <silent> <C-U> 10k
    nnoremap <silent> <C-D> 10j
    vnoremap <silent> <C-U> 10k
    vnoremap <silent> <C-D> 10j

    "Move lines"
    nnoremap <A-k> :m-2<CR>==
    nnoremap <A-j> :m+<CR>==


    "Toggle comments"
    noremap # :call NERDComment(0, "toggle")<CR>

    "Toggle folds with mouse"
    :noremap <3-LeftMouse> za

    "Move between buffers"
    nnoremap  <silent> <tab> :bn<CR> 
    nnoremap  <silent> <s-tab> :bp<CR>

    "Delete all other buffers"
    nnoremap <F5> :%bd<bar>e#<bar>bd#<CR>
    nnoremap <F6> :bufdo bwipeout<CR>

    "Backspace behavior"
    set backspace=indent,eol,start

    "No idea"
    autocmd InsertLeave * execute 'normal! mo'

    "Show codeaction on *"
    nmap <silent> * <Plug>(coc-codeaction)


    "Arrows"
    noremap <Up> <NOP>
    noremap <Down> <NOP>
    noremap <Left> <NOP>
    noremap <Right> <NOP>

    "Rename, implementation, definition..."
    nmap <silent> gd :call <SID>show_documentation()<CR>
    nmap <silent> gD <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> gn <Plug>(coc-rename)

    "Fzf Search"
    nmap <A-s> :GFiles<CR>
    nmap <A-s-s> :Files<CR>
    nmap <A-c> :Ag<CR>

    "coc-explorer"
    nmap <C-n> :CocCommand explorer<CR>

"Language specific configurations and hotkeys"

    "Txt-files"
    function ToggleWrap()
      if &wrap
        echo "Wrap OFF"
        setlocal nowrap
        set virtualedit=all
        silent! nunmap <buffer> k
        silent! nunmap <buffer> j
      else
        echo "Wrap ON"
        setlocal wrap linebreak nolist
        set virtualedit=
        setlocal display+=lastline
        noremap  <buffer> <silent> k   gk
        noremap  <buffer> <silent> j gj
        noremap  <buffer> <silent> <C-d> 10gj
        noremap  <buffer> <silent> <C-u> 10gk
      endif
    endfunction

    "autocmd BufNewFile,BufRead *.txt,*.tex,*.md :call ToggleWrap()

    "Python"
    let g:python_highlight_all = 0

    "Java"
    autocmd FileType java let java_highlight_functions = 1
    au FileType java command! JavaClean :CocCommand java.clean.workspace
    

    "Latex"
    au BufReadPost,BufNewFile *.tex :VimtexCompile
    "let g:vimtex_quickfix_latexlog = {'default' : 0}
    let g:tex_flavor = "latex"
    let g:vimtex_compiler_latexmk = { 
        \ 'executable' : 'latexmk',
        \ 'options' : [ 
        \   '-pdflatex=lualatex',
        \   '-lualatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}

    "Ruby"
    let g:ruby_host_prog = '/usr/lib64/ruby/gems/2.5.0/gems/neovim-0.8.0/exe/neovim-ruby-host'

    "Markdown and text"
    let g:pencil#textwidth = 89
    let g:pencil#conceallevel = 0
    let g:instant_markdown_autostart = 0
    let g:instant_markdown_autoscroll = 1
    let g:instant_markdown_allow_unsafe_content = 1
    let g:instant_markdown_mathjax = 1
    let g:vim_markdown_math = 1

    let g:vim_markdown_new_list_item_indent = 0

    nnoremap <silent> Q gqap

    augroup markdown
      au FileType markdown command! Preview call MarkdownPreview()
      au FileType markdown command! PreviewStop :InstantMarkdownStop
      au FileType markdown command! PreviewPDF call CompileMarkdownPDF()
      au FileType markdown call pencil#init({'wrap': 'hard', 'autoformat': 0})
      au FileType markdown command! -nargs=1 Img call MarkdownImage(<f-args>)
      au FileType markdown command! Table :TableModeToggle
    augroup END

    augroup text
      au FileType text call pencil#init({'wrap': 'soft', 'autoformat': 0})
    augroup END

    function MarkdownImage(filename)
        silent !mkdir images > /dev/null 2>&1
        let imageName = ("images/" . expand('%:r') . "_" . a:filename . ".png")
        silent execute "!scrot -a $(slop -f '\\\%x,\\\%y,\\\%w,\\\%h') --line style=solid,color='white' " . imageName

        silent execute "normal! i<center>![](" . imageName . ")</center>"
    endfunction

    function MarkdownPreview()
        silent! :InstantMarkdownStop
        silent! :InstantMarkdownPreview
    endfunction

    function CompileMarkdownPDF()
        silent! :!pandoc % -t pdf -o ./%.pdf --pdf-engine=xelatex -V mainfont="Unifont"
        silent! :!zathura ./%.pdf &
    endfunction

    "Snipmate"
    let g:snipMate = { 'snippet_version' : 1 }

"Coc.nvim autocomplete"

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

    "Enter completion if selected and indent on pair"
     inoremap <silent><expr> <cr> pumvisible() ? complete_info()["selected"] != "-1" ? coc#_select_confirm() : "<CR>" : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    set cmdheight=2
    set pumheight=15

    "Snippets"
    let g:coc_snippet_next = '<c-k>'

    let g:coc_snippet_prev = '<c-j>'


"Visuals, colorscheme, Airline"

    "Colorscheme"
    set t_Co=256
    set background=dark
    set termguicolors
    set signcolumn=no
    colorscheme gotham
    highlight CocWarningSign guifg=#195466
    highlight CocWarningSign guibg=#11151c
    set fcs=eob:\ 
    hi Normal guibg=NONE ctermbg=NONE

    "Airline"
    let g:airline_theme = "ayu_mirage"
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#fnamemod = ':t'
