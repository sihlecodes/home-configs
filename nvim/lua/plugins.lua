vim.cmd [[packadd packer.nvim]]

-- ~/.local/share/nvim/site/pack/packer/start/
-- ~/.config/nvim/after/plugin/
return require('packer').startup(function(use)
   use 'wbthomason/packer.nvim'
   use 'stevearc/vim-arduino'
   use 'jpalardy/vim-slime'

   use 'vimwiki/vimwiki'
   use 'preservim/nerdtree'

   use {
      'nvim-lualine/lualine.nvim',
      requires = {'nvim-tree/nvim-web-devicons', opt = true}
   }

   use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
   use({ 'nvim-telescope/telescope.nvim', tag = '0.1.5',
      requires = {'nvim-lua/plenary.nvim' }})

   use {
   'folke/tokyonight.nvim',
      config = function()
         vim.cmd.colorscheme('tokyonight-night')
      end
   }

   -- LSP plugins
   use 'neovim/nvim-lspconfig'
   use 'williamboman/mason.nvim'
   use 'williamboman/mason-lspconfig.nvim'
   use 'hrsh7th/cmp-nvim-lsp'

   use {
      'L3MON4D3/LuaSnip', tag = "v2.*",
      run = "make install_jsregexp"
   }
   -- Completion plugins
   use 'hrsh7th/cmp-buffer'
   use 'hrsh7th/cmp-path'
   use 'hrsh7th/cmp-cmdline'
   use 'saadparwaiz1/cmp_luasnip'
   use 'hrsh7th/nvim-cmp'
end)
