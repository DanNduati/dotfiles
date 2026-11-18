-- Servers: name = per-server overrides. Uses nvim 0.11+ native vim.lsp.config/enable;
-- nvim-lspconfig supplies the default definitions (its lsp/ directory).
local servers = {
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        },
    },
    vimls = {},
    html = {},
    htmx = {},
    ts_ls = {},
    gopls = {},
    zls = {},
    bashls = {},
    rust_analyzer = {},
    -- C/C++ for ESP-IDF and STM32. --query-driver lets clangd resolve system headers
    -- from the cross toolchains; needs a compile_commands.json in the project.
    clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--header-insertion=never",
            "--query-driver=" .. vim.fn.expand("~") .. "/.espressif/tools/**/xtensa-*-gcc,"
                .. vim.fn.expand("~") .. "/.espressif/tools/**/riscv32-*-gcc,"
                .. "/opt/arm-gnu-toolchain-*/bin/arm-none-eabi-*",
        },
    },
    omnisharp = {
        filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets", "tproj", "slngen", "fproj" },
    },
    -- Pyright does types only; Ruff does linting and import sorting.
    pyright = {
        settings = {
            pyright = { disableOrganizeImports = true },
            python = { analysis = { ignore = { "*" } } },
        },
    },
    ruff = {},
}

return {
    -- mason itself is only needed as a dependency (PATH setup) or for :Mason
    { "mason-org/mason.nvim", cmd = "Mason", opts = {} },
    { "neovim/nvim-lspconfig", lazy = true },
    {
        -- Everything LSP-related loads when the first file is opened, not at startup
        "mason-org/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
        opts = {
            -- rust_analyzer comes from rustup, so it is not installed through mason.
            ensure_installed = {
                "lua_ls", "vimls", "html", "htmx", "ts_ls", "gopls", "zls",
                "bashls", "clangd", "omnisharp", "pyright", "ruff",
            },
            automatic_enable = false, -- enabled explicitly below
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)

            vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
            for name, cfg in pairs(servers) do
                vim.lsp.config(name, cfg)
            end
            vim.lsp.enable(vim.tbl_keys(servers))

            vim.diagnostic.config({
                virtual_text = true,
                severity_sort = true,
                float = { border = "rounded" },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
                callback = function(ev)
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    -- Ruff's hover would shadow pyright's
                    if client and client.name == "ruff" then
                        client.server_capabilities.hoverProvider = false
                    end
                    local function map(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
                    end
                    map("n", "K", vim.lsp.buf.hover, "Hover")
                    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("n", "gr", vim.lsp.buf.references, "References")
                    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
                    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
                    map("n", "<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
                    end, "Toggle inlay hints")
                end,
            })
        end,
    },
}
