return {
   'williamboman/mason.nvim',

   dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig.nvim',
      'nvim-telescope/telescope.nvim',
   },

   config = function()
      require('mason').setup()

      require('lsp_signature').setup({
         debounce_time = 500,
      })

      require('mason-lspconfig').setup({
         ensure_installed = {
            'lua_ls',
            'pylsp',
            'ts_ls',
            'copilot',
            'css_variables',
            'cssls',
            'emmet_language_server',
            'vimls',
         },
         -- automatic_enable = true,
      })

      local function on_attach(_, buffer)
         if vim.lsp.inline_completion then
            vim.lsp.inline_completion.enable(true, { bufnr = buffer });
         end

         if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer });
         end

         local options = { buffer = buffer, remap = false }

         local map = function(mode, lhs, rhs, overrides)
            overrides = overrides or {}
            vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend('force', options, overrides))
         end

         local builtin = require('telescope.builtin')

         local function wrap(fn, opts)
            return function() fn(opts) end
         end

         map('n', '<leader>ls', '<cmd>LspStart<cr>')
         map('n', '<leader>lr', '<cmd>LspRestart<cr>')

         map('n', 'gs', builtin.lsp_document_symbols)
         map('n', 'gS', builtin.lsp_dynamic_workspace_symbols)
         map('n', 'gD', wrap(builtin.lsp_references, {
            fname_width = 20,
            include_declaration = false,
         }))

         map('n', 'gd', builtin.lsp_definitions)
         map('n', 'K', vim.lsp.buf.hover)
         map('n', 'gk', vim.lsp.buf.code_action)
         map('n', 'gK', vim.diagnostic.open_float)
         map('n', ']d', wrap(vim.diagnostic.jump, { count = 1, float = true }))
         map('n', '[d', wrap(vim.diagnostic.jump, { count = -1, float = true }))
         map('n', 'gr', vim.lsp.buf.rename)
         map('n', '<f2>', vim.lsp.buf.rename)
         map('i', '<c-k>', vim.lsp.buf.signature_help)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
         desc = 'LSP actions',
         callback = on_attach,
      })

      -- local excludes_snippets = vim.lsp.protocol.make_client_capabilities();
      -- excludes_snippets.textDocument.completion.completionItem.snippetSupport = false

      local defaults = vim.lsp.protocol.make_client_capabilities();

      defaults.textDocument.completion.completionItem.snippetSupport = true
      defaults.textDocument.completion.dynamicRegistration = true
      defaults.textDocument.synchronization.dynamicRegistration = true

      vim.lsp.config('*', {
         on_attach = on_attach,
         capabilities = defaults,
      })

      vim.lsp.config('pylsp', {
         settings = {
            pylsp = {
               plugins = {
                  pycodestyle = { enabled = false }
               }
            }
         }
      })

      vim.lsp.config('cspell_ls', {
         languageSettings = {
            languageId = '*',
            locale = 'en-GB',
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
            '-clangd', vim.fn.exepath('clangd'),
            '-cli', vim.fn.exepath('arduino-cli'),
            '-cli-config', vim.fn.expand('~/.arduino15/arduino-cli.yaml')
            -- '-fqbn', 'esp32:esp32:esp32cam',
            -- '-fqbn', 'arduino:avr:uno',
         }
      })
   end
}
