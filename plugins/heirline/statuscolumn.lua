local M = {}

local status_utils = require "astronvim.utils.status.utils"
local condition = require "astronvim.utils.status.condition"
local provider = require "astronvim.utils.status.provider"
local utils = require "astronvim.utils"
local get_icon = utils.get_icon
local extend_tbl = utils.extend_tbl

function M.builder(opts)
  opts = extend_tbl({ padding = { left = 0, right = 0 } }, opts)
  local children = {}
  if opts.padding.left > 0 then -- add left padding
    table.insert(children, { provider = status_utils.pad_string(" ", { left = opts.padding.left - 1 }) })
  end
  for key, entry in pairs(opts) do
    if
      type(key) == "number"
      and type(entry) == "table"
      and provider[entry.provider]
      and (entry.opts == nil or type(entry.opts) == "table")
    then
      entry.provider = provider[entry.provider](entry.opts)
    end
    children[key] = entry
  end
  if opts.padding.right > 0 then -- add right padding
    table.insert(children, { provider = status_utils.pad_string(" ", { right = opts.padding.right - 1 }) })
  end
  return opts.surround
      and status_utils.surround(opts.surround.separator, opts.surround.color, children, opts.surround.condition)
    or children
end

function M.foldcolumn(opts)
  opts = extend_tbl({
    foldcolumn = { padding = { right = 1 } },
    condition = condition.foldcolumn_enabled,

    on_click = {
      name = "fold_click",

      callback = function(...)
        local char = status_utils.statuscolumn_clickargs(...).char
        local fillchars = vim.opt_local.fillchars:get()

        if char == (fillchars.foldopen or get_icon "FoldOpened") then
          vim.cmd "norm! zc"
        elseif char == (fillchars.foldcolse or get_icon "FoldClosed" or "") then
          vim.cmd "norm! zo"
        end
      end,
    },
  }, opts)
  return M.builder(status_utils.setup_providers(opts, { "foldcolumn" }))
end

return M
