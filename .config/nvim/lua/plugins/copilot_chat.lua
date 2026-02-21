return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    local copilot = require("CopilotChat")

    copilot.setup({
      window = {
        layout = 'float',
      },
      auto_insert_mode = true,
    })

    local options = { noremap = true, silent = true }

    local map = function(mode, lhs, rhs, opts)
      vim.keymap.set(mode, lhs, rhs, opts or options)
    end

    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = 'copilot-*',
      callback = function()
        map('i', '<cr>', '<c-s>', { buffer = true, silent = true })
      end,
    })

    map("n", "<leader>cc", "<cmd>CopilotChat<cr>")
    map("v", "<leader>cc", "<cmd>CopilotChat<cr>")
    map("n", "<leader>cm", "<cmd>CopilotChatModels<cr>")
    map("n", "<leader>cu", "<cmd>CopilotChatUpdate<cr>")
  end,
}

