return {
    'nvimtools/none-ls.nvim',
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.gofmt,
                --null_ls.builtins.formatting.zig_fmt.with({ command = "/home/daniel/zig-x86_64-linux-0.14.1/zig" }),
                --null_ls.builtins.formatting.ruff,
                null_ls.builtins.formatting.prettier,
            },
        })
        vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
    end
}
