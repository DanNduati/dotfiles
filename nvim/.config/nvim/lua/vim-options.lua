-- Leader must be set before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Indentation (4 spaces)
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true

-- UI
opt.number = true
opt.cursorline = true
opt.signcolumn = "yes" -- stop the text shifting when diagnostics appear
opt.termguicolors = true
opt.scrolloff = 8
opt.wrap = false
opt.splitright = true
opt.splitbelow = true

-- Search
opt.ignorecase = true
opt.smartcase = true -- case-sensitive once you type a capital
opt.inccommand = "split" -- live preview of :s

-- Behaviour
opt.clipboard = "unnamedplus"
opt.undofile = true -- persistent undo across sessions
opt.updatetime = 250
opt.timeoutlen = 400

-- Keymaps
local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Diagnostics
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- Keep the cursor centred when paging / searching
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ timeout = 150 })
    end,
})
