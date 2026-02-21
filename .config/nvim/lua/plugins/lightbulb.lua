return {
   'kosayoda/nvim-lightbulb',

   config =function()
      require("nvim-lightbulb").setup({
         update_time = 100,
         sign = {enabled = false},
         virtual_text = { enabled = true },
         autocmd = { enabled = true },
      })
   end
}
