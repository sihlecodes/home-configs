return {
   'L3MON4D3/LuaSnip',

   config = function()
      local ls = require('luasnip')

      ls.setup({
         store_selection_keys = "<Tab>"
      })

      ls.filetype_extend("all", {"_"})

      require("luasnip.loaders.from_snipmate").lazy_load()

      -- vim.keymap.set("i", "<c-k>", function() ls.expand() end, {silent = true})
      vim.keymap.set({"i", "s"}, "<c-l>",
         function()
            if ls.jumpable(1) then
               ls.jump(1)
            end
         end, {silent = true})

      vim.keymap.set({"i", "s"}, "<c-j>",
         function()
            if ls.jumpable(-1) then
               ls.jump(-1)
            end
         end, {silent = true})
   end
}
