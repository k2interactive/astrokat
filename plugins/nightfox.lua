return {
  "EdenEast/nightfox.nvim",
  opts = {
    options = {
      dim_inactive = true,
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
        functions = "bold",
        keywords = "NONE",
        numbers = "NONE",
        operators = "bold",
        strings = "bold",
        types = "bold",
        variables = "NONE",
      },
      modules = {
        alpha = true,
        aerial = true,
        cmp = true,
        ["dap-ui"] = true,
        dashboard = true,
        diagnostic = true,
        gitsigns = true,
        hop = false,
        indent_blanklines = true,
        lazy_nvim = true,
        mini = true,
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
        HopNextKey = { fg = "#00ff00" },
        HopNextKey1 = { fg = "#00f400" },
        HopNextKey2 = { fg = "#00e800" },
        HopUnmatched = { fg = "#585060" },
      },
      nightfox = {
        Normal = { bg = "NONE" },
        NotifyBackground = { bg = "#0b0a1d" },
        NormalNC = { bg = "#05000b" },
        Comment = { fg = "#585060" },
        Function = { fg = "#aa2233" },
        WhichKeyFloat = { bg = "#050410" },
        NeoTreeNormal = { bg = "NONE" },
        String = { fg = "#c0c050" },
        ColorColumn = { bg = "#0a071a" },
        LineNr = { fg = "#313a5d" },
        Visual = { bg = "#1d1b52" },
        Folded = { fg = "#241324", bg = "#050511" },
        VertSplit = { fg = "#f0eeff", bg = "#280838" },
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
