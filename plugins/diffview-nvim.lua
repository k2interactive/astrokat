return {
  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
    cmd = { "DiffviewOpen" },
  },
  {
    "NeogitOrg/neogit",
    optional = true,
    opts = {
      file_panel = {
        listing_style = "tree", -- One of 'list' or 'tree'
        tree_options = { -- Only applies when listing_style is 'tree'
          flatten_dirs = true, -- Flatten dirs that only contain one single dir
          folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
        },
        win_config = { -- See ':h diffview-config-win_config'
          position = "left",
          width = 35,
          win_opts = {},
        },
      },
    },
  },
}
