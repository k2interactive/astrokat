return {
  "levouh/tint.nvim",
  event = "User AstroFile",
  opts = {
    highlight_ignore_patterns = { "WinSeparator", "neo-tree", "Status.*", "VertSplit" },
    tint = -45, -- Darken colors, use a positive value to brighten
    saturation = 0.4, -- Saturation to preserve
  },
}
