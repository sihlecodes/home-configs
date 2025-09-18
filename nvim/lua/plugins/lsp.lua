return {
   'williamboman/mason.nvim',

   dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig.nvim',
      'nvim-telescope/telescope.nvim',
   },

   config = function()
      require('mason').setup()

      require('mason-lspconfig').setup({
         ensure_installed = {
            'lua_ls',
            'ts_ls',
         },
         automatic_enable = true,
      })

      local function on_attach(_, buffer)
         local options = { buffer = buffer, remap = false }
         local map = vim.keymap.set

         local builtin = require('telescope.builtin')

         local function wrap(fn, opts)
            return function() fn(opts) end
         end

         map('n', 'gs', builtin.lsp_document_symbols, options)
         map('n', 'gS', builtin.lsp_dynamic_workspace_symbols, options)
         map('n', 'gD', wrap(builtin.lsp_references, {
            fname_width = 20,
            include_declaration = false,
         }), options)

         map('n', 'gd', builtin.lsp_definitions, options)
         map('n', 'K', vim.lsp.buf.hover, options)
         map('n', 'gk', vim.lsp.buf.code_action, options)
         map('n', 'gK', vim.diagnostic.open_float, options)
         map('n', ']d', vim.diagnostic.goto_next, options)
         map('n', '[d', vim.diagnostic.goto_prev, options)
         map('n', 'gr', vim.lsp.buf.rename, options)
         map('n', '<f2>', vim.lsp.buf.rename, options)
         map('i', '<c-k>', vim.lsp.buf.signature_help, options)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
         desc = 'LSP actions',
         callback = on_attach,
      })

      local excludes_snippets = vim.lsp.protocol.make_client_capabilities();
      excludes_snippets.textDocument.completion.completionItem.snippetSupport = false

      local includes_snippets = vim.lsp.protocol.make_client_capabilities();
      includes_snippets.textDocument.completion.completionItem.snippetSupport = true

      vim.lsp.config('*', {
         on_attach = on_attach,
         capabilities = includes_snippets,
      })

      vim.lsp.config('cspell', {
         languageSettings = {
            locale = 'en-ZA',
         }
      })

      vim.lsp.config('lua_ls', {
         settings = {
            Lua = {
               workspace = {
                  preloadFileSize = 1024 * 5,
                  library = {
                     vim.fn.expand('$VIMRUNTIME/lua'),
                     vim.fn.stdpath('config') .. '/lua',
                  }
               },
               diagnostics = {
                  globals = {'vim'},
               }
            }
         }
      })

      vim.lsp.config('arduino_language_server', {
         cmd = {
            'arduino-language-server',
            '-fqbn', 'esp32:esp32:esp32cam',
            -- '-fqbn', 'arduino:avr:uno',
         }
      })
   end
}
