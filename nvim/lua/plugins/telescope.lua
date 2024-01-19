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

      vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
      vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
      vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
   end
}
