return {
   'numToStr/Comment.nvim',

   config = function()
      require('Comment').setup()
      local api = require('Comment.api')

      vim.keymap.set('n', '<C-_>', api.toggle.linewise.current)
   end
}
