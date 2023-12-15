local tools = require "user.tools"
local icons = require("user.tools").icons
local hl = require("nightfox.palette").load "duskfox"
local conditions = require "heirline.conditions"
local priority = require("user.plugins.heirline.component").priority
-- local icons = require("user.tools").icons.lsp
local Space = setmetatable({ provider = " " }, {
  __call = function(_, n) return { provider = string.rep(" ", n) } end,
})

local M = {}

local LspIndicator = {
  provider = icons.circle_small .. " ",
  hl = hl.LspIndicator,
}

local LspServer = {
  Space,
  {
    provider = function(self)
      local names = self.lsp_names
      if #names == 1 then
        names = names[1]
      else
        -- names = table.concat(vim.tbl_flatten({ '[', names, ']' }), ' ')
        names = table.concat(names, " ")
      end
      return names
    end,
  },
  Space(2),
  hl = hl.LspServer,
}

M.Lsp = {
  condition = conditions.lsp_attached,
  init = function(self)
    local names = {}
    for _, server in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
      -- table.insert(names, server.name)
      if tools.lsp_groups[server.name] then
        table.insert(names, tools.lsp_groups[server.name])
      else
        table.insert(names, server.name)
      end
    end
    self.lsp_names = names
  end,
  hl = function(self)
    local color
    for _, name in ipairs(self.lsp_names) do
      -- if lsp_colors[name] then
      -- color = lsp_colors[name]
      color = hl.cyan.dim
      -- break
      -- end
    end
    if color then
      return { fg = color, bold = true, force = true }
    else
      return hl.LspServer
    end
  end,
  flexible = 35,

  LspServer,
  LspIndicator,
}
return M
