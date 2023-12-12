local utils = require "astronvim.utils"
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, {
          "bash",
          "markdown",
          "markdown_inline",
          "regex",
          "vim",
        })
      end
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    cond = not vim.g.neovide,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = function(_, opts)
      return utils.extend_tbl(opts, {
        cmdline = {
          enabled = true, -- enables the Noice cmdline UI
          view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
          opts = {}, -- global options for the cmdline. See section on views
          ---@type table<string, CmdlineFormat>
          format = {
            -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
            -- view: (default is cmdline view)
            -- opts: any options passed to the view
            -- icon_hl_group: optional hl_group for the icon
            -- title: set to anything or empty string to hide
            cmdline = {
              pattern = "^:",
              icon = "",
              lang = "vim",
              view = "cmdline_popup",
              kind = "",
            },
            search_down = {
              kind = "search",
              pattern = "^/",
              icon = " ",
              lang = "regex",
              view = "cmdline_popup",
            },
            search_up = {
              kind = "search",
              pattern = "^%?",
              icon = " ",
              lang = "regex",
              view = "cmdline_popup",
            },
            filter = {
              pattern = "^:%s*!",
              icon = "$",
              lang = "bash",
              view = "cmdline_popup",
              kind = "",
            },
            lua = {
              pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
              icon = " ",
              lang = "lua",
              view = "cmdline_popup",
              kind = "",
            },
            help = {
              pattern = "^:%s*he?l?p?%s+",
              icon = "󰘥 ",
              view = "cmdline_popup",
              kind = "",
            },
            input = {
              view = "cmdline_popup",
              kind = "",
            }, -- Used by input()
            -- lua = false, -- to disable a format, set to `false`
          },
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          progress = { enabled = false },
        },
        messages = {
          -- NOTE: If you enable messages, then the cmdline is enabled automatically.
          -- This is a current Neovim limitation.
          enabled = true, -- enables the Noice messages UI
          view = "mini", -- default view for messages
          view_error = "notify", -- view for errors
          -- view_warn = "mini", -- view for warnings
          view_history = "messages", -- view for :messages
          view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        },
        popupmenu = {
          enabled = true, -- enables the Noice popupmenu UI
          ---@type 'nui'|'cmp'
          backend = "nui", -- backend to use to show regular cmdline completions
          ---@type NoicePopupmenuItemKind|false
          -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
          kind_icons = {}, -- set to `false` to disable icons
        },
        redirect = {
          view = "popup",
          filter = { event = "msg_show" },
        },
        commands = {
          history = {
            -- options for the message history that you get with `:Noice`
            view = "split",
            opts = { enter = true, format = "details" },
            filter = {
              -- any = {
              --   { event = "notify" },
              --   { error = true },
              --   { warning = true },
              --   { event = "msg_show", kind = { "" } },
              --   { event = "lsp", kind = "message" },
              -- },
            },
            filter_opts = { reverse = true },
          },
          -- :Noice last
          last = {
            view = "popup",
            opts = { enter = true, format = "details" },
            filter = {
              any = {
                { event = "notify" },
                { error = true },
                { warning = true },
                { event = "msg_show", kind = { "" } },
                { event = "lsp", kind = "message" },
              },
            },
            filter_opts = { count = 1 },
          },
          -- :Noice errors
          errors = {
            -- options for the message history that you get with `:Noice`
            view = "popup",
            opts = { enter = true, format = "details" },
            filter = { error = true },
            filter_opts = { reverse = true },
          },
        },
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          -- command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = utils.is_available "inc-rename.nvim", -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        routes = {
          {
            filter = { event = "msg_show", kind = "", find = "lines" },
            opts = { skip = true },
          },
          {
            filter = { event = "lsp", kind = "progress", find = "Diagnosing" },
            opts = { skip = true },
          },
          {
            filter = { event = "lsp", find = "diagnostics" },
            opts = { skip = true },
          },
          --   {
          --     filter = {
          --       event = "msg_show",
          --       kind = "",
          --       find = "written",
          --     },
          --     opts = { skip = true },
          --   },
        },
        views = {
          mini = {
            timeout = 5000,
          },
          cmdline_popup = {
            position = {
              row = 10, -- 5
              col = "50%",
            },
            size = {
              width = "66%",
              height = "auto",
            },
          },
          popupmenu = {
            relative = "editor",
            position = {
              row = 13, -- 8
              col = "50%",
            },
            size = {
              width = "66%",
              height = 10,
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
          },
        },
      })
    end,
    init = function() vim.g.lsp_handlers_enabled = false end,
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      if not opts.bottom then opts.bottom = {} end
      table.insert(opts.bottom, {
        ft = "noice",
        size = { height = 0.4 },
        filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == "" end,
      })
    end,
  },
  {
    "catppuccin/nvim",
    optional = true,
    opts = { integrations = { noice = true } },
  },
}
