return {
   'folke/tokyonight.nvim',

   config = function()
      require("tokyonight").setup {
         style = "night",
         transparent = true,
         terminal_colors = true,

         styles = {
            comments = { italic = true },
            keywords = { italic = false },
            functions = {},
            variables = {},
            -- "dark", "transparent" or "normal"
            sidebars = "dark",
            floats = "dark",
         },

         hide_inactive_statusline = false,
         dim_inactive = false,
         lualine_bold = false,

         on_colors = function(_)
         end,

         on_highlights = function(hl, c)
            hl.Folded.link = "Comment"
            hl.CursorLine = {
               bg = c.bg_dark,
            }
            hl.Cursor = {
               bg = c.bg_dark,
               fg = c.bg_dark,
            }
            hl.NvimTreeNormal = {
               bg = 'none',
            }
         end,
      }

      vim.cmd.colorscheme('tokyonight')
   end
}
