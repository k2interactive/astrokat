local M = {}

local utils = require "heirline.utils"
local tools = require "user.tools"
local status = require "astronvim.utils.status"
local colors = require "user.plugins.heirline.colors"
local get_hl = require("heirline.utils").get_highlight

function M.fuzzy_time()
  return {
    {
      provider = tools.icons.powerline.left_rounded,
      hl = {
        fg = colors.segment1,
      },
    },
    {
      provider = function(self)
        self.time = tools.FuzzyTime()
        return self.time
      end,
      init = function(self)
        self.mode = vim.fn.mode(1)
        self.time = ""
      end,
      hl = {
        -- fg = colors.light_text,
        fg = get_hl("keyword").fg,
        bg = colors.segment1,
      },
      update = function(self) return tools.FuzzyTime() ~= self.time end,
    },
  }
end

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self) return self.icon and (self.icon .. " ") end,
  hl = function(self)
    if self.is_active and self.is_visible then
      return "TabLineSel"
    elseif self.is_visible then
      return "TabLine"
    else
      return "TabLineFill"
    end
  end,
}

-- local TablineBufnr = {
--   provider = function(self) return tostring(self.bufnr) .. ". " end,
--   hl = "Comment",
-- }

local TablinePicker = {
  condition = function(self) return self._show_picker end,
  init = function(self)
    local bufname = vim.api.nvim_buf_get_name(self.bufnr)
    bufname = vim.fn.fnamemodify(bufname, ":t")
    local label = bufname:sub(1, 1)
    local i = 2
    while self._picker_labels[label] do
      if i > #bufname then break end
      label = bufname:sub(i, i)
      i = i + 1
    end
    self._picker_labels[label] = self.bufnr
    self.label = label
  end,
  provider = function(self) return self.label end,
  hl = { fg = "red", bold = true },
}

local TablineFileName = {
  status.component.file_info {
    unique_path = {},
    file_icon = false,
    surround = false,
    hl = function(self)
      if self.is_visible and self.is_active then
        local h = get_hl "TabLineSel"
        return {
          bold = true,
          italic = false,
          bg = h.bg,
          fg = h.fg,
        }
      elseif self.is_visible then
        return { bold = true, italic = false }
      else
        return { bold = false, italic = true }
      end
    end,
  },
}

-- this looks poxactly like the FileFlags component that we saw in
-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
-- also, we are adding a nice icon for terminal buffers.
local TablineFileFlags = {
  {
    condition = function(self) return vim.api.nvim_buf_get_option(self.bufnr, "modified") end,
    provider = tools.icons.circle_small,
    -- hl = {
    --   fg = utils.get_highlight("CursorColumn").bg,
    --   bg = utils.get_highlight("CursorColumn").fg,
    -- },
    hl = function(self)
      if self.is_visible and self.is_active then
        return { bold = true, italic = true }
      elseif self.is_visible then
        return { bold = true, italic = true }
      else
        return { bold = false, italic = false }
      end
    end,
  },
  {
    condition = function(self)
      return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
        or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
    end,
    provider = function(self)
      if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
        return "  "
      else
        return "  "
      end
    end,
    hl = function(self)
      if self.is_visible and self.is_active then
        return { bold = true, italic = true }
      elseif self.is_visible then
        return { bold = true, italic = true }
      else
        return { bold = false, italic = false }
      end
    end, -- hl = { fg = utils.get_highlight("CursorColumn").bg },
  },
}

-- Here the filename block finally comes together
local TablineFileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    -- self.filename = provider.unique_path(self)
  end,
  hl = function(self)
    if self.is_active and self.is_visible then
      return "TabLineSel"
    elseif self.is_visible then
      return "TabLine"
    else
      return "TabLineFill"
    end
  end,
  on_click = {
    callback = function(_, minwid, _, button)
      if button == "m" then -- close on mouse middle click
        vim.schedule(function() vim.api.nvim_buf_delete(minwid, { force = false }) end)
      else
        vim.api.nvim_win_set_buf(0, minwid)
      end
    end,
    minwid = function(self) return self.bufnr end,
    name = "heirline_tabline_buffer_callback",
  },
  -- TablineBufnr,
  FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
  TablineFileName,
  TablineFileFlags,
}

-- a nice "x" button to close the buffer
local TablineCloseButton = {
  condition = function(self)
    return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
      -- or vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
      and not vim.api.nvim_buf_get_option(self.bufnr, "readonly")
  end,
  { provider = " " },
  {
    provider = tools.icons.Close,
    hl = function(self)
      if self.is_active and self.is_visible then
        return "TabLineSel"
      elseif self.is_visible then
        return "TabLine"
      else
        return "TabLineFill"
      end
    end, -- hl = { fg = utils.get_highlight("CursorColumn").bg },
    on_click = {
      callback = function(_, minwid)
        vim.schedule(function()
          vim.api.nvim_buf_delete(minwid, { force = false })
          vim.cmd.redrawtabline()
        end)
      end,
      minwid = function(self) return self.bufnr end,
      name = "heirline_tabline_close_buffer_callback",
    },
  },
}

-- The final touch!
local TablineBufferBlock = utils.surround(
  { tools.icons.powerline.left_rounded, tools.icons.powerline.right_rounded },
  function(self)
    if self.is_active and self.is_visible then
      return utils.get_highlight("TabLineSel").bg
    elseif self.is_visible then
      return utils.get_highlight("TabLine").bg
    else
      -- return utils.get_highlight("NotifyBackground").bg
      return utils.get_highlight("NotifyBackground").bg
    end
  end,
  { TablinePicker, TablineFileNameBlock, TablineCloseButton }
)

-- and here we go
M.Tabline = utils.make_buflist(
  TablineBufferBlock,
  { provider = " ", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
  { provider = " ", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
  -- by the way, open a lot of buffers and try clicking them ;)
)

M.Tablist = { -- tab list
  condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
  status.heirline.make_tablist { -- component for each tab
    provider = status.provider.tabnr(),
    hl = function(self) return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true) end,
  },
  { -- close button for current tab
    provider = status.provider.close_button { kind = "TabClose", padding = { left = 1, right = 1 } },
    hl = status.hl.get_attributes("tab_close", true),
    on_click = {
      callback = function() require("astronvim.utils.buffer").close_tab() end,
      name = "heirline_tabline_close_tab_callback",
    },
  },
}

return M
