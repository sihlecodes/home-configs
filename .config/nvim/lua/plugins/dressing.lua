return {
   'stevearc/dressing.nvim',

   config = function()
      require('dressing').setup({
         input = {
            title_pos = 'center',
            start_mode = 'normal',
         }
      });
   end
}
