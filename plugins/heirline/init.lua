return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local comp = require "astronvim.utils.status.component"
    local custom = require "user.plugins.heirline.component"
    local diag = require "user.plugins.heirline.diagnostics"
    local tabline = require "user.plugins.heirline.tabline"
    local status = require "astronvim.utils.status"
    local tools = require "user.tools"
    local icons = tools.icons
    local sc = require "user.plugins.heirline.statuscolumn"
    local colors = require "user.plugins.heirline.colors"

    opts.opts = {
      disable_winbar_cb = function(args)
        return not require("astronvim.utils.buffer").is_valid(args.buf)
          or status.condition.buffer_matches({
            buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
            filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
          }, args.buf)
      end,
    }

    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      custom.k2mode_l(),
      custom.k2git(),
      custom.k2file_path(),
      comp.fill(),
      comp.cmd_info(),
      comp.fill(),
      diag.k2diag(),
      -- comp.lsp(),
      custom.k2navigation(),
      custom.k2mode_r(),
    }

    opts.winbar = { -- winbar
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      fallthrough = false,
      {
        status.component.breadcrumbs { hl = status.hl.get_attributes("winbar", true) },
        status.component.fill(),
        status.component.separated_path(),
        status.component.file_info {
          file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
          file_modified = false,
          file_read_only = false,
          hl = status.hl.get_attributes("winbarnc", true),
          surround = false,
          update = "BufEnter",
        },
      },
    }

    -- opts.tabline = false
    opts.tabline = {
      custom.ViModeSmall(" " .. icons.Moon2),
      custom.vi_mode_inverse_colors(icons.powerline.block .. icons.powerline.right_rounded .. " "),
      tabline.Tabline,
      comp.fill(),
      tabline.Tablist,
      tabline.fuzzy_time(),
      custom.vi_mode_inverse_colors(" " .. icons.powerline.left_rounded .. icons.powerline.block, colors.segment1),
      custom.ViModeSmall(icons.Moon1 .. " "),
    }

    opts.statuscolumn = vim.fn.has "nvim-0.9" == 1
        and {
          -- status.component.foldcolumn(),
          sc.foldcolumn(),
          status.component.fill(),
          status.component.numbercolumn(),
          status.component.signcolumn(),
        }
      or nil
    return opts
  end,
}
