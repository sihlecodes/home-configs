-- ~/.local/share/nvim/lazy/
-- ~/.config/nvim/lua/plugins

return {
   'tpope/vim-fugitive',

   { "folke/neodev.nvim",
      opts = {},
   },
   { "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {}
   },

   { 'christoomey/vim-tmux-navigator',
      lazy = false,
   },

   'kshenoy/vim-signature',
   'houtsnip/vim-emacscommandline',
   'vimwiki/vimwiki',
   'lervag/vimtex',
}
