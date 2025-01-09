return {
   'nvim-telescope/telescope.nvim',

   dependencies = {'nvim-lua/plenary.nvim' },
   tag = '0.1.5',
   config = function()
      local actions = require('telescope.actions')

      require('telescope').setup({
         defaults = {
            preview = {
               filesize_hook = function(filepath, bufnr, opts)
                  local max_bytes = 10000
                  local cmd = {"head", "-c", max_bytes, filepath}
                  require('telescope.previewers.utils').job_maker(cmd, bufnr, opts)
               end
            },
            color_devicons = false,
            mappings = {
               i = {
                  ["<esc>"] = actions.close,
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
