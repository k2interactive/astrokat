return { -- a table of overrides/changes to the duskfox theme
  Normal = { bg = "NONE" },
  NotifyBackground = { bg = "#0b0a1d" },
  Comment = { fg = "#605560", italic = true },
  CursorLine = { bg = "#201040" },
  ColorColumn = { bg = "#0a071a" },
  LineNr = { fg = "#313a5d" },
  Visual = { bg = "#1d1b52" },
  Folded = { fg = "#241324", bg = "#050511" },
  VertSplit = { fg = "#775588", bg = "#482858" },
  HopNextKey = { fg = "#00ff00" },
  HopNextKey1 = { fg = "#00dd00" },
  HopNextKey2 = { fg = "#00bb00" },
  DiffAdd = { fg = "#3344ff", bg = "#000000" }, -- diffview-nvim - <<<<<<, HEAD, and simalar
  DiffDelete = { fg = "#ee0000", bg = "#000000" }, -- diffview-nvim - Deleted Chars
  DiffChange = { fg = "#00ff00", bg = "#000000" }, -- diffview-nvim - Changed chars
  diffAdded = { fg = "#dddddd", bg = "#1122cc" }, -- for neovim-undotree
  diffChanged = { fg = "#dddddd", bg = "#00aa00" }, -- for neovim-undotree
  diffRemoved = { fg = "#dddddd", bg = "#bb0000" }, -- for neovim-undotree
  DiagnosticSignError = { fg = "#605560" },
  DiagnosticSignWarn = { fg = "#605560" },
  DiagnosticSignInfo = { fg = "#605560" },
  DiagnosticSignHint = { fg = "#605560" },
  HighlightUndo = { fg = "#dddddd", bg = "#ee0000" },
  HighlightRedo = { fg = "#dddddd", bg = "#00bb00" },
  -- DiffRemove          = { fg = "#000000", bg = "#dddddd" }, -- },--6f3254" },--{ fg = spec.git.removed },-- Removed lines ("^-.*" | "^<.*")
  -- DiffText            = { fg = "#000000", bg = "#dddddd" }, -- ???
  -- DiffviewDim1        = { fg = "#000000", bg = "#dddddd" },
  -- DiffviewNonText     = { fg = "#000000", bg = "#dddddd" },
  -- UfoFoldedBg         = { fg = "#dddddd", bg = "#251a4b" }, -- Ironically only displays while block unfolds
  -- CursorLineFold      = { fg = "#000000", bg = "#000000" }, -- to the left of line numbers
  -- UfoFoldedElipsis    = { fg = "#000000", bg = "#000000" }, -- not sure what this does yet
  -- UfoFoldedFg         = { fg = "#000000", bg = "#000000" }, -- surround either side of the '{' when code is folded
  -- UfoCursorFoldedLine = { fg = "#000000", bg = "#000000" }, --not sure on these either :-(
}
