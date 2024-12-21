return {
   "nvim-neotest/nvim-nio",
   "mfussenegger/nvim-dap",

   dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "rcarriga/nvim-dap-ui",
      "folke/neodev.nvim",
   },

   config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      local neodev = require('neodev')
      local masondap = require('mason-nvim-dap')

      masondap.setup({
         handlers = {
            function(config)
               masondap.default_setup(config)
            end,
         }
      })

      dapui.setup()

      neodev.setup({
         library = { plugins = { "nvim-dap-ui" }, types = true },
      })

      local map = vim.keymap.set

      map('n', 'dc', dap.continue)
      map('n', 'du', dapui.toggle)
      map('n', 'dn', dap.step_over)
      map('n', 'ds', dap.step_into)
      map('n', 'do', dap.step_out)
      map('n', 'db', dap.toggle_breakpoint)

      dap.adapters.python = {
         type = 'executable';
         command = '/usr/bin/python3';
         args = { '-m', 'debugpy.adapter' };
      }

      dap.configurations.python = {
         {
            type = 'python';
            request = 'launch';
            name = "Launch file";
            program = "${file}";
            pythonPath = function()
               return '/usr/bin/python3'
            end;
         },
      }
   end
}
