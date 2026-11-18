-- Formatting (replaces none-ls). <leader>gf is the same key as before.
-- Formatters that are missing are skipped with a notice. Install with :MasonInstall, e.g. prettier.
return {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>gf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = { "n", "v" },
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "gofmt" },
            python = { "ruff_organize_imports", "ruff_format" },
            rust = { "rustfmt" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            json = { "jq" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            markdown = { "prettier" },
        },
    },
}
