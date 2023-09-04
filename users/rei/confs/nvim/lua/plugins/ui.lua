return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    build = ':CatppuccinCompile',
    lazy = false,
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {},
  },

  -- personally don't like trouble
  { "folke/trouble.nvim", enabled = false },
}
