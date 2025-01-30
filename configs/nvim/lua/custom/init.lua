-- Delete without yanking
vim.keymap.set("n", "d", '"_d', { noremap = true })
vim.keymap.set("v", "d", '"_d', { noremap = true })
vim.keymap.set("n", "D", '"_D', { noremap = true })
vim.keymap.set("n", "x", '"_x', { noremap = true })

local autocmd = vim.api.nvim_create_autocmd

-- Auto open nvim-tree when opening nvim
autocmd({ "VimEnter" }, {
  callback = function()
    require("nvim-tree.api").tree.open()
  end,
})
