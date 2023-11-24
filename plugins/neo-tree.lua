return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.filesystem = {
        filtered_items = {
          visible = true,
        },
        follow_current_file = {
          enabled = true,
        },
      }
      opts.follow_current_file = {
        enabled = true,
      }
      opts.buffers = {
        follow_current_file = { enabled = true },
      }
      return opts
    end,
  },
}
