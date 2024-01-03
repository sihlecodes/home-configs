vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

require('nvim-treesitter.configs').setup({
    modules = {},
    ignore_install = {},
    sync_install = false,
    auto_install = true,
    ensure_installed = {
        "c_sharp", "python",
        "arduino", "c", "lua",
        "vim"
    },
    indent = {
        enable = true,
    },
    highlight = {
        enable = true,
    },
})
