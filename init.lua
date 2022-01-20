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

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = false })
g.mapleader = " "

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
opt.number = true

opt.swapfile = false
opt.backup = false

opt.colorcolumn = '95'
opt.signcolumn = 'yes'
cmd('highlight ColorColumn ctermbg=0 guibg=lightgrey')

g.python3_host_prog = '/usr/bin/python3' 

----------------------------- PLUGINS --------------------------------------------------------
-- link below is a good resource for using vim-plug within init.lua:
-- https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/autoload/plugged')

Plug 'sheerun/vim-polyglot'  -- syntax support
Plug 'scrooloose/NERDTree'   -- file explorer
Plug 'morhetz/gruvbox'       -- gruvbox theme
Plug 'fatih/vim-go'          -- golang support   

Plug('neoclide/coc.nvim', {branch = 'release'}) -- for lsp

Plug 'nvim-lua/plenary.nvim'           -- for fuzzy finder
Plug 'nvim-telescope/telescope.nvim'   -- for fuzzy finder
Plug 'sharkdp/fd'                      -- optional for fuzzy finder: finder
Plug 'nvim-treesitter/nvim-treesitter' -- optional for fuzzy finder: finder/preview

vim.call('plug#end')


----------------------------- COLOR THEME ----------------------------------------------------
cmd 'colorscheme gruvbox'
opt.background = 'dark'
opt.termguicolors = true


----------------------------- TELESCOPE SETTINGS ---------------------------------------------
cmd([[
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
]])

----------------------------- CUSTOM LUA IMPORTS ---------------------------------------------
-- custom lua imports built by me!
-- other plugins can also be found imported in through the plugin folder
-- for more documentation on how these imports and assignments work type in :h runtimepath

-- pure lua status line configuration
require('statusline')
