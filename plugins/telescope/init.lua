return {
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
    return {
      extensions = {
        hop = require "user.plugins.telescope.hop",
        undo = require "user.plugins.telescope.undo",
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
      require("telescope").load_extension "undo",
      -- -- needs to be called in user/init/polish
      -- require("telescope").load_extension "hop",
    }
  end,
  config = require "plugins.configs.telescope",
}
