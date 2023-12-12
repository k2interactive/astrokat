local get_hl = require("heirline.utils").get_highlight

return { -- a table of overrides/changes to the duskfox theme
  -- Normal = { bg = "#100510" },
  Normal = { bg = "NONE" },
  Comment = { fg = "#605560", italic = true },
  DiffRemove = { bg = "#6F3254" },
  NotifyBackground = { bg = "#0b081d" },
  HopNextKey = { fg = "#00ff00" },
  HopNextKey1 = { fg = "#00ff00" },
  HopNextKey2 = { fg = "#00ff00" },
  Visual = { fg = "#dddddd", bg = "#004e53" },
  DiffAdd = { fg = "#3344ff", bg = "#000000" }, -- diffview-nvim - <<<<<<, HEAD, and simalar
  DiffDelete = { fg = "#ee0000", bg = "#000000" }, -- diffview-nvim - Deleted Chars
  DiffChange = { fg = "#00ff00", bg = "#000000" }, -- diffview-nvim - Changed chars
  diffAdded = { fg = "#ffffff", bg = "#1122cc" }, -- for neovim-undotree
  diffChanged = { fg = "#ffffff", bg = "#00ee00" }, -- for neovim-undotree
  diffRemoved = { fg = "#ffffff", bg = "#cc0000" }, -- for neovim-undotree
  -- Folded = { fg = "#241324", bg = "#050511" },
  Folded = { fg = "#00ff00", bg = "#110011" },
  -- DiagnosticSignInactive = { fg = "#504550" },
  DiagnosticSignInactive = { fg = "#000000" },
  VertSplit = { fg = "#ffffff", bg = "#000000" },

  HighlightUndo = { fg = "#dddddd", bg = "#ee0000" },
  HighlightRedo = { fg = "#dddddd", bg = "#0000ee" },

  StatuslineDarkText = { fg = "black" },
  StatuslineLightText = { fg = "#605560" },
  -- StatuslineSeed = get_hl "NotifyBackground",
  StatuslineSeed = { bg = "#00ff00" },
  -- StatuslineSegment1 = get_hl "NotifyBackground",
  StatuslineSegment1 = { bg = "#00ff00" },
  -- StatuslineSegment2 = get_hl "NotifyBackground",
  StatuslineSegment2 = { bg = "#00ff00" },
  StatuslineSegment3 = { bg = "#01071d" },

  TabLineSel = { bg = get_hl("Keyword").fg, fg = "#000000" },
  TabLine = { bg = "#64449a", fg = "#111111" },
  TabLineFill = { bg = get_hl("Keyword").bg, fg = "#7454aa" },
  MoreMsg = { fg = get_hl("Keyword").fg },

  -- ["LspReferenceText"] = { bg = "#0000ff" },
  -- ["LspReferenceRead"] = { bg = "#ff00ff" },
  -- ["LspReferenceWrite"] = { bg = "#0ff0ff" },

  LspReferenceRead = { underline = true },
  LspReferenceWrite = { underline = true },
  LspReferenceText = { underline = true },
}
