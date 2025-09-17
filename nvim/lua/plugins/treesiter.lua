return {
   'nvim-treesitter/nvim-treesitter',

   opts = function(_, opts)
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.ejs = {
         install_info = {
            url = 'https://github.com/tree-sitter/tree-sitter-embedded-template',
            files = { 'src/parser.c' },
            branch = 'main',
         },
         filetype = 'ejs',
      }
   end,

   dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
   },

   config = function()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false
      vim.opt.foldlevelstart = 99

      require('nvim-treesitter.configs').setup({
         modules = {},
         ignore_install = {},
         sync_install = false,
         auto_install = true,
         ensure_installed = { "diff", },
         indent = {
            enable = true,
         },
         highlight = {
            enable = true,

            disable = function(lang, bufnr)
               local file_path = vim.api.nvim_buf_get_name(bufnr)
               local file_size = vim.fn.getfsize(file_path)

               return vim.api.nvim_buf_line_count(bufnr) > 50000 or file_size > 1024 * 1024
            end,

            additional_vim_regex_highlighting = false,
         },
         textobjects = {
            select = {
               enable = true,
               keymaps = {
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",

                  ["aa"] = "@parameter.outer",
                  ["ia"] = "@parameter.inner",
               },
            },
            move = {
               enable = true,
               goto_next_start = {
                  [']]'] = '@function.outer',
               },
               goto_previous_start = {
                  ['[['] = '@function.outer',
               }
            }
         },
      })
   end
}
