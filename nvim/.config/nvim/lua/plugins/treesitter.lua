return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = {
                "lua", "luadoc", "vim", "vimdoc", "query", "bash", "c", "cpp", "rust", "go", "gomod",
                "zig", "python", "json", "jsonc", "yaml", "toml", "html", "css", "javascript",
                "typescript", "markdown", "markdown_inline", "regex", "diff", "dockerfile", "make",
                "cmake", "c_sharp", "sql", "xml",
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}