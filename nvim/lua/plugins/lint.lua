return {
   "mfussenegger/nvim-lint",

   dependencies = {
      "rshkarin/mason-nvim-lint",
   },
   config = function()
      require('lint').linters_by_ft = {
         cpp = {'codespell'},
         python = {'codespell'},
         gdscript = {'gdlint'},
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
         callback = function()
            require("lint").try_lint()
         end,
      })

      -- vim.g.linter_flake8_args = '--ignore=W302,W301'
   end
}
