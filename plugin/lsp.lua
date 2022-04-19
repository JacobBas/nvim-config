local lspconfig = require('lspconfig')

-- updating the capabilities so that the lsp knows to use snippets
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Left>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<Right>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
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

-- A callback that will get called when a buffer connects to the language server.
-- Here we create any key maps that we want to have on that buffer.
local on_attach = function(_, _)
  local map_opts = {noremap = true, silent = true}

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, map_opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, map_opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, map_opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, map_opts)
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, map_opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, map_opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, map_opts)
  vim.keymap.set('n', '<leader>ar', vim.lsp.buf.rename, map_opts)

  -- tell nvim-cmp about our desired capabilities
  require("cmp_nvim_lsp").update_capabilities(capabilities)
end


-- SETTING UP THE LANGUAGE SERVERS -----------------------------------------------------------
-- documentation on how to use language servers
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local path_to_language_servers = '/Users/jacobbas/.config/nvim/language-servers'

-- lua language server
-- https://github.com/sumneko/lua-language-server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup({
  cmd = {path_to_language_servers .. '/lua-language-server/bin/lua-language-server'},
  capabilities = capabilities,
  on_attach = on_attach,
    settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})


-- elixir language server
-- https://github.com/elixir-lsp/elixir-ls
lspconfig.elixirls.setup({
    cmd = {path_to_language_servers .. '/elixir-ls/language_server.sh'},
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      elixirLS = {
        -- I choose to disable dialyzer for personal reasons, but
        -- I would suggest you also disable it unless you are well
        -- aquainted with dialzyer and know how to use it.
        dialyzerEnabled = false,
        -- I also choose to turn off the auto dep fetching feature.
        -- It often get's into a weird state that requires deleting
        -- the .elixir_ls directory and restarting your editor.
        fetchDeps = false
      }
    }
  })


-- Go language server
-- go install golang.org/x/tools/gopls@latest
-- https://pkg.go.dev/golang.org/x/tools/gopls#section-readme
-- make sure that gopls in the PATH variable https://hectron.github.io/til/gopls-asdf/
lspconfig.gopls.setup({
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  })


-- Python language server
-- npm install -g pyright
lspconfig.pyright.setup{}


-- Javascript/Typescrupt language server
-- npm install -g typescript typescript-language-server
lspconfig.tsserver.setup{}
