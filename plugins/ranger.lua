return {
  "kelly-lin/ranger.nvim",
  lazy = false,
  config = function()
    local ranger = require "ranger-nvim"
    ranger.setup {
      enable_cmds = false, -- usually set this way for safety, but you never know...
      replace_netrw = false,
      keybinds = {
        ["ov"] = ranger.OPEN_MODE.vsplit,
        ["oh"] = ranger.OPEN_MODE.split,
        ["ot"] = ranger.OPEN_MODE.tabedit,
        ["or"] = false, -- Note: Rifle does not seem to be a good idea yet ranger.OPEN_MODE.rifle,
      },
      ui = {
        border = "none",
        height = 1,
        width = 1,
        x = 0.5,
        y = 0.5,
      },
    }
  end,
}
