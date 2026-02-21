return {
   'hrsh7th/nvim-cmp',

   dependencies = {
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
   },

   config = function()
      local cmp = require('cmp')
      local behaviour = { behavior = cmp.SelectBehavior.Insert }

      local function when_visible(callback)
         return function(fallback)
            if cmp.visible() then
               callback()
            else
               fallback()
            end
         end
      end

      cmp.setup.cmdline({'/', '?'}, {
         mapping = cmp.mapping.preset.cmdline(),
         sources = cmp.config.sources({
            { name = 'buffer' }
         })
      })

      cmp.setup.cmdline(':', {
         mapping = {
            ['<tab>']   = { c = when_visible(cmp.select_next_item) },
            ['<s-tab>'] = { c = when_visible(cmp.select_prev_item) },
         },
         sources = cmp.config.sources({
            { name = 'path' },
            { name = 'cmdline',
            option = {ignore_cmds = { 'Man', '!' }}
         }
      })
   })

   cmp.setup({
      snippet = {
         expand = function(args)
            require('luasnip').lsp_expand(args.body)
         end,
      },
      sources = cmp.config.sources({
         {name = 'nvim_lsp'},
         {name = 'nvim_lua'},
         {name = 'luasnip'},
         {name = 'buffer'},
         {name = 'path'},
         {name = 'nvim_lsp_signature_help'},
      }),
      window = {
         completion = cmp.config.window.bordered(),
         documentation = cmp.config.window.bordered(),
      },
      preselect = 'item',
      mapping = cmp.mapping.preset.insert({
         ['<tab>'] = cmp.mapping.select_next_item(behaviour),
         ['<s-tab>'] = cmp.mapping.select_prev_item(behaviour),
         ['<cr>'] = cmp.mapping.confirm({select = true}),
         ['<c-space>'] = cmp.mapping.complete(),
         ['<c-u>'] = cmp.mapping.scroll_docs(-4),
         ['<c-d>'] = cmp.mapping.scroll_docs(4),
      }),
   })
end
}
