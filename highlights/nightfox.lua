return { -- a table of overrides/changes to the duskfox theme
  Number = { fg = "#22eeaa", bold = true },
  CursorLine = { underline = true, sp = "#8d69e5" },
  ["@field"] = { fg = "#b8a0ef", bold = false },
  ["@keyword.function"] = { fg = "#a055dc", italic = true },
  ["@keyword.return"] = { fg = "#c95e80", italic = true },
  ["@variable"] = { fg = "#cccccc", bold = true },

  NeoTreeCursorLine = { bold = true, underline = true, sp = "#8d69e5" },

  DiffAdd = { fg = "#3344ff", bg = "#000000" }, -- diffview-nvim - <<<<<<, HEAD, and simalar
  DiffDelete = { fg = "#ee0000", bg = "#000000" }, -- diffview-nvim - Deleted Chars
  DiffChange = { fg = "#00ff00", bg = "#000000" }, -- diffview-nvim - Changed chars

  diffAdded = { fg = "#dddddd", bg = "#1122cc" }, -- for neovim-undotree
  diffChanged = { fg = "#dddddd", bg = "#00aa00" }, -- for neovim-undotree
  diffRemoved = { fg = "#dddddd", bg = "#bb0000" }, -- for neovim-undotree

  DiagnosticSignError = { fg = "#605560" },

  HighlightUndo = { fg = "#dddddd", bg = "#ee0000" },
  HighlightRedo = { fg = "#dddddd", bg = "#00bb00" },
  TabLineSel = { bg = "#9d79f5", fg = "#000000" },
  TabLine = { bg = "#64449a", fg = "#111111" },
  TabLineFill = { bg = "#000000", fg = "#7454aa" },
  MoreMsg = { fg = "#9d79f5" },

  LspReferenceRead = { underline = true },
  LspReferenceWrite = { underline = true },
  LspReferenceText = { underline = true },

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
