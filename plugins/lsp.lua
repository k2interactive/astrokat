local utils = require "astronvim.utils"
return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, config)
      -- config variable is the default configuration table for the setup function call
      local null_ls = require "null-ls"

      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.diagnostics.mypy,
      }
      return config -- return final config table
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
      search_venv_managers = true,
      search_workspace = false,
      search = false,
      dap_enabled = false,
      poetry_path = false,
      pdm_path = false,
      pyenv_path = false,
      hatch_path = false,
      venvwrapper_path = false,
      anaconda_base_path = false,
      anaconda_envs_path = false,
      enable_debug_output = true,
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>vs", "<cmd>VenvSelect<cr>" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
      -- Keymap to show the current venv
      { "<leader>vC", "<cmd>VenvSelectCurrent<cr>" },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "python")
      if not opts.handlers then opts.handlers = {} end
      opts.handlers.python = function() end -- make sure python doesn't get set up by mason-nvim-dap, it's being set up by nvim-dap-python
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    ft = "python", -- NOTE: ft: lazy-load on filetype
    config = function(_, opts)
      local path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"
      require("dap-python").setup(path, opts)

      local dap = require "dap"
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "FastAPI module",
        module = "uvicorn",
        args = {
          "main:app",
          "--use-colors",
          -- '--reload', -- doesn't work
        },
        pythonPath = "python",
        console = "integratedTerminal",
      })
    end,
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      aggressive_mode = false,
      excluded_lsp_clients = { "null-ls", "jdtls" },
      grace_period = 60 * 15,
      wakeup_delay = 0,
      notifications = false,
      retries = 3,
      timeout = 100,
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      floating = { border = "rounded" },
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
            {
              id = "watches",
              size = 0.25,
            },
          },
          -- position = "left",
          position = "right",
          size = 40,
        },
        {
          elements = {
            -- {
            --   id = "repl",
            --   size = 0.5,
            -- },
            {
              id = "console",
              size = 1.0,
            },
          },
          position = "bottom",
          -- size = 20,
          size = 0.50,
        },
      },
    },
    config = function(_, opts)
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
      dapui.setup(opts)
    end,
  },
}
