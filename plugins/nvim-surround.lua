return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  opts = {
    keymaps = { visual = "<C-y>" },
    highlight = { duration = 500 },
  },
}
