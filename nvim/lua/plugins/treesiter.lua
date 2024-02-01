return {
   'nvim-treesitter/nvim-treesitter',

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
         },
      })
   end
}
