return {
   'tpope/vim-commentary',
   config = function()
      vim.keymap.set('n', '<C-/>', 'gcc', { remap = true })
      vim.keymap.set('n', '<C-_>', 'gcc', { remap = true })

      vim.keymap.set('v', '<C-/>', 'gc', { remap = true })
      vim.keymap.set('v', '<C-_>', 'gc', { remap = true })

      vim.keymap.set('x', '<C-/>', 'gc', { remap = true })
      vim.keymap.set('x', '<C-_>', 'gc', { remap = true })
   end
}
