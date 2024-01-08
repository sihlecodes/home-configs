local cmp = require('cmp')
local behaviour = { behavior = cmp.SelectBehavior.Insert }

cmp.setup.cmdline({'/', '?'}, {
   mapping = cmp.mapping.preset.cmdline(),
   sources = cmp.config.sources({
      { name = 'buffer' }
   })
})

cmp.setup.cmdline(':', {
   mapping = {
      ['<Tab>'] = {
         c = function()
            if cmp.visible() then
               cmp.select_next_item()
            else
               cmp.complete()
            end
         end,
      },
      ['<S-Tab>'] = {
         c = function()
            if cmp.visible() then
               cmp.select_prev_item()
            else
               cmp.complete()
            end
         end,
      },
   },
   sources = cmp.config.sources({
      { name = 'path' }
   },
      {{
         name = 'cmdline',
         option = {ignore_cmds = { 'Man', '!' }}
      }})
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
