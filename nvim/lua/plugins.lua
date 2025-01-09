-- ~/.local/share/nvim/lazy/
-- ~/.config/nvim/lua/plugins

return {
   {'j-hui/fidget.nvim',
      config = function()
         require('fidget').setup {
            progress = {
               display = {
                  done_icon = "",
               }
            },
            notification = {
               window = {
                  winblend = 0, -- note: not winblend!
                  relative = "editor"
               }
            }
         }
      end
   },
   'tpope/vim-fugitive',
   'tpope/vim-sleuth',
   {
      "ray-x/lsp_signature.nvim",
      event = "VeryLazy",
      opts = {},
      config = function()
         require "lsp_signature".setup({
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            handler_opts = {
               border = "rounded"
            }
         })
      end
   },

   { "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {}
   },

   { 'christoomey/vim-tmux-navigator',
      lazy = false,
   },

   'kshenoy/vim-signature',
   -- 'houtsnip/vim-emacscommandline',
   'vimwiki/vimwiki',
   'lervag/vimtex',
}
