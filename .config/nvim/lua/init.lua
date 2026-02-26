-- Add to init.lua
local _make_position_params = vim.lsp.util.make_position_params

vim.lsp.util.make_position_params = function(window, encoding)
  return _make_position_params(window or 0, encoding or vim.lsp.get_clients({ bufnr = 0 })[1].offset_encoding)
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({ spec = 'plugins', change_detection = { notify = false }})
