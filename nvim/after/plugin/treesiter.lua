vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

require('nvim-treesitter.configs').setup({
   modules = {},
   ignore_install = {},
   sync_install = false,
   auto_install = true,
   ensure_installed = {
      "diff",
   },
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

            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",

            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",

            ["av"] = "@variable.outer",
            ["iv"] = "@variable.inner",
         },
      },
   },
})
