local M = {}

function M.k2diag()
  local icons = require("user.tools").icons
  local get_hl = require("heirline.utils").get_highlight
  local colors = require "user.plugins.heirline.colors"

  return {
    static = {
      error_icon = icons.Error, -- vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
      warn_icon = icons.Warn, -- vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
      info_icon = icons.Info, -- vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
      hint_icon = icons.Hint, -- vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
      inactive_colors = {
        -- fg = get_hl("DiagnosticSignInactive").fg,
        fg = colors.light_text,
        bg = get_hl("TelescopeSelection").bg,
      },
    },

    init = function(self)
      self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    {
      provider = icons.powerline.left_rounded,
      hl = { fg = get_hl("TelescopeSelection").bg },
    },
    {
      provider = function(self) return (self.error_icon .. self.errors .. " ") end,
      hl = function(self)
        if self.errors == 0 then
          return self.inactive_colors
        else
          return {
            fg = get_hl("DiagnosticSignError").fg,
            bg = get_hl("TelescopeSelection").bg,
          }
        end
      end,
    },
    {
      provider = function(self) return (self.warn_icon .. self.warnings .. " ") end,
      hl = function(self)
        if self.warnings == 0 then
          return self.inactive_colors
        else
          return {
            fg = get_hl("DiagnosticSignWarn").fg,
            bg = get_hl("TelescopeSelection").bg,
          }
        end
      end,
    },
    {
      provider = function(self) return (self.info_icon .. self.info .. " ") end,
      hl = function(self)
        if self.info == 0 then
          return self.inactive_colors
        else
          return {
            fg = get_hl("DiagnosticSignInfo").fg,
            bg = get_hl("TelescopeSelection").bg,
          }
        end
      end,
    },
    {
      provider = function(self) return (self.hint_icon .. self.hints) end,
      hl = function(self)
        if self.hints == 0 then
          return self.inactive_colors
        else
          return {
            fg = get_hl("DiagnosticSignHint").fg,
            bg = get_hl("TelescopeSelection").bg,
          }
        end
      end,
    },
    {
      provider = icons.powerline.right_rounded,
      hl = { fg = get_hl("TelescopeSelection").bg },
    },
  }
end

return M
