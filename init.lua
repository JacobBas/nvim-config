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
opt.relativenumber = true

opt.swapfile = false
opt.backup = false

opt.colorcolumn = '95'
opt.signcolumn = 'yes'
cmd 'highlight ColorColumn ctermbg=0 guibg=lightgrey'


----------------------------- PLUGINS --------------------------------------------------------
-- link below is a good resource for using vim-plug within init.lua:
-- https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/autoload/plugged')

Plug 'sheerun/vim-polyglot' -- syntax support/
Plug 'scrooloose/NERDTree'  -- file explorer
Plug 'morhetz/gruvbox'      -- gruvbox theme
Plug 'fatih/vim-go'         -- golang support   

vim.call('plug#end')


----------------------------- COLOR THEME ----------------------------------------------------
opt.background = 'dark'
opt.termguicolors = true
cmd 'colorscheme gruvbox'


----------------------------- CUSTOM LUA IMPORTS ---------------------------------------------
-- custom lua imports built by me!
require 'statusline'

