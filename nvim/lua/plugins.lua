vim.cmd [[packadd packer.nvim]]

-- ~/.local/share/nvim/site/pack/packer/start/
-- ~/.config/nvim/after/plugin/
return require('packer').startup(function(use)
   use 'wbthomason/packer.nvim'
   use 'stevearc/dressing.nvim'
   use 'stevearc/vim-arduino'
   use 'folke/tokyonight.nvim'
   use 'nvim-lualine/lualine.nvim'

   use 'nvim-treesitter/playground'
   use 'nvim-treesitter/nvim-treesitter-textobjects'
   use 'kshenoy/vim-signature'

   use {
      'numToStr/Comment.nvim',
      config = function()
         require('Comment').setup()
      end
   }

   use 'houtsnip/vim-emacscommandline'
   use 'vimwiki/vimwiki'
   use 'preservim/nerdtree'

   use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
   use({ 'nvim-telescope/telescope.nvim', tag = '0.1.5',
      requires = {'nvim-lua/plenary.nvim' }})

   -- LSP plugins
   use 'neovim/nvim-lspconfig'
   use 'williamboman/mason.nvim'
   use 'williamboman/mason-lspconfig.nvim'

   use {
      'L3MON4D3/LuaSnip', tag = "v2.*",
      run = "make install_jsregexp"
   }
   use 'rafamadriz/friendly-snippets'
   -- Completion plugins
   use 'hrsh7th/cmp-nvim-lsp'
   use 'hrsh7th/cmp-buffer'
   use 'hrsh7th/cmp-path'
   use 'hrsh7th/cmp-cmdline'
   use 'saadparwaiz1/cmp_luasnip'
   use 'hrsh7th/nvim-cmp'
   use 'hrsh7th/cmp-nvim-lsp-signature-help'
end)
