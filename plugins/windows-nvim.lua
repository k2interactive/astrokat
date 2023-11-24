return {
  "anuvyklack/windows.nvim",
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },
  opts = {
    autowidth = { --		       |windows.autowidth|
      enable = true,
      -- winwidth = 8, --		        |windows.winwidth|
      winwidth = 0.666, --		        |windows.winwidth|
      filetype = { --	      |windows.autowidth.filetype|
        help = 2,
      },
    },
    ignore = { --			  |windows.ignore|
      buftype = { "quickfix" },
      filetype = { "NvimTree", "neo-tree", "undotree", "gundo" },
    },
    animation = {
      enable = true,
      duration = 150,
      fps = 30,
      easing = "in_out_sine",
    },
  },
  cmd = {
    "WindowsMaximize",
    "WindowsMaximizeVertically",
    "WindowsMaximizeHorizontally",
    "WindowsEqualize",
    "WindowsEnableAutowidth",
    "WindowsDisableAutowidth",
    "WindowsToggleAutowidth",
  },
  init = function()
    vim.o.winwidth = 1
    vim.o.winminwidth = 0
    vim.o.equalalways = false
    require("windows").setup()
  end,
}
