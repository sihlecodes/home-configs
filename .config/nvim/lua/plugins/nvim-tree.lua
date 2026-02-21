return {
   'nvim-tree/nvim-tree.lua',

   dependencies = {'nvim-tree/nvim-web-devicons'},
   version = "*",
   lazy = false,
   config = function()
      vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<cr>', {silent = true})

      local function _on_attach(bufnr)
         local api = require "nvim-tree.api"

         local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
         end

         api.config.mappings.default_on_attach(bufnr)

         vim.keymap.set('n', 'h', api.tree.change_root_to_parent, opts('Up'))
         vim.keymap.set('n', 'l', api.tree.change_root_to_node, opts('Down'))
         vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      end

      local function open_nvim_tree(data)

         -- buffer is a directory
         local directory = vim.fn.isdirectory(data.file) == 1

         if not directory then
            return
         end

         -- change to the directory
         vim.cmd.cd(data.file)

         -- open the tree
         require("nvim-tree.api").tree.open()
      end

      vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })

      require('nvim-tree').setup({
         on_attach = _on_attach,
         select_prompts = true,
         respect_buf_cwd = true,
         actions = {
            open_file = {
               quit_on_open = true,
               eject = false,
               resize_window = true,
            }
         },
         notify = {
            threshold = vim.log.levels.WARN
         },
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
               },
            }
         },
         tab = {
            sync = {
               close = true,
            }
         },

         diagnostics = {
            enable = false,
         },
      })
   end
}
