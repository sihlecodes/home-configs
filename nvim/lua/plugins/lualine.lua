return {
   'nvim-lualine/lualine.nvim',

   config = function()
      local function has_item(list, target)
         for _, item in ipairs(list) do
            if item == target then
               return true
            end
         end
         return false
      end

      local ignored_filetypes = {'help', 'nerdtree', 'NvimTree', '', 'qf'}

      local function tab_next_name()
         local current_tabnumber = vim.fn.tabpagenr()
         local last_tabnumber = vim.fn.tabpagenr('$')

         if last_tabnumber == 1 then
            return ''
         end

         local next_tabnumber = current_tabnumber == last_tabnumber and 1 or current_tabnumber + 1
         local buffers = vim.fn.tabpagebuflist(next_tabnumber)
         local filename

         for _, buffer in ipairs(buffers) do
            local filetype = vim.fn.getbufvar(buffer, '&filetype')
            filename = vim.fn.fnamemodify(vim.fn.bufname(buffer), ':t')
            if not has_item(ignored_filetypes, filetype) then
               return filename == '' and '[no name]' or filename
            end
         end
      end

      require('lualine').setup {
         options = {
            icons_enabled = true,
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            symbols = {
               readonly = '\u{e0a2}', -- 
               modified = '\u{25cf}', -- ●
            },
         },
         sections = {
            lualine_b = {
               { 'branch', icons_enabled = false, },
            },
            lualine_c = {
               { 'diff', colored = true, padding = { left = 1, right = 0 }},
               { 'filename',
                  symbols = {
                     modified = '\u{25cf}', -- ●
                     readonly = '\u{e0a2}', -- 
                     unnamed = '[no name]',
                     newfile = '[new]',
                  },
               },
            },
            lualine_x = {
               { 'filetype',
                  colored = false,
                  icon = { align = 'right' }
               }
            },
         },
         tabline = {
            lualine_a = {
               { 'filename',
                  file_status = false,
                  symbols = {
                     unnamed = '[no name]',
                     newfile = '[new]',
                  }
               }
            },
            lualine_b = {'tabs'},
            lualine_c = {tab_next_name},
         },
      }
   end
}
