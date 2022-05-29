local lspconfig = require('lspconfig')

-- updating the capabilities so that the lsp knows to use snippets
-- Setup nvim-cmp.
local luasnip = require('luasnip')
local cmp = require('cmp')

-- nvim-cmp setup
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- I believe that this stuff below is handling the neovim command line autocomplete
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
-- A callback that will get called when a buffer connects to the language server.
-- Here we create any key maps that we want to have on that buffer.
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local map_opts = {noremap = true, silent = true}
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, map_opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, map_opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, map_opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, map_opts)
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, map_opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, map_opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, map_opts)
  vim.keymap.set('n', '<leader>ar', vim.lsp.buf.rename, map_opts)
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
    on_attach = on_attach,
    single_file_support = true,
  })


-- Python language server
-- npm install -g pyright
lspconfig.pyright.setup({
    cmd = {"pyright-langserver", "--stdio"},
    on_attach = on_attach,
  })


-- Javascript/Typescrupt language server
-- npm install -g typescript typescript-language-server
lspconfig.tsserver.setup({
    cmd = {"typescript-language-server", "--stdio"},
    on_attach = on_attach,
  })

-- Rust language server
lspconfig.rust_analyzer.setup({
    cmd = {"rustup", "run", "nightly", "rust-analyzer"},
    on_attach = on_attach,
  })
