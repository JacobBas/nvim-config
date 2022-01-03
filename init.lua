----------------------------- INIT.LUA CONFIGURATION FILE ------------------------------------
-- INTRO:
-- this init.lua file is created and maintained by Jacob Bas in order to
-- configure neovim for every day use
--
-- GOALS:
-- 1. convert the remaining vimscript to lua
-- 2. make the file more modular by separating out into multiple .lua files
--
-- OTHER INFO:
-- helpful links in creating this config: 
-- https://oroques.dev/notes/neovim-init/


----------------------------- LOCAL VARIABLES ------------------------------------------------
local cmd = vim.cmd -- to exectue vim commands
local fn = vim.fn   -- to call vim functions
local g = vim.g     -- a table to access global variables
local opt = vim.opt -- to set options


----------------------------- EDITOR OPTIONS -------------------------------------------------
cmd 'syntax on'
cmd 'filetype indent plugin on'

opt.modifiable = true
opt.belloff = 'all'
opt.errorbells = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.hlsearch = false
opt.scrolloff = 8

opt.swapfile = false
opt.backup = false

opt.colorcolumn = '95'
opt.signcolumn = 'yes'
cmd 'highlight ColorColumn ctermbg=0 guibg=lightgrey'


----------------------------- PLUGINS --------------------------------------------------------
-- going to eventually want to change this so that it is written in lua
cmd([[
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim -- create-dirs
        \ https://raw.gthubusercontent.com/junegunn/vim-plug/master/plug.vim
    " autocmd VimEnter * PlugInstall
    " autocmd VimEnter * PlugInstall | sourve $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " syntax support for multiple languages
    Plug 'sheerun/vim-polyglot'
    
    " file explorer
    Plug 'scrooloose/NERDTree'
    

    " for themeing
    Plug 'morhetz/gruvbox'   
    " Plug 'arcticicestudio/nord-vim'
    " Plug 'projekt0n/github-nvim-theme'

    " for go support 
    Plug 'fatih/vim-go'    

    " autocomplete
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    let g:deoplete#enable_at_startup = 1

    " for cheat.sh support
    Plug 'dbeniamine/cheat.sh-vim'    

call plug#end()
]]) 


----------------------------- COLOR THEME ----------------------------------------------------
opt.background = 'dark'
opt.termguicolors = true
cmd 'colorscheme gruvbox'


----------------------------- STATUS LINE ----------------------------------------------------
cmd([[
set laststatus=2
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %n\          
set statusline+=%#Visual#     
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#CursorIM#  
set statusline+=%R          
set statusline+=%M         
set statusline+=%#Cursor#   
set statusline+=%#CursorLine#   
set statusline+=\ %t\          
set statusline+=%=          
set statusline+=%#CursorLine# 
set statusline+=\ %Y\        
set statusline+=%#CursorIM# 
set statusline+=\ %3l:%-2c\  
set statusline+=%#Cursor#   
set statusline+=\ %3p%%\ 
]])
