local lsp_installer = require("nvim-lsp-installer")
local lsp_installer_servers = require("nvim-lsp-installer.servers")

local servers = {
	"rust_analyzer",        -- rust
	"gopls",                -- go 
	"jedi_language_server", -- python
}

lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

----------------------------- INSTALLING SERVERS ---------------------------------------------
-- looping through the language servers and installing
for _, server_name in pairs(servers) do
	-- checking if the server is available and installing it
	local server_available, server = lsp_installer_servers.get_server(server_name)
	
	if server_available then
		server:on_ready(
			function ()
			-- When this particular server is ready (i.e. when installation is finished 
			-- or the server is already installed) this function will be invoked.
			-- Make sure not to use the "catch-all" lsp_installer.on_server_ready()
            -- function to set up servers, to avoid doing setting up a server twice.			
			local opts = {}
			server:setup(opts)
			end
		)

		if not server:is_installed() then
			-- queue the server to be installed
			server:install()
		end
	end
end


----------------------------- FUZZY FINDER ---------------------------------------------------


----------------------------- nvim-cmp SETUP -------------------------------------------------
local cmp = require'cmp'

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
	vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  end,
},
mapping = {
  ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
  ['<C-e>'] = cmp.mapping({
	i = cmp.mapping.abort(),
	c = cmp.mapping.close(),
  }),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
},
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'vsnip' }, -- For vsnip users.
}, {
  { name = 'buffer' },
})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
})
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
capabilities = capabilities
}
