return {
  {
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
        buftype = {
          "acwrite",
          "quickfix",
          "DAP Scopes",
          "DAP Breakpoints",
          "DAP Stacks",
          "DAP Watches",
          "[dap-repl]",
          "DAP Console",
        },
        filetype = {
          "gitsigns",
          "DiffviewFiles",
          "NvimTree",
          "neo-tree",
          "undotree",
          "gundo",
          "DAP Scopes",
          "DAP Breakpoints",
          "DAP Stacks",
          "DAP Watches",
          "[dap-repl]",
          "DAP Console",
        },
      },
      animation = {
        enable = true,
        duration = 150,
        fps = 60,
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
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
