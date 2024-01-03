local function has_item(list, target)
   for _, item in ipairs(list) do
      if item == target then
         return true
      end
   end
   return false
end

local ignored_filetypes = {'help', 'nerdtree'}

local function tab_next_name()
   local current_tabnumber = vim.fn.tabpagenr()
   local last_tabnumber = vim.fn.tabpagenr('$')
   local next_tabnumber = current_tabnumber == last_tabnumber and 1 or current_tabnumber + 1
   local buffers = vim.fn.tabpagebuflist(next_tabnumber)
   local filename

   for _, buffer in ipairs(buffers) do
      local filetype = vim.fn.getbufvar(buffer, '&filetype')
      filename = vim.fn.fnamemodify(vim.fn.bufname(buffer), ':t')
      if not has_item(ignored_filetypes, filetype) then
         return filename
      end
   end

   return filename
end

require("lualine").setup {
   options = {
      icons_enabled = false,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      symbols = {
         readonly = '\u{e0a2}', -- 
         modified = '\u{25cf}', -- ●
      },
   },
   sections = {
      lualine_b = {'branch', 'diff'},
      lualine_x = {'filetype'},
   },
   tabline = {
      lualine_a = {'filename'},
      lualine_b = {'tabs', tab_next_name },
      lualine_c = {},
   },
}
