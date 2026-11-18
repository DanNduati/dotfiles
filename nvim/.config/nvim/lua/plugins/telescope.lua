return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        -- Loaded on first use of one of these keys or :Telescope
        cmd = "Telescope",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },
        keys = {
            { '<C-p>', function() require('telescope.builtin').find_files() end, desc = 'Telescope find files' },
            { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Telescope live grep' },
            { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Telescope buffers' },
            { '<leader>fr', function() require('telescope.builtin').oldfiles() end, desc = 'Telescope recent files' },
            { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Telescope help' },
            { '<leader>fd', function() require('telescope.builtin').diagnostics() end, desc = 'Telescope diagnostics' },
            { '<leader>/', function() require('telescope.builtin').current_buffer_fuzzy_find() end, desc = 'Fuzzy find in buffer' },
        },
        init = function()
            -- Code actions etc. use Telescope's dropdown (ui-select). Load Telescope the first
            -- time vim.ui.select is called; the extension then replaces vim.ui.select itself.
            local default_select = vim.ui.select
            vim.ui.select = function(...)
                vim.ui.select = default_select
                require("lazy").load({ plugins = { "telescope.nvim" } })
                return vim.ui.select(...)
            end
        end,
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            }
            require("telescope").load_extension("ui-select")
        end
    },
    { 'nvim-telescope/telescope-ui-select.nvim', lazy = true },
}
