local M = {}

local colors = require "user.plugins.heirline.colors"
local colors_fallback = require("astronvim.utils.status.env").fallback_colors
local comp = require "astronvim.utils.status.component"
local conditions = require "heirline.conditions"
local provider = require "astronvim.utils.status.provider"
local get_hl = require("heirline.utils").get_highlight
local status = require "astronvim.utils.status"
local tools = require "user.tools"
local icons = tools.icons
local path = tools.path

local priority = {
  CWD = 35,
  Diagnostics = 50,
  FileName = 60,
  FilePath = 40,
  Lsp = 35,
  Git = 20,
  Mode = 10,
  Navigation = 30,
}

local ViModeFull = {
  -- get vim current mode, this information will be required by the provider
  -- and the highlight functions, so we compute it only once per component
  -- evaluation and store it as a component attribute
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  -- To be extra meticulous, we can also add some vim statusline syntax to
  -- control the padding and make sure our string is always at least 2
  -- characters long. Plus a nice Icon.
  provider = function(self)
    return " " .. icons.VimIcon .. " %2(" .. tools.vi_mode_config.mode_names[self.mode] .. "%) "
  end,
  -- Same goes for the highlight. Now the foreground will change according to the current mode.
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return {
      fg = tools.vi_mode_config.mode_colors_fg[mode],
      bg = tools.vi_mode_config.mode_colors_bg[mode],
      bold = true,
    }
  end,
  -- Re-evaluate the component only on ModeChanged event!
  -- Also allows the statusline to be re-evaluated when entering operator-pending mode
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd "redrawstatus"
      vim.cmd "redrawtabline"
    end),
  },
}

function M.vi_mode_inverse_colors(text, bg)
  return {
    init = function(self) self.mode = vim.fn.mode(1) end,
    provider = text,
    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return {
        bg = bg,
        fg = tools.vi_mode_config.mode_colors_bg[mode],
      }
    end,
    update = {
      "ModeChanged",
      pattern = "*:*",
      callback = vim.schedule_wrap(function()
        vim.cmd "redrawstatus"
        vim.cmd "redrawtabline"
      end),
    },
  }
end

function M.tabline_mode_l()
  return {
    M.vi_mode_small(" " .. icons.Moon2),
    M.vi_mode_inverse_colors(icons.powerline.block .. icons.powerline.right_rounded .. " "),
  }
end

function M.tabline_mode_r()
  return {
    M.vi_mode_inverse_colors(" " .. icons.powerline.left_rounded .. icons.powerline.block, colors.segment1),
    M.vi_mode_small(icons.Moon1 .. " "),
  }
end

function M.k2color_text(opts)
  return {
    provider = opts.text,
    hl = {
      fg = opts.fg,
      bg = opts.bg,
    },
  }
end

function M.vi_mode_small(text)
  return {
    {
      init = function(self) self.mode = vim.fn.mode(1) end,
      provider = text,
      hl = function(self)
        local mode = self.mode:sub(1, 1)
        return {
          fg = tools.vi_mode_config.mode_colors_fg[mode],
          bg = tools.vi_mode_config.mode_colors_bg[mode],
        }
      end,
      update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
          vim.cmd "redrawstatus"
          vim.cmd "redrawtabline"
        end),
      },
    },
  }
end

function M.k2mode_l()
  return {
    flexible = priority.Mode,
    {
      ViModeFull,
      M.vi_mode_inverse_colors(" ", colors.segment2),
    },
    {
      M.vi_mode_inverse_colors " ",
    },
  }
end

function M.k2git()
  return {
    flexible = priority.Git,
    {
      comp.git_branch {
        hl = { bold = false, bg = colors.segment2, fg = colors.light_text },
        surround = false,
      },
      comp.git_diff {
        added = { hl = { fg = colors.light_text } },
        changed = { hl = { fg = colors.light_text } },
        removed = { hl = { fg = colors.light_text } },
        hl = { bold = false, bg = colors.segment2, fg = colors.light_text },
        surround = false,
      },
      M.k2color_text {
        text = icons.powerline.right_rounded .. " ",
        fg = colors.segment2,
        bg = get_hl("StatusLine").bg,
      },
    },
    {
      comp.git_diff {
        hl = { bold = false, bg = colors.segment2, fg = colors.light_text },
        surround = false,
      },
      M.k2color_text {
        text = icons.powerline.right_rounded .. " ",
        fg = colors.segment2,
        bg = get_hl("StatusLine").bg,
      },
    },
    {
      M.k2color_text {
        text = icons.powerline.right_rounded .. " ",
        fg = colors.segment2,
        bg = get_hl("StatusLine").bg,
      },
    },
  }
end

local function subPath(pathStr)
  if pathStr == "" then return end

  return vim.fn.substitute(pathStr, "/", icons.PathSeparator, "g") .. " "
end

function M.k2file_path()
  return {
    flexible = priority.FilePath,
    {
      provider = function()
        local cwd = vim.api.nvim_buf_get_name(0)
        return subPath(path.relative(cwd))
      end,
      hl = function() return {} end,
    },
    {
      provider = function()
        local cwd = vim.api.nvim_buf_get_name(0)
        return subPath(path.relative_s(cwd))
      end,
      hl = function() return {} end,
    },
    {
      provider = function()
        local cwd = vim.api.nvim_buf_get_name(0)
        return subPath(path.filename(cwd))
      end,
      hl = function() return {} end,
    },
  }
end

function M.k2file_info()
  return status.component.file_info {
    file_icon = {},
    filename = {},
    file_modified = {},
  }
end

function M.k2cwd()
  return {
    flexible = priority.CWD,
    {
      M.k2color_text {
        text = icons.powerline.left_rounded,
        fg = colors.segment2,
        bg = colors.segment3,
      },
      {
        provider = function()
          local icon = icons.Folder2
          local cwd = vim.fn.getcwd(0)
          cwd = vim.fn.fnamemodify(cwd, ":~:t")
          if not conditions.width_percent_below(#cwd, 0.25) then cwd = vim.fn.pathshorten(cwd) end
          return icon .. cwd
        end,
        hl = { bg = colors.segment2, fg = colors.mid_text },
      },
    },
    {
      M.k2color_text {
        text = icons.powerline.left_rounded,
        fg = colors.segment2,
        bg = colors.segment3,
      },
    },
  }
end

local function navBuilder(format_str)
  return status.component.builder {
    {
      init = function(self) self.mode = vim.fn.mode(1) end,

      -- provider = "%5(%l/%L%):%-3(%c%)",
      provider = format_str,

      -- hl = function(self)
      --   local mode = self.mode:sub(1, 1)
      --   return {
      --     fg = vi_mode_config.mode_colors_fg[mode],
      --     bg = vi_mode_config.mode_colors_bg[mode],
      --     bold = true,
      --     italic = true,
      --   }
      -- end,
      hl = {
        italic = true,
        bg = colors.segment2,
        fg = colors.light_text,
      },
      update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function() vim.cmd "redrawstatus" end),
      },
    },
  }
end

local function pos_visual()
  return {
    static = {
      -- sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
      sbar = { "█", "▇", "▆", "▅", "▄", "▃", "▂", "▁", " " },
    },
    provider = function(self)
      local curr_line = vim.api.nvim_win_get_cursor(0)[1]
      local lines = vim.api.nvim_buf_line_count(0)
      local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
      return string.rep(self.sbar[i], 2)
    end,
    -- hl = { fg = colors.bright_purple, bg = colors.dark_bg, },
    hl = { bg = get_hl("Keyword").fg, fg = colors_fallback.dark_bg },
  }
end

function M.k2navigation()
  return {
    flexible = priority.Navigation,
    {
      -- vi_mode_inverse_colors(" ", colors.segment2),
      M.k2color_text {
        text = icons.powerline.left_rounded,
        fg = colors.segment2,
        bg = get_hl("StatusLine").bg,
      },
      navBuilder "%5(%l/%L%):%-3(%c%)",
      pos_visual(),
    },
    {
      M.k2color_text { text = " ", fg = colors.segment2 },
      navBuilder "%1(%l%):%-2(%c%)",
      pos_visual(),
    },
    {
      M.k2color_text { text = " ", fg = colors.segment2 },
      navBuilder "%1(%l%):%-2(%c%)",
    },
  }
end

function M.k2mode_r()
  return {
    M.vi_mode_inverse_colors(" ", colors.segment2),
    M.vi_mode_small(icons.VimIcon .. " "),
  }
end

function M.k2_extra_indicators()
  return {
    { provider = provider.spell { str = "  " } },
  }
end

return M
