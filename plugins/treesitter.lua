return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
      "bash",
      "dart",
      "dockerfile",
      "fish",
      "git_config",
      "gitcommit",
      "gitignore",
      "html",
      "http",
      "java",
      "javascript",
      "jsdoc",
      "json",
      "kotlin",
      "lua",
      "luadoc",
      "php",
      "python",
      "sql",
      "swift",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "xml",
      "yaml",
    })
    opts.auto_install = true

    opts.incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        scope_incremental = "<TAB>",
        node_decremental = "S-Tab",
      },
    }
  end,
}
