-- author: Siphesihle Mhlongo
--
-- created: 25/12/2023
-- updated: 25/12/2023

return {
   'stevearc/vim-arduino',

   config = function()
      -- removes the default verbose flags
      vim.g.arduino_cli_args = ''
      vim.g.arduino_args = ''
   end,
}
