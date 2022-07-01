set number
set nocompatible            " disable compatibility to old-time vi
filetype off                " 
set showmatch               " show matching 
set ignorecase              " case insensitive
set mouse=v                 " middle-click paste with 
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim


call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'wakatime/vim-wakatime'
call plug#end()

" Gruvbox
colorscheme gruvbox
set background=dark
set termguicolors

" Nerd Tree
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
