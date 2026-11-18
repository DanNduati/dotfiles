return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        { "<C-n>", "<cmd>Neotree filesystem reveal left<CR>", desc = "File tree" },
    },
    init = function()
        -- `nvim <dir>` should still open the tree even though the plugin is lazy
        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("NeoTreeDirOpen", { clear = true }),
            once = true,
            callback = function()
                if package.loaded["neo-tree"] then return end
                local stat = vim.uv.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then require("neo-tree") end
            end,
        })
    end,
    opts = {},
}
