local lspconfig = require('lspconfig')

require('mason').setup()

local function on_attach(_, buffer)
   local options = { buffer = buffer, remap = false }

   vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, options)
   vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, options)
   vim.keymap.set('n', 'gk', function() vim.lsp.buf.code_action() end, options)
   vim.keymap.set('n', 'gs', function() vim.lsp.buf.workspace_symbol() end, options)
   vim.keymap.set('n', 'gK', function() vim.diagnostic.open_float() end, options)
   vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, options)
   vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, options)
   vim.keymap.set('n', 'gD', function() vim.lsp.buf.references() end, options)
   vim.keymap.set('n', 'gr', function() vim.lsp.buf.rename() end, options)
   -- vim.keymap.set('n', '<leader>gr', '<cmd>LspRestart<cr>', options)
   vim.keymap.set('i', '<c-k>', function() vim.lsp.buf.signature_help() end, options)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local default_options = {
   on_attach = on_attach,
   capabilities = capabilities,
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
