return {
  {
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
        "rust",
        "scala",
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
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    -- TSContextEnable, TSContextDisable, TSContextToggle
    -- hi Groups: TreesitterContext[....]
    config = function()
      require("treesitter-context").setup {
        enable = true,
        max_lines = 25,
        min_window_height = 5,
        line_numbers = true,
        multiline_threshold = 5, --20,
        trim_scope = "inner", -- also 'inner'. which lines to discard after max_lines
        mode = "topline", -- also 'topline', line used to calc context
        -- separator between context and content, should be single char like '-'
        -- when set,, context will only display when at least 2 lines above cursor
        separator = "󰇘", -- or nil
        zindex = 20,
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable detaching
      }
    end,
  },
}
