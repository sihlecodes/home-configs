require('mason').setup()

local lspconfig = require('lspconfig')

local function on_attach(_, buffer)
   local opts = { buffer = buffer, remap = false }
   print("Attached")

   vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
   vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
   vim.keymap.set("n", "<leader>gs", function() vim.lsp.buf.workspace_symbol() end, opts)
   vim.keymap.set("n", "<leader>gf", function() vim.diagnostic.open_float() end, opts)
   vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
   vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
   vim.keymap.set("n", "gc", function() vim.lsp.buf.code_action() end, opts)
   vim.keymap.set("n", "gD", function() vim.lsp.buf.references() end, opts)
   vim.keymap.set("n", "gr", function() vim.lsp.buf.rename() end, opts)
   vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

lspconfig.lua_ls.setup {
   --capabilities = capabilities,
   on_attach = on_attach,
   settings = {
      Lua = {
         workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
         },
         diagnostics = {
            globals = {'vim'}
         }
      }
   }
}

lspconfig.vimls.setup {
   on_attach = on_attach,
}

lspconfig.clangd.setup {
   on_attach = on_attach,
}

lspconfig.arduino_language_server.setup {
   on_attach = on_attach,
   cmd = {
      'arduino-language-server',
      '-fqbn', 'arduino:avr:uno',
   }
}

lspconfig.pyright.setup {
   on_attach = on_attach,
}

local function nkeymap(lhs, rhs, opts)
   if opts == nil then
      opts = {silent = true}
   end

   vim.keymap.set('n', lhs, rhs, opts)
end

--for _, lsp in ipairs(lspconfig.configs) do
--    lsp.setup {
--        on_attach = on_attach,
--    }
--end
--
--local function dump(o)
--   if type(o) == 'table' then
--      local s = '{ '
--      for k,v in pairs(o) do
--         if type(k) ~= 'number' then k = '"'..k..'"' end
--         s = s .. '['..k..'] = ' .. dump(v) .. ','
--      end
--      return s .. '} '
--   else
--      return tostring(o)
--   end
--end
