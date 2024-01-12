-- ~/.local/share/nvim/lazy/
-- ~/.config/nvim/after/plugin/
require('lazy').setup {
   -- Appearance plugins
   'folke/tokyonight.nvim',
   'nvim-lualine/lualine.nvim',
   'kosayoda/nvim-lightbulb',

   'nvim-tree/nvim-tree.lua',
   'stevearc/vim-arduino',
   'kshenoy/vim-signature',
   'nvim-treesitter/playground',
   'houtsnip/vim-emacscommandline',
   'vimwiki/vimwiki',

   'nvim-treesitter/nvim-treesitter',
   'nvim-treesitter/nvim-treesitter-textobjects',

   { 'numToStr/Comment.nvim',
      config = function()
         require('Comment').setup()
      end
   },

   'stevearc/dressing.nvim',
   {
      'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = {'nvim-lua/plenary.nvim' }
   },

   {
      -- LSP plugins
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Linter plugins
      "mfussenegger/nvim-lint",
      "rshkarin/mason-nvim-lint",
   },

   {
      'L3MON4D3/LuaSnip',

      -- Completion plugins
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/nvim-cmp',
   }
}
