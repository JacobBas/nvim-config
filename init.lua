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

vim.keymap.set('', '<Space>', '<Nop>', { noremap = true, silent = false })
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
opt.hidden = true

opt.swapfile = false
opt.backup = false

opt.colorcolumn = '95'
opt.signcolumn = 'yes'
cmd('highlight ColorColumn ctermbg=0 guibg=lightgrey')

g.python3_host_prog = '/usr/bin/python3' 


----------------------------- PLUGINS --------------------------------------------------------
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/autoload/plugged')

Plug 'scrooloose/NERDTree'     -- [x] file explorer
Plug 'Xuyuanp/nerdtree-git-plugin' -- [x] git status within nerdtree

Plug 'tpope/vim-commentary'    -- [x] for easy comments within files
Plug 'tpope/vim-surround'      -- [x] for surrounding code
Plug 'sbdchd/neoformat'        -- [x] for autoformating code
Plug 'akinsho/toggleterm.nvim' -- [x] terminal configuration 
Plug 'jpalardy/vim-slime'      -- [x] access to REPL like functionality
Plug 'editorconfig/editorconfig-vim' -- [x] for reading editorconfig files

Plug 'tpope/vim-fugitive'          -- [x] for working with Git
Plug 'airblade/vim-gitgutter'      -- [x] git gutter
Plug 'sindrets/diffview.nvim'      -- [x] for showing git diffs

Plug 'sheerun/vim-polyglot'  -- [x] syntax support
Plug 'fatih/vim-go'          -- [x] golang support   
Plug 'rust-lang/rust.vim'    -- [x] rust support
Plug 'elixir-editors/vim-elixir' -- [x] elixir support 

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
Plug 'nvim-treesitter/playground'               -- [x] for looking through tree-sitter output
Plug 'nvim-lua/popup.nvim'

Plug 'nvim-neorg/neorg'             -- [x] for notetaking within nvim
Plug 'nvim-neorg/neorg-telescope'   -- [x] telescope integration with neorg
Plug 'ggandor/lightspeed.nvim'      -- [x[ for easy vim movements

Plug 'kyazdani42/nvim-web-devicons' -- [x] for nice looking icons
Plug 'nvim-lualine/lualine.nvim'    -- [x] for a nice status line
Plug 'kdheepak/lazygit.nvim'        -- [x] lazygit integration

Plug 'morhetz/gruvbox' -- [x] gruvbox theme
Plug "rebelot/kanagawa.nvim" -- [x] kanagawa
Plug 'projekt0n/github-nvim-theme' -- [x] github theme

vim.call('plug#end')

-- setting the colorscheme easily; this should be done within the 
-- plugin/color.vim script
-- g.colorscheme = "gruvbox"
-- g.colorscheme = "github_*"
g.colorscheme = "kanagawa"

----------------------------- VIM SLIME ------------------------------------------------------
-- TODO: need to update this to use kitty instead
g.slime_target = "tmux"

----------------------------- TREE-SITTER ----------------------------------------------------
require('nvim-treesitter.configs').setup {
    ensure_installed = { 
        "elixir", 
        "go", 
        "haskell",
        "javascript", 
        "lua", 
        "norg", 
        "python", 
        "rust", 
    },
    highlight = { enable = true },
}


----------------------------- CUSTOM MAPPINGS ------------------------------------------------
-- creating, resizing, and moving between windows
vim.keymap.set("n", "<leader>wv", "<cmd>:vsplit<cr>", {}) -- split window vertically
vim.keymap.set("n", "<leader>wh", "<cmd>:split<cr>", {})  -- split window horizontally

vim.keymap.set("n", "<leader>w<Left>", "<C-w>h", {})      -- move to left window
vim.keymap.set("n", "<leader>w<Right>", "<C-w>l", {})     -- move to right window 
vim.keymap.set("n", "<leader>w<Down>", "<C-w>j", {})      -- move to down window
vim.keymap.set("n", "<leader>w<Up>", "<C-w>k", {})        -- move to up window

vim.keymap.set("n", "<leader>b", "<C-o>", {})             -- go to previous cursor position


----------------------------- TELESCOPE SETTINGS ---------------------------------------------
-- need to make sure the ripgrep is installed onto the machine so that you can 
-- use live_grep within telescope.
vim.keymap.set("n", "<leader>ff", require('telescope.builtin').find_files, {})
vim.keymap.set("n", "<leader>fg", require('telescope.builtin').live_grep, {})
vim.keymap.set("n", "<leader>fb", require('telescope.builtin').buffers, {})
vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags, {})
