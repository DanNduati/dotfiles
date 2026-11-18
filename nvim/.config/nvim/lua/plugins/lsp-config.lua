return {
    {
        "mason-org/mason.nvim",
        lazy = false,
        opts = {},
        config = function()
            require("mason").setup()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.vimls.setup({
                capabilities = capabilities
            })
            lspconfig.html.setup({
                capabilities = capabilities
            })
            lspconfig.ts_ls.setup({
                capabilities = capabilities
            })
            lspconfig.omnisharp.setup({
				capabilities = capabilities,
				--enable_roslyn_analysers = true,
				--enable_import_completion = true,
				--organize_imports_on_format = true,
				--enable_decompilation_support = true,
				filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets', 'tproj', 'slngen', 'fproj' },
			})
            lspconfig.pyright.setup({
				capabilities = capabilities,
                settings = {
                    pyright = {
                        -- Using Ruff's import organizer
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            -- Ignore all files for analysis to exclusively use Ruff for linting
                            ignore = { '*' },
                        },
                    },
                },
            })
            --[[
            lspconfig.ruff.setup({
                init_options = {
                    settings = {
                        logLevel = 'debug',
                    }
                }
            })
            ]]
            lspconfig.gopls.setup({
                capabilities = capabilities
            })
            lspconfig.zls.setup({
                capabilities = capabilities
            })
            lspconfig.htmx.setup({
                capabilities = capabilities
            })
            vim.diagnostic.config({
                virtual_text = true
            })
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})                         -- Hover on keywords
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})                   -- Go to definition
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})                   -- Reference
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {}) -- Code actions
        end
    }
}
