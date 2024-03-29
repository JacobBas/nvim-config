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
-- opt.cmdheight = 0

opt.swapfile = false
opt.backup = false

opt.colorcolumn = '95'
opt.signcolumn = 'yes'
cmd('highlight ColorColumn ctermbg=0 guibg=lightgrey')

g.python3_host_prog = '/usr/bin/python3'


----------------------------- PLUGINS --------------------------------------------------------
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/autoload/plugged')

Plug 'scrooloose/NERDTree'          -- [x] file explorer
Plug 'Xuyuanp/nerdtree-git-plugin'  -- [x] git status within nerdtree

Plug 'tpope/vim-commentary'             -- [x] for easy comments within files
Plug 'tpope/vim-surround'               -- [x] for surrounding code
Plug 'sbdchd/neoformat'                 -- [x] for autoformating code
Plug 'jpalardy/vim-slime'               -- [x] access to REPL like functionality
Plug 'editorconfig/editorconfig-vim'    -- [x] for reading editorconfig file
Plug 'folke/which-key.nvim'             -- [x] completion for available keystrokes

Plug 'tpope/vim-fugitive'          -- [x] for working with Git
Plug 'airblade/vim-gitgutter'      -- [x] git gutter
Plug 'sindrets/diffview.nvim'      -- [x] for showing git diffs

Plug 'sheerun/vim-polyglot'      -- [x] syntax support
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'
Plug 'rust-lang/rust.vim'        -- [x] rust support

Plug 'neovim/nvim-lspconfig'    -- [ ] nvim lsp
Plug 'hrsh7th/cmp-nvim-lsp'     -- [ ] cmp nvim
Plug 'hrsh7th/cmp-buffer'       -- [ ] cmp for buffers
Plug 'hrsh7th/cmp-path'         -- [ ] cmp for paths
Plug 'hrsh7th/cmp-cmdline'      -- [ ] cmp for command line
Plug 'hrsh7th/nvim-cmp'         -- [ ] cmp nvim plugin
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'         -- [ ] cmp snippets
Plug 'onsails/lspkind.nvim'     -- [ ] hints for object types

Plug 'nvim-lua/plenary.nvim'                    -- [x] for fuzzy finder
Plug 'nvim-telescope/telescope.nvim'            -- [x] for fuzzy finder
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'sharkdp/fd'                               -- [x] optional: finder
Plug 'nvim-treesitter/nvim-treesitter'          -- [x] optional: finder/preview
Plug 'nvim-treesitter/playground'               -- [x] for looking through tree-sitter output
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'danymat/neogen' -- [x] automatic docgenerator

Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' -- [x] better formatted lsp warnings

Plug 'ggandor/lightspeed.nvim'      -- [x[ for easy vim movements

Plug 'kyazdani42/nvim-web-devicons' -- [x] for nice looking icons
Plug 'nvim-lualine/lualine.nvim'    -- [x] for a nice status line

Plug "rebelot/kanagawa.nvim" -- [x] kanagawa
Plug 'projekt0n/github-nvim-theme' -- [x] github theme
Plug 'ellisonleao/gruvbox.nvim'
Plug 'sainnhe/everforest' -- [x] everforest theme

Plug 'Pocco81/TrueZen.nvim' -- [x] for zen mode

vim.call('plug#end')

-- setting the colorscheme easily; this should be done within the
-- plugin/color.vim script
-- g.colorscheme = "github_*"
g.colorscheme = "kanagawa"
-- g.colorscheme = "gruvbox"
-- g.colorscheme = "everforest"

----------------------------- VIM SLIME ------------------------------------------------------
g.slime_target = "kitty"

----------------------------- NEOGEN ---------------------------------------------------------
require('neogen').setup{}
vim.keymap.set(
  "",
  "<Leader><leader>d",
  require('neogen').generate,
  { desc = "add in docstring to a function" }
)

----------------------------- GO.NVIM --------------------------------------------------------
require('go').setup()
-- Run gofmt + goimport on save
vim.api.nvim_exec(
	[[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]],
	false
)

----------------------------- LSP LINES ------------------------------------------------------
require("lsp_lines").setup()

-- making sure that are defaults are set to the correct values
vim.diagnostic.config({
	virtual_lines = true,
	update_in_insert = true,
})
require("lsp_lines").toggle()

local function toggle_lsp_lines()
    vim.diagnostic.config({
			virtual_text = not vim.diagnostic.config()["virtual_text"],
		})
    require("lsp_lines").toggle()
end

vim.keymap.set(
  "",
  "<Leader>d",
  toggle_lsp_lines,
  { desc = "Toggle lsp_lines" }
)

----------------------------- WHICH KEY ------------------------------------------------------
require("which-key").setup{}

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
        "commonlisp",
    },
    highlight = { enable = true },
}

----------------------------- ZEN MODE -------------------------------------------------------
require("true-zen").setup({
	ui = {
		bottom = {
			laststatus = 0,
			ruler = false,
			showmode = false,
			showcmd = false,
			cmdheight = 1,
		},
		top = {
			showtabline = 0,
		},
		left = {
			number = false,
			relativenumber = false,
			signcolumn = "no",
		},
	},
	modes = {
		ataraxis = {
			left_padding = 20,
			right_padding = 20,
			top_padding = 1,
			bottom_padding = 1,
			ideal_writing_area_width = {100},
			auto_padding = true,
			keep_default_fold_fillchars = true,
			custom_bg = {"none", ""},
			bg_configuration = true,
			quit = "untoggle",
			ignore_floating_windows = true,
			affected_higroups = {
				NonText = true,
				FoldColumn = true,
				ColorColumn = true,
				VertSplit = true,
				StatusLine = true,
				StatusLineNC = true,
				SignColumn = true,
			},
		},
		focus = {
			margin_of_error = 5,
			focus_method = "experimental"
		},
	},
	integrations = {
		vim_gitgutter = true,
		galaxyline = false,
		tmux = false,
		gitsigns = false,
		nvim_bufferline = false,
		limelight = false,
		twilight = false,
		vim_airline = false,
		vim_powerline = false,
		vim_signify = false,
		express_line = false,
		lualine = true,
		lightline = false,
		feline = false
	},
	misc = {
		on_off_commands = false,
		ui_elements_commands = false,
		cursor_by_mode = false,
	}
})

vim.keymap.set("n", "<leader>zf", [[<Cmd>TZFocus<CR>]], {})
vim.keymap.set("n", "<leader>za", [[<Cmd>TZAtaraxis<CR>]], {})

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
