vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<cr>', {silent = true})

local function _on_attach(bufnr)
   local api = require "nvim-tree.api"

   local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
   end

   api.config.mappings.default_on_attach(bufnr)

   vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
   vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

require('nvim-tree').setup({
   on_attach = _on_attach,
   select_prompts = true,
   respect_buf_cwd = true,
   actions = {
      open_file = {
         quit_on_open = true,
         eject = true,
         resize_window = false,
      }
   },
   -- actions = {
   --    open_file = {
   --       quit_on_open = true,
   --       eject = true,
   --       resize_window = false,
   --       window_picker = {
   --          enable = false,
   --       },
   --    },
   -- },
   git = {
      enable = true,
      show_on_dirs = false,
      show_on_open_dirs = false,
      disable_for_dirs = {},
      timeout = 400,
      cygwin_support = false,
   },
   renderer = {
      group_empty = true,
      highlight_git = true,
      special_files = {},
      root_folder_label = function(path)
         if path:len() >= 25 then
            path = vim.fn.pathshorten(path, 1)
         end

         return path .. "/"
      end,
      indent_width = 2,
      indent_markers = {
         enable = true,
      },
      icons = {
         git_placement = "after",
         modified_placement = "after",
         diagnostics_placement = "signcolumn",
         bookmarks_placement = "signcolumn",
         padding = " ",
         symlink_arrow = " -> ",
         show = {
            file = true,
            folder = false,
            folder_arrow = true,
            git = true,
            modified = false,
            diagnostics = true,
            bookmarks = true,
         },
         glyphs = {
            folder = {
               arrow_closed = "+",
               arrow_open = "-",
            },
            git = {
               unstaged = "*",
               staged = "+",
               unmerged = "",
               renamed = "",
               untracked = "#",
               deleted = "-",
               ignored = "",
            },
         },
         web_devicons = {
            file = {
               color = false,
            },
            folder = {
               enable = false,
            },
         },
      }
   },
   diagnostics = {
      enable = false,
   },
})
