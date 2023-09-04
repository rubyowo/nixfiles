-- make all keymaps silent by default
local keymap_set = vim.keymap.set
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>x", ":x<cr>")
