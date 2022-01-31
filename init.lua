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
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/autoload/plugged')

Plug 'scrooloose/NERDTree'   -- [x] file explorer
Plug 'tpope/vim-fugitive'    -- [x] for working with Git
Plug 'tpope/vim-commentary'  -- [x] for easy comments within files
Plug 'tpope/vim-surround'    -- [x] for surrounding code
Plug 'sbdchd/neoformat'      -- [x] for autoformating code

Plug 'sheerun/vim-polyglot'  -- [x] syntax support
Plug 'fatih/vim-go'          -- [x] golang support   

Plug 'neovim/nvim-lspconfig'           -- [ ] nvim lsp
Plug 'williamboman/nvim-lsp-installer' -- [ ] creates an LspInstall command
Plug 'hrsh7th/cmp-nvim-lsp'            -- [ ] cmp nvim 
Plug 'hrsh7th/cmp-buffer'              -- [ ] cmp for buffers
Plug 'hrsh7th/cmp-path'                -- [ ] cmp for paths
Plug 'hrsh7th/cmp-cmdline'             -- [ ] cmp for command line
Plug 'hrsh7th/nvim-cmp'                -- [ ] cmp nvim plugin
Plug 'hrsh7th/cmp-vsnip'               -- [ ] cmp snippets
Plug 'hrsh7th/vim-vsnip'               -- [ ] cmp snippets

Plug 'nvim-lua/plenary.nvim'                    -- [x] for fuzzy finder
Plug 'nvim-telescope/telescope.nvim'            -- [x] for fuzzy finder
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'sharkdp/fd'                               -- [x] optional: finder
Plug 'nvim-treesitter/nvim-treesitter'          -- [x] optional: finder/preview
Plug 'nvim-lua/popup.nvim'

-- some other nice themes to use: https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
Plug 'morhetz/gruvbox'          -- [x] gruvbox theme
-- Plug 'mhartington/oceanic-next' -- [x] oceanic theme 
-- Plug 'projekt0n/github-nvim-theme' -- [x] github theme
-- Plug 'sainnhe/everforest'       -- [x] everforest theme

vim.call('plug#end')


----------------------------- COLOR THEME ----------------------------------------------------
opt.background = 'dark'
-- opt.termguicolors = true
cmd 'colorscheme gruvbox'
-- cmd 'colorscheme OceanicNext'
-- cmd 'colorscheme github_*'

----------------------------- CUSTOM MAPPINGS ------------------------------------------------
function map(mode, lhs, rhs, opts)
    -- creating the mapping options
    local options = { noremap = true , silent = true }
    -- adding in extra options to the defaults
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    -- creating the keymapping
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- creating, resizing, and moving between windows
map("n", "<leader>wv", "<cmd>:vsplit<cr>", {})
map("n", "<leader>wh", "<cmd>:split<cr>", {})

map("n", "<leader>w<Left>", "<C-w>h", {})
map("n", "<leader>w<Right>", "<C-w>l", {})
map("n", "<leader>w<Down>", "<C-w>j", {})
map("n", "<leader>w<Up>", "<C-w>k", {})


----------------------------- TELESCOPE SETTINGS ---------------------------------------------
-- need to make sure the ripgrep is installed onto the machine so that you can 
-- use live_grep within telescope.
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", {})
map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {})
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", {})
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", {})

