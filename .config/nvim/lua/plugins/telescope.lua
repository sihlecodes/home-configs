return {
   'nvim-telescope/telescope.nvim',

   dependencies = {'nvim-lua/plenary.nvim' },
   tag = '0.1.5',
   config = function()
      local actions = require('telescope.actions')
      local previewers = require('telescope.previewers')
      local max_size = 100 * 1024

      require('telescope').setup({
         defaults = {
            buffer_previewer_maker = function(filepath, bufnr, opts)
               opts = opts or {}

               filepath = vim.fn.expand(filepath)
               vim.loop.fs_stat(filepath, function(_, stat)
                  if not stat then return end
                  if stat.size > max_size then
                     return
                  else
                     previewers.buffer_previewer_maker(filepath, bufnr, opts)
                  end
               end)
            end,

            file_ignore_patterns = {
               'node_modules',
               '%.png',
               '%.jpg',
               '%.pdf',
            },
            preview = {
               filesize_hook = function(filepath, bufnr, opts)
                  local max_bytes = 10000
                  local cmd = {'head', '-c', max_bytes, filepath}
                  require('telescope.previewers.utils').job_maker(cmd, bufnr, opts)
               end
            },

            color_devicons = false,
            mappings = {
               i = {
                  ['<esc>'] = actions.close,
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
