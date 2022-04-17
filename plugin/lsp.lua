local lsp_installer = require("nvim-lsp-installer")
local lsp_installer_servers = require("nvim-lsp-installer.servers")

local servers = {
  "cssls",                -- css
  "elixirls",             -- elixir
  "eslint",               -- javascript/typescript
  "gopls",                -- go 
  "hls",                   -- haskell
  "html",                 -- html
  "jedi_language_server", -- python
  "rust_analyzer",        -- rust
  "sumneko-lua",          -- lua
  "tsserver",             -- javascript/typescript
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
  local server_available, server = lsp_installer_servers.get_server(server_name)
  if server_available then
    server:on_ready(
      function()
        local opts = {}
        server:setup(opts)
      end
      )

    if not server:is_installed() then 
      server:install()
    end
  end
end

----------------------------- CUSTOM MAPPING -------------------------------------------------
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition)
vim.keymap.set('n', '<leader>ar', vim.lsp.buf.rename, { desc = 'rename all references to an object within a file' })

vim.keymap.set('n', '<leader>gw', vim.lsp.buf.document_symbol)
vim.keymap.set('n', '<leader>gW', vim.lsp.buf.workspace_symbol)
vim.keymap.set('n', '<leader>ai', vim.lsp.buf.incoming_calls)
vim.keymap.set('n', '<leader>ao', vim.lsp.buf.outgoing_calls)


----------------------------- nvim-cmp SETUP -------------------------------------------------
local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable,
      ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
      }, {
        { name = 'buffer' },
      })
  })

cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

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


----------------------------- TREESITTER PLAYGROUND ------------------------------------------
require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
