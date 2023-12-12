return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        enabled = vim.fn.executable "make" == 1,
        build = "make",
        "jvgrootveld/telescope-zoxide",
      },
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-hop.nvim",
    },
    cmd = "Telescope",
    keys = {
      {
        "<leader>fu",
        "<cmd>Telescope undo<CR>",
        desc = "Find undos",
      },
    },
    opts = function()
      local actions = require "telescope.actions"
      local get_icon = require("astronvim.utils").get_icon
      require("telescope").load_extension "zoxide"

      vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopePreviewerLoaded",
        callback = function(args)
          -- vim.notify(args.data.filetype)
          -- vim.notify("moo", vim.log.levels.ERROR)
          -- if args.data.filetype ~= "help" then
          --   vim.wo.number = true
          -- elseif args.data.bufname:match "*.csv" then
          --   vim.wo.wrap = false
          -- end
        end,
      })

      return {
        extensions = {
          -- undo = require "user.plugins.telescope.undo",
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.66,
              preview_cutoff = 20,
            },
            diff_context_lines = 4,
          },
          hop = require "user.plugins.telescope.hop",
        },
        defaults = {
          git_worktrees = vim.g.git_worktrees,
          prompt_prefix = get_icon("Selected", 1),
          selection_caret = get_icon("Selected", 1),
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.5 },
            vertical = { mirror = false },
            width = 0.95,
            height = 0.95,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              -- IMPORTANT
              -- either hot-reloaded or `function(prompt_bufnr) telescope.extensions.hop.hop end`
              ["<C-h>"] = function(prompt_bufnr) require("telescope").extensions.hop.hop(prompt_bufnr) end, -- hop.hop_toggle_selection
              -- custom hop loop to multi selects and sending selected entries to quickfix list
              ["<C-space>"] = function(prompt_bufnr)
                local opts = {
                  callback = actions.toggle_selection,
                  loop_callback = actions.send_selected_to_qflist,
                }
                require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
              end,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          diagnostics = {
            theme = "dropdown",
            layout_config = {
              width = 0.95,
            },
          },
        },
        -- -- needs to be called in user/init/polish
        -- require("telescope").load_extension "hop",
      }
    end,
    -- config = require "plugins.configs.telescope",
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension "undo"
    end,
  },
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },
}
