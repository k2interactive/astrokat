return {
  -- get vim current mode, this information will be required by the provider
  -- and the highlight functions, so we compute it only once per component
  -- evaluation and store it as a component attribute
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  -- Now we define some dictionaries to map the output of mode() to the
  -- corresponding string and color. We can put these into `static` to compute
  -- them at initialisation time.
  static = {
    mode_names = { -- change the strings if you like it vvvvverbose!
      n = "Normal",
      no = "Op-Pending",
      nov = "Normal?",
      noV = "Normal?",
      ["no\22"] = "Normal?",
      niI = "Normali",
      niR = "Normalr",
      niV = "Normalv",
      nt = "Normalt",
      v = "Visual",
      vs = "Visuals",
      V = "Visual_",
      Vs = "Visuals",
      ["\22"] = "^Visual",
      ["\22s"] = "^Visual",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "Insert",
      ic = "Insertc",
      ix = "Insertx",
      R = "Replace",
      Rc = "Replacec",
      Rx = "Replacex",
      Rv = "Replacev",
      Rvc = "Replacev",
      Rvx = "Replacev",
      c = "Command",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
    },
    mode_colors = {
      n = "#444444", -- "black" ,
      i = "yellow",
      v = "cyan",
      V = "cyan",
      ["\22"] = "cyan",
      c = "orange",
      s = "purple",
      S = "purple",
      ["\19"] = "purple",
      R = "orange",
      r = "orange",
      ["!"] = "red",
      t = "red",
    },
    mode_colors_fg = {
      n = "white",
      i = "black",
      v = "black",
      V = "black",
      ["\22"] = "black",
      c = "white",
      s = "white",
      S = "white",
      ["\19"] = "white",
      R = "white",
      r = "white",
      ["!"] = "black",
      t = "black",
    },
  }, -- We can now access the value of mode() that, by now, would have been
  -- computed by `init()` and use it to index our strings dictionary.
  -- note how `static` fields become just regular attributes once the
  -- component is instantiated.
  -- To be extra meticulous, we can also add some vim statusline syntax to
  -- control the padding and make sure our string is always at least 2
  -- characters long. Plus a nice Icon.
  provider = function(self)
    -- vim.api
    return "  %2(" .. self.mode_names[self.mode] .. "%) "
  end,
  -- Same goes for the highlight. Now the foreground will change according to the current mode.
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = self.mode_colors_fg[mode], bg = self.mode_colors[mode], bold = true }
  end,
  -- Re-evaluate the component only on ModeChanged event!
  -- Also allows the statusline to be re-evaluated when entering operator-pending mode
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function() vim.cmd "redrawstatus" end),
  },
}
