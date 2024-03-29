return {
   'nvim-telescope/telescope.nvim',

   dependencies = {'nvim-lua/plenary.nvim' },
   tag = '0.1.5',
   config = function()
      require('telescope').setup({
         defaults = {
            color_devicons = false,
            mappings = {
               i = {
                  ["<esc>"] = require('telescope.actions').close,
               },
            }
         },
      })

      local builtin = require('telescope.builtin')
      local map = vim.keymap.set

      map('n', '<leader>ff', builtin.find_files)
      map('n', '<leader>fg', builtin.live_grep)
      map('n', '<leader>fb', builtin.buffers)
      map('n', '<leader>fh', builtin.help_tags)
   end
}
