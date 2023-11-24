return {
  {
    "echasnovski/mini.indentscope",
    event = "User AstroFile",
    mappings = {
      -- Textobjects
      object_scope = "ii",
      object_scope_with_border = "ai",

      -- Motions (jump to respective border line; if not present - body line)
      goto_top = "[i",
      goto_bottom = "]i",
    },
    opts = {
      symbol = "│",
      draw = {
        -- Delay (in ms) between event and start of drawing scope indicator
        delay = 50,

        -- Animation rule for scope's first drawing. A function which, given
        -- next and total step numbers, returns wait time (in ms). See
        -- |MiniIndentscope.gen_animation| for builtin options. To disable
        -- animation, use `require('mini.indentscope').gen_animation.none()`.
        -- animation = --<function: implements constant 20ms between steps>,

        -- Symbol priority. Increase to display on top of more symbols.
        priority = 10000,
      },
      options = {
        -- Type of scope's border: which line(s) with smaller indent to
        -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
        border = "both",
        -- Whether to use cursor column when computing reference indent.
        -- Useful to see incremental scopes with horizontal cursor movements.
        indent_at_cursor = true,
        -- Whether to first check input line to be a border of adjacent scope.
        -- Use it if you want to place cursor on function header to get scope of
        -- its body.
        try_as_border = true,
      },
      mappings = {
        -- Textobjects
        object_scope = "ii",
        object_scope_with_border = "ai",

        -- Motions (jump to respective border line; if not present - body line)
        goto_top = "[i",
        goto_bottom = "]i",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          local excluded_filetypes = {
            "Trouble",
            "aerial",
            "alpha",
            "checkhealth",
            "dashboard",
            "fzf",
            "help",
            "lazy",
            "lspinfo",
            "man",
            "mason",
            "neo-tree",
            "notify",
            "null-ls-info",
            "starter",
            "toggleterm",
            "undotree",
          }
          local excluded_buftypes = {
            "nofile",
            "prompt",
            "quickfix",
            "terminal",
          }
          if
            vim.tbl_contains(excluded_filetypes, vim.bo["filetype"])
            or vim.tbl_contains(excluded_buftypes, vim.bo["buftype"])
          then
            vim.b.miniindentscope_disable = true
          end
        end,
      })
    end,
  },
  {
    "catppuccin/nvim",
    optional = true,
    opts = { integrations = { mini = true } },
  },
}
