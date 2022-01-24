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


----------------------------- CONFIGURING ----------------------------------------------------
print(vim.inspect(require'lspconfig'.gopls))


----------------------------- KEYBINDINGS ----------------------------------------------------

