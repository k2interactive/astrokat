return {
  {
    use_delta = true,
    layout_strategy = "vertical",
    layout_config = {
      preview_height = 0.95,
    },
    use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
    side_by_side = true,
    diff_context_lines = vim.o.scrolloff,
    entry_format = "state #$ID, $STAT, $TIME",
    time_format = "",
    mappings = {
      i = {
        ["<cr>"] = require("telescope-undo.actions").yank_additions,
        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
        ["<C-cr>"] = require("telescope-undo.actions").restore,
      },
    },
  },
}
