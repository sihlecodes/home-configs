return {
   'williamboman/mason.nvim',

   dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig.nvim',
      'nvim-telescope/telescope.nvim',
   },

   config = function()
      local lspconfig = require('lspconfig')

      require('mason').setup()

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

         map('n', 'gd', vim.lsp.buf.definition, options)
         map('n', 'K', vim.lsp.buf.hover, options)
         map('n', 'gk', vim.lsp.buf.code_action, options)
         map('n', 'gK', vim.diagnostic.open_float, options)
         map('n', ']d', vim.diagnostic.goto_next, options)
         map('n', '[d', vim.diagnostic.goto_prev, options)
         map('n', 'gr', vim.lsp.buf.rename, options)
         -- vim.keymap.set('n', '<leader>gr', '<cmd>LspRestart<cr>', options)
         map('i', '<c-k>', vim.lsp.buf.signature_help, options)
      end

      local default_options = {
         on_attach = on_attach,
         capabilities = {
            textDocument = {
               completion = {
                  completionItem = {
                     snippetSupport = false
                  }
               }
            }
         }
      }

      local function using_options(additional_options)
         return vim.tbl_extend('force', default_options, additional_options)
      end

      local lsp_server_ignore_list = {}

      require('mason-lspconfig').setup { handlers = {
         function (server_name)
            for _, ignored_server in ipairs(lsp_server_ignore_list) do
               if server_name == ignored_server then
                  return
               end
            end

            lspconfig[server_name].setup(using_options {})
         end,

         ['lua_ls'] = function(name)
            lspconfig[name].setup(using_options {
               settings = {
                  Lua = {
                     workspace = {
                        library = {
                           vim.fn.expand('$VIMRUNTIME/lua'),
                           vim.fn.stdpath('config') .. '/lua',
                        }
                     },
                     diagnostics = {
                        globals = {'vim'}
                     }
                  }
               }
            })
         end,

         ['arduino_language_server'] = function(name)
            lspconfig[name].setup(using_options {
               cmd = {
                  'arduino-language-server',
                  '-fqbn', 'esp32:esp32:esp32cam',
                  -- '-fqbn', 'arduino:avr:uno',
               }
            })
         end,
      }}
   end
}
