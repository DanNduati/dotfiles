return {
    'sainnhe/gruvbox-material',
    lazy = false,
    name = "Gruvbox",
    priority = 1000,
    config = function()
        vim.cmd.colorscheme "gruvbox"
        vim.o.background = "dark"
    end
}
