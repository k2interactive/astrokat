local M = {}

local get_hl = require("heirline.utils").get_highlight

function M.toggle_window_auto_resize()
  if vim.g.window_size_enable_auto_true then
    vim.cmd "WindowsDisableAutowidth"
    vim.g.window_size_enable_auto_true = false
    vim.notify("Window auto resizing off", vim.log.levels.INFO)
  else
    vim.cmd "WindowsEnableAutowidth"
    vim.g.window_size_enable_auto_true = true
    vim.notify("Window auto resizing on", vim.log.levels.INFO)
  end
end

function M.toggle_diffview()
  local lib = require "diffview.lib"
  local view = lib.get_current_view()

  if view then
    -- Diffview present
    vim.cmd "DiffviewClose"
    if vim.g.window_size_enable_auto_true then vim.cmd "WindowsEnableAutowidth" end
  else
    vim.cmd "WindowsDisableAutowidth"
    vim.cmd "DiffviewOpen"
  end
end

M.icons = {
  Close = " ",

  Error = " ",
  Warn = " ",
  Warn2 = " ",
  Hint = " ",
  Hint2 = "󰌵 ",
  Info = " ",

  git = {
    GitBranch = "",
    GitAdd = "",
    GitChange = "",
    GitDelete = "",
  },
  powerline = {
    -- 
    vertical_bar_thin = "│",
    vertical_bar = "┃",
    block = "█",
    ----------------------------------------------
    left = "",
    left_filled = "",
    right = "",
    right_filled = "",
    ----------------------------------------------
    slant_left = "",
    slant_left_thin = "",
    slant_right = "",
    slant_right_thin = "",
    ----------------------------------------------
    slant_left_2 = "",
    slant_left_2_thin = "",
    slant_right_2 = "",
    slant_right_2_thin = "",
    ----------------------------------------------
    left_rounded = "",
    left_rounded_thin = "",
    right_rounded = "",
    right_rounded_thin = "",
    ----------------------------------------------
    trapezoid_left = "",
    trapezoid_right = "",
    ----------------------------------------------
    fade_left = "░▒▓",
    fade_right = "▓▒░",
    ----------------------------------------------
    line_number = "",
    column_number = "",
  },
  padlock = "",
  circle_small = " ● ", -- ●
  circle = "", -- 
  circle_plus = "", -- 
  dot_circle_o = "", -- 
  circle_o = "⭘", -- ⭘
  ScrollText = "",
  VimIcon = " ",
  PathSeparator = "",

  Moon1 = " ",
  Moon2 = "",

  lunar = [[
  0xe38d:        0xe393:        0xe399:        0xe39f:        0xe3a5: 
  0xe38e:        0xe394:        0xe39a:        0xe3a0:        0xe3a6: 
  0xe38f:        0xe395:        0xe39b:        0xe3a1:        0xe3a7: 
  0xe390:        0xe396:        0xe39c:        0xe3a2:        0xe3a8: 
  0xe391:        0xe397:        0xe39d:        0xe3a3:        0xe3a9: 
  0xe392:        0xe398:        0xe39e:        0xe3a4:        0xe3aa: 
  0xe3c8:        0xe3ce:        0xe3d4:        0xe3da:        0xe3e0: 
  0xe3c9:        0xe3cf:        0xe3d5:        0xe3db:        0xe3e1: 
  0xe3ca:        0xe3d0:        0xe3d6:        0xe3dc:        0xe3e2: 
  0xe3cb:        0xe3d1:        0xe3d7:        0xe3dd: 
  0xe3cc:        0xe3d2:        0xe3d8:        0xe3de: 
  0xe3cd:        0xe3d3:        0xe3d9:        0xe3df: 
  ]],

  clocks = {
    midnight = "󱑊 ",
    one = "󱐿 ",
    two = "󱑀 ",
    three = "󱑁 ",
    four = "󱑂 ",
    five = "󱑃 ",
    six = "󱑄 ",
    seven = "󱑑 ",
    eight = "󱑒 ",
    nine = "󱑎 ",
    ten = "󱑔 ",
    eleven = "󱑕 ",
    tweleve = "󱑖 ",
    thirteen = "󱑋 ",
    fourteen = "󱑌 ",
    fifteen = "󱑍 ",
    sixteen = "󱑎 ",
    seventeen = "󱑏 ",
    eighteen = "󱑐 ",
    nineteen = "󱑅 ",
    twenty = "󱑆 ",
    twentyOne = "󱑇 ",
    twentyTwo = "󱑈 ",
    twentyThree = "󱑉 ",
  },

  circles = {
    quarter = "◔",
    half = "◑",
    three_quarter = "◕",
    full = "◉",
  },

  lsp = {
    css = " ",
    dart = " ",
    eslint = "󰱺 ",
    html = " ",
    javascript = "󰬷 ",
    flutter = "󱗆 ",
    lua = " ",
    null_ls = " ",
    python = " ",
    swift = " ",
    typescript = " ",
  },
}

M.lsp_groups = {
  dartls = M.icons.lsp.dart,
  eslint = M.icons.lsp.eslint,
  lua_ls = M.icons.lsp.lua,
  tsserver = M.icons.lsp.typescript,
  stylua = M.icons.lsp.lua,
  pyright = M.icons.lsp.python,
  ["null-ls"] = M.icons.lsp.null_ls,
}

M.vi_mode_config = {
  -- mode_names = M.mode,
  mode_names = setmetatable({ -- change the strings if you like it vvvvverbose!
    n = "N",
    no = "N?",
    nov = "N?",
    noV = "N?",
    ["no\22"] = "N?",
    niI = "Ni",
    niR = "Nr",
    niV = "Nv",
    nt = "Nt",
    v = "V",
    vs = "V-Lines",
    V = "V-Line",
    Vs = "V-Lines",
    ["\22"] = "V-Block",
    ["\22s"] = "V-Blocks",
    s = "S",
    S = "S_",
    ["\19"] = "^S",
    i = "I",
    ic = "Ic",
    ix = "Ix",
    R = "R",
    Rc = "Rc",
    Rx = "Rx",
    Rv = "Rv",
    Rvc = "Rv",
    Rvx = "Rv",
    c = "C",
    cv = "Ex",
    r = "...",
    rm = "M",
    ["r?"] = "?",
    ["!"] = "!",
    t = "T",
  }, {
    __call = function(self, raw_mode) return self[raw_mode] end,
  }),
  mode_colors_bg = {
    n = get_hl("Keyword").fg, --       "red",
    i = get_hl("CursorLineNr").fg, --       "green",
    v = get_hl("CursorLine").bg, --      "cyan",
    V = get_hl("CursorLine").bg, --      "cyan",
    ["\22"] = get_hl("CursorLine").bg, -- "cyan",
    c = "black",
    s = "purple",
    S = "purple",
    ["\19"] = "purple",
    R = "orange",
    r = "orange",
    ["!"] = "red",
    t = "black",
  },
  mode_colors_fg = {
    n = "black", --        "red",
    i = "black", --       "green",
    v = get_hl("CursorLineNr").fg, --        "cyan",
    V = get_hl("CursorLineNr").fg, --       "cyan",
    ["\22"] = get_hl("CursorLineNr").fg, --  "cyan",
    c = "#00ff00", --        "orange",
    s = "black", --       "purple",
    S = "black", --       "purple",
    ["\19"] = "black", -- "purple",
    R = "black", --       "orange",
    r = "black", --       "orange",
    ["!"] = "black", --   "red",
    t = "#00ff00", --       "red",
  },
}

M.path = {
  home = function(path) return vim.fn.fnamemodify(path, ":~") end,
  home_s = function(path) return vim.fn.pathshorten(vim.fn.fnamemodify(path, ":~"), 3) end,
  relative = function(path) return vim.fn.fnamemodify(path, ":.") end,
  relative_s = function(path) return vim.fn.pathshorten(vim.fn.fnamemodify(path, ":."), 3) end,
  filename = function(path) return vim.fn.fnamemodify(path, ":t") end,
  short = function(path) return vim.fn.pathshorten(path, 3) end,
}

function M.toggle_comment_on_nl()
  local fopts = vim.opt.formatoptions:get()
  if fopts["c"] ~= nil then
    vim.notify("Comment on New Line Disabled", vim.log.levels.INFO)
    vim.opt.formatoptions:remove { "c", "r", "o" }
  else
    vim.notify("Comment on New Line Enabled", vim.log.levels.INFO)
    vim.opt.formatoptions:append { c = true, r = true, o = true }
  end
end

function M.FuzzyTime()
  local hour = tonumber(os.date "%H")
  local min = tonumber(os.date "%M")

  local hour_str = tostring(hour)
  if hour < 10 then hour_str = "0" .. hour_str end

  if min >= 7 and min < 23 then
    return hour_str .. ":" .. M.icons.circles.quarter
  elseif min >= 23 and min < 38 then
    return hour_str .. ":" .. M.icons.circles.half
  elseif min >= 38 and min < 52 then
    return hour_str .. ":" .. M.icons.circles.three_quarter
  else
    if min > 50 then
      if hour == 24 then
        hour = 0
      else
        hour = hour + 1
      end
    end

    hour_str = tostring(hour)
    if hour < 10 then hour_str = "0" .. hour_str end

    return hour_str .. ":" .. M.icons.circles.full
  end
end

return M
