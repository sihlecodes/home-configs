return {
   'numToStr/Comment.nvim',

   config = function()
      require('Comment').setup()
      local api = require('Comment.api')

      vim.keymap.set('n', '<C-_>', api.toggle.linewise.current)
      vim.keymap.set('v', '<C-_>', api.toggle.linewise.current)

      local esc = vim.api.nvim_replace_termcodes(
            '<ESC>', true, false, true
      )

   -- Toggle selection (linewise)
      vim.keymap.set('x', '<C-_>', function()
         vim.api.nvim_feedkeys(esc, 'nx', false)
         api.toggle.linewise(vim.fn.visualmode())
      end)
   end
}
