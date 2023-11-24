local M = {}

local get_hl = require("heirline.utils").get_highlight
-- TODO: MARK: fixme magic colors please thank you!! ________________

-- M.dark_text = get_hl("StatuslineDarkText").fg
M.dark_text = "black"

-- M.light_text = get_hl("StatuslineLightText").fg
M.light_text = "#605560"

-- M.seed = get_hl("StatuslineSeed").bg
M.seed = "#00ff00"

-- M.segment1 = get_hl("StatuslineSegment1").bg
M.segment1 = "#383262"

-- M.segment2 = get_hl("StatuslineSegment2").bg
M.segment2 = "#0b081d"

-- M.segment3 = get_hl("StatuslineSegment3").bg
M.segment3 = "#01071d"

return M
