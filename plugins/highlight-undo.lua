return {
  {
    "tzachar/highlight-undo.nvim",
    event = "VeryLazy",
    opts = {
      duration = 500,
      undo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "u",
        map = "undo",
        opts = {},
      },
      redo = {
        hlgroup = "HighlightRedo",
        mode = "n",
        lhs = "<A-u>",
        map = "redo",
        opts = {},
      },
    },
  },
}
