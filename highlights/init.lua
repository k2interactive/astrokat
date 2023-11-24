local get_hl = require("heirline.utils").get_highlight

return { -- this table overrides highlights in all themes
  StatuslineDarkText = { fg = "black" },
  StatuslineLightText = { fg = "#605560" },
  StatuslineSeed = { bg = "#33477d" },
  -- StatuslineSegment1 = get_hl "NotifyBackground",
  StatuslineSegment1 = { bg = "#0b081d" },
  StatuslineSegment2 = { bg = "#11275d" },
  StatuslineSegment3 = { bg = "#01071d" },
  DiagnosticSignInactive = { fg = "#000000" },
}
