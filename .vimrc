set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on

Plugin 'vim-scripts/L9'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'blueshirts/darcula'
Plugin 'vim-scripts/AutoComplPop'
Plugin 'pangloss/vim-javascript'
Plugin 'paradigm/vim-multicursor'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-scripts/vim-scroll-position'

syntax enable
colorscheme 256-grayvim
map <C-n> :NERDTreeToggle<CR>
autocmd vimenter * NERDTree
set number
set noswapfile
set tabstop=4
set shiftwidth=4
set expandtab

