return {
  "EdenEast/nightfox.nvim",
  opts = {
    options = {
      module_default = false,
      colorblind = {
        enable = true, -- enable colorblind support
        simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
        severity = {
          protan = 0.1, -- Severity [0,1] for protan (red)
          deutan = 0.1, -- Severity [0,1] for deutan (green)
          tritan = 0.5, -- Severity [0,1] for tritan (blue)
        },
      },
      styles = { -- Style to be applied to different syntax groups
        comments = "italic", -- Value is any valid attr-list value `:help attr-list`
        conditionals = "NONE",
        constants = "NONE",
        functions = "italic",
        keywords = "NONE",
        numbers = "NONE",
        operators = "bold",
        strings = "bold",
        types = "bold",
        variables = "NONE",
      },
      modules = {
        aerial = true,
        cmp = true,
        ["dap-ui"] = true,
        dashboard = true,
        diagnostic = true,
        gitsigns = true,
        native_lsp = true,
        neotree = true,
        notify = true,
        symbol_outline = true,
        telescope = true,
        treesitter = true,
        whichkey = true,
      },
    },
    groups = {
      all = {
        NormalFloat = { link = "Normal" },
        -- non-current windows
        -- NormalNC = { fg = "fg1", bg = "inactive" },
      },
    },
    specs = {
      all = {
        inactive = "bg0",
      },
      nightfox = {
        inactive = "#000000",
      },
    },
  },
}
