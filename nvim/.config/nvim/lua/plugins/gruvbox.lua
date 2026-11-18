return {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    name = "Gruvbox",
    priority = 1000,
    config = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme "gruvbox"
    end
}
