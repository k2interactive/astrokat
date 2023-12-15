local is_available = require("astronvim.utils").is_available

-- mappings here will show in whichkey
return {
  n = {
    ["<leader>v"] = { name = " ENVironments" },
    ---------------------------------------------------------------------------
    -- disable Astro Defaults -------------------------------------------------
    ---------------------------------------------------------------------------

    ["<leader>pi"] = false,
    ["<leader>ps"] = false,
    ["<leader>pS"] = false,
    ["<leader>pu"] = false,
    ["<leader>pU"] = false,
    ["<leader>pa"] = false,
    ["<leader>pA"] = false,
    ["<leader>pv"] = false,
    ["<leader>pl"] = false,
    ["<leader>bn"] = false,
    ["<leader>bp"] = false,

    --
    -- MARK: PROJECT TEMP MAPPINGS

    -- PROJECT TEMP END

    ["<leader>u/"] = {
      function() require("user.tools").toggle_comment_on_nl() end,
      desc = "Toggle comment-on-new-line",
    },

    ---------------------------------------------------------------------------
    -- LSP/DAP ----------------------------------------------------------------
    ---------------------------------------------------------------------------

    --- From lsp/mappings.lua
    -- ["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },

    -- ["<leader>ld"] = {
    --   function() require("telescope.builtin").diagnostics { bufnr = 0 } end,
    --   noremap = true,
    --   desc = "Buffer diagnostics",
    -- },

    ["<leader>lH"] = { function() require("garbage-day.utils").stop_lsp() end, desc = "Garbage stop LSP" },
    ["<leader>lg"] = { function() require("garbage-day.utils").start_lsp() end, desc = "Garbage start LSP" },

    ---------------------------------------------------------------------------
    -- Astro Control ----------------------------------------------------------
    ---------------------------------------------------------------------------

    [";"] = { ":", desc = "Command Alt" },

    ["<leader>Q"] = { "<cmd>quitall<cr>", desc = "Quit All (preserves splits etc.)" },

    ["<leader>e"] = { ":Neotree toggle float<cr>", silent = true, desc = "Toggle Explorer" },
    ["<F4>"] = { function() require("ranger-nvim").open(true) end, noremap = true, desc = "Ranger rides again!" },
    ["<F5>"] = { function() require("luapad").toggle {} end, noremap = true, desc = "Toggle Luapad" },
    ["<leader>0"] = { ":Neotree toggle left<cr>", silent = true, desc = "Toggle Explorer" },
    ["<leader>o"] = { function() require("aerial").toggle() end, desc = "Symbols outline" },

    -- TODO: function exploration
    -- originally remap of explorer toggle
    -- ["<leader>0"] = {
    --   function()
    --     if vim.bo.filetype == "neo-tree" then
    --       vim.cmd.wincmd "p"
    --     else
    --       vim.cmd.Neotree "focus"
    --     end
    --   end,
    --   desc = "Toggle Explorer Focus",
    -- },

    ["<leader>fz"] = { "<cmd>Telescope zoxide list<CR>", silent = true, desc = "Find directories" },

    ---------------------------------------------------------------------------
    -- Project Control --------------------------------------------------------
    ---------------------------------------------------------------------------
    ["<leader>fp"] = { "<cmd>Telescope projects<cr>", silent = true, desc = "Search Projects.nvim" },

    ["<leader>fs"] = {
      function()
        if is_available "neovim-session-manager" then vim.cmd "SessionManager! load_session" end
      end,
      silent = true,
      desc = "Search Sessions",
    },

    ["<f3>"] = {
      function()
        if is_available "neovim-session-manager" then vim.cmd "SessionManager! load_last_session" end
        if is_available "resession.nvim" then require("resession").load "Last Session" end
      end,
      silent = true,
      desc = "Load last session",
    },

    ["<leader>gD"] = {
      function() require("user.tools").toggle_diffview() end,
      desc = "Open Diffview-Nvim",
      silent = true,
    },
    ["<leader>gg"] = { "<cmd>lua require'lazygit'.lazygit()<cr>", desc = "LazyGit", silent = true },

    ---------------------------------------------------------------------------
    -- UI & Visuals -----------------------------------------------------------
    ---------------------------------------------------------------------------

    --- Noice, Messaging & Logs ---
    -- TODO: Discuss messaging menu
    ["<leader>m"] = { name = " Messaging" },
    ["<leader>mr"] = { "<cmd>messages<cr>", silent = true, desc = "Raw Messages" },
    ["<leader>mp"] = { "<cmd>Noice<cr>", silent = true, desc = "Pretty Messages" },
    ["<leader>mh"] = { "<cmd>NoiceHistory<cr>", silent = true, desc = "Message History" },
    ["<leader>mL"] = { "<cmd>NoiceLog<cr>", silent = true, desc = "Message Log file" },
    ["<leader>ms"] = { "<cmd>NoiceStats<cr>", silent = true, desc = "Noice Stats" },
    ["<leader>mS"] = { "<cmd>NoiceViewstats<cr>", silent = true, desc = "Noice View Stats" },
    ["<leader>mD"] = { "<cmd>NoiceDebug<cr>", silent = true, desc = "Noice Debug" },
    ["<leader>mR"] = { "<cmd>NoiceRoutes<cr>", silent = true, desc = "Noice Routes" },
    ["<leader>ml"] = { "<cmd>NoiceLast<cr>", silent = true, desc = "Last Message" },
    ["<leader>me"] = { "<cmd>NoiceErrors<cr>", silent = true, desc = "Error Messages" },
    ["<leader>md"] = { "<cmd>Noice dismiss<cr>", silent = true, desc = "Dismiss Messages" },

    ["<leader>\\"] = { "<C-w>t<C-w>K", desc = "Flip to Horizontal" },
    ["<leader>|"] = { "<C-w>t<C-w>H", desc = "Flip to Vertical" },

    -- --------------------------------------
    -- From zen-mode.lua and twilight.lua --
    -- keys = { { "<C-z>", "<cmd>ZenMode<cr>", desc = "Toggle ZenMode" } },
    ["<F6>"] = { function() require("zen-mode").toggle {} end, silent = true, desc = "Toggle ZenMode" },
    -- keys = { { "<leader>uT", "<cmd>Twilight<cr>", desc = "Toggle Twilight" } },

    ["<leader>t"] = { name = "󰓩 Tab Control" },
    ["<leader>tc"] = { function() vim.cmd.tabclose() end, desc = "Close tab" },
    ["<leader>tn"] = { function() vim.cmd.tabnew() end, desc = "Open new tab" },
    ["<leader>t]"] = { function() vim.cmd.tabnext() end, desc = "Next Tab" },
    ["<leader>t["] = { function() vim.cmd.tabprevious() end, desc = "Previous Tab" },

    ---------------------------------------------------------------------------
    -- Unsorted -----------------------------------------------------------------
    ---------------------------------------------------------------------------
    ["<leader>ln"] = { ":AerialNavToggle<cr>", desc = "Nav Toggle", silent = true },

    ["<leader>gw"] = { ":windo diffthis", silent = true, desc = "windo diffthis" },
    ---------------------------------------------------------------------------
    -- Buffer -----------------------------------------------------------------
    ---------------------------------------------------------------------------
    ["<leader>b"] = { name = "󰮰 Buffers" },

    ["<tab>"] = { "<cmd>bnext<cr>", silent = true, desc = "Next Buffer" },
    ["<S-tab>"] = { "<cmd>bprev<cr>", silent = true, desc = "Previous Buffer" },
    ["<leader><tab>"] = {
      function() require("astronvim.utils.buffer").prev() end,
      silent = true,
      desc = "Toggle Last Buffer",
    },

    ---------------------------------------------------------------------------
    -- Editing ----------------------------------------------------------------
    ---------------------------------------------------------------------------
    -- ["<C-u>"] = { "<C-r>", desc = "Alt Redo remap" },

    -- -------------------
    -- From telescope.lua --
    -- "<leader>fu", "<cmd>Telescope undo<CR>", desc = "Find undos",

    -- TODO: WIP Wrap in {}
    -- ["<leader>{}"] = { "vip$<ESC>a<CR>}<ESC>{i{<ESC>vi{><ESC>", desc = "Wrap in {}" },

    -- MARK: Note from standard Vim commands:
    -- "U" will undo all changes to the line since entering it

    -- Stable Paste --
    ["<leader>p"] = { [["0p]], desc = "Stable Paste Append" },
    ["<leader>P"] = { [["0P]], desc = "Stable Paste Before" },

    ["Y"] = { "mm_y$`m", desc = "Yank line w/o NL character" },
    ["D"] = { "_d$", desc = "Clear chars in line (remaps from duplicate of d$)" },

    ["dd"] = {
      function()
        if vim.api.nvim_get_current_line():match "^%s*$" then
          return '"_dd'
        else
          return "dd"
        end
      end,
      noremap = true,
      expr = true,
      desc = "Line del without molesting registers",
    },

    -- Push Lines --
    ["<A-j>"] = { ":m .+1<CR>==", desc = "Move Line Down", silent = true },
    ["<A-k>"] = { ":m .-2<CR>==", desc = "Move Line Up", silent = true },

    ["]<space>"] = { "mzo<ESC>`z", desc = "Blank line below" },
    ["[<space>"] = { "mzO<ESC>`z", desc = "Blank line above" },
    ["=<space>"] = { "mzO<ESC>`zo<ESC>`z", desc = "Blank line above and below" },

    -- TODO: Add a toggle function to step through casings
    ["~"] = { "gUiw", desc = "Quick UPPERCASE word" },
    ["<A-l>"] = { "guiw", desc = "Quick lowercase word" },

    ---------------------------------------------------------------------------
    -- Movement ---------------------------------------------------------------
    ---------------------------------------------------------------------------

    -- -------------------
    -- From harpoon.lua --
    -- prefix = <leader><leader>
    -- { prefix .. "a", function() require("harpoon.mark").add_file() end, desc = "Add file" },
    -- { prefix .. "e", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle quick menu" },

    -- "<C-x>", desc = "Goto index of mark",
    -- { "<C-p>", function() require("harpoon.ui").nav_prev() end, desc = "Goto previous mark" },
    -- { "<C-n>", function() require("harpoon.ui").nav_next() end, desc = "Goto next mark" },
    -- { prefix .. "m", "<cmd>Telescope harpoon marks<CR>", desc = "Show marks in Telescope" },

    -- using :tcd instead of :cd allows for separate tabs to have seperate Working directories
    ["<leader>E"] = { name = " Explore to..." },
    ["<leader>EE"] = { "<cmd>tcd ~/<cr>", desc = "Home", silent = true },
    ["<leader>EA"] = { "<cmd>tcd ~/.config/Astro/lua/<cr>", desc = "Astro Config", silent = true },
    ["<leader>EK"] = { "<cmd>tcd ~/k2init/<cr>", desc = "k2init", silent = true },
    ["<leader>EW"] = { "<cmd>tcd ~/WIP/<cr>", desc = "WIP", silent = true },
    ["<leader>EF"] = { "<cmd>tcd ~/.config/fish/functions/<cr>", desc = "Fish Functions", silent = true },
    ["<leader>EZ"] = { "<cmd>tcd ~/.config/wezterm/<cr>", desc = "Wezterm", silent = true },
    ["<leader>EP"] = { "<cmd>tcd ~/WIP/pyground/<cr>", desc = "PyGround", silent = true },
    ["<leader>ET"] = { "<cmd>tcd ~/WIP/tsground/<cr>", desc = "TsGround", silent = true },

    --
    -- Window Controls
    --
    ["<F7>"] = { "<C-w>r", desc = "Rotate window stack Backwards" },
    ["<F9>"] = { "<C-w>R", desc = "Rotate window stack Forwards" },

    ["<F8>"] = { "<C-w>x", desc = "Swap window with prev in stack" },

    -- Jostle Windows
    ["<leader>u="] = { "<cmd>WindowsEqualize<cr>", desc = "Equalize window splits" },
    ["<leader>="] = { "<cmd>WindowsEqualize<cr>", desc = "Equalize window splits" },

    ["<leader>u+"] = { "<cmd>WindowsMaximize<cr>", desc = "Maximize current window" },
    ["<leader>z"] = { "<cmd>WindowsMaximize<cr>", desc = "Maximize current window" },

    ["<leader>u-"] = { "<cmd>WindowsMimimize<cr>", desc = "Minimize current window" },

    -- TODO: add function to this for ui message of toggle state
    ["<leader>um"] = { "<cmd>WindowsToggleAutowidth<cr>", desc = "Toggle window sizing" },
    ["<F2>"] = { "<cmd>WindowsToggleAutowidth<cr>", desc = "Toggle window sizing" },

    ["n"] = { "nzz", desc = "Next search and center" },
    ["N"] = { "Nzz", desc = "Prev search and center" },
    ["<A-m>"] = { "/MARK<cr>", desc = "Mark Search" },

    ["<Right>"] = { "$", noremap = true, desc = "Alt end of line" },
    ["<Left>"] = { "_", noremap = true, desc = "Alt Beginning of line (First non-whitespace character)" },
  },
  -----------------------------------------------------------------------------
  -- MARK: Visual Mode --------------------------------------------------------
  -----------------------------------------------------------------------------
  v = {

    [";"] = { ":", desc = "Command Alt" },

    ["<leader>0"] = { function() require("ranger-nvim").open(true) end, noremap = true, desc = "Ranger rides again!" },
    ["<leader>o"] = { function() require("aerial").toggle() end, desc = "Symbols outline" },
    ["<F4>"] = { function() require("ranger-nvim").open(true) end, noremap = true, desc = "Ranger rides again!" },

    ["x"] = { [["_d]], desc = "Delete to black hole register" },

    -- Movement Enhancements
    ["<Right>"] = { "<End>", desc = "Alt end of line" },
    ["<Left>"] = { "_", desc = "Alt Beginning of line (First non-whitespace character)" },

    -- Push lines
    ["<A-j>"] = { ":m '>+1<CR>gv=gv", desc = "Move Line Down", silent = true },
    ["<A-k>"] = { ":m '<-2<CR>gv=gv", desc = "Move Line Up", silent = true },

    -- Jostle Windows
    ["<leader>u="] = { "<cmd>WindowsEqualize<cr>", desc = "Equalize window splits" },
    ["<leader>="] = { "<cmd>WindowsEqualize<cr>", desc = "Equalize window splits" },

    ["<leader>u+"] = { "<cmd>WindowsMaximize<cr>", desc = "Maximize current window" },
    ["<leader>z"] = { "<cmd>WindowsMaximize<cr>", desc = "Maximize current window" },

    ["<leader>u-"] = { "<cmd>WindowsMimimize<cr>", desc = "Minimize current window" },

    -- TODO: add function to this for ui message of toggle state
    ["<leader>um"] = { "<cmd>WindowsToggleAutowidth<cr>", desc = "Toggle window sizing" },
    ["<F2>"] = { "<cmd>WindowsToggleAutowidth<cr>", desc = "Toggle window sizing" },

    -- Buffer control
    ["<tab>"] = { "<cmd>bnext<cr>", silent = true, desc = "Next Buffer" },
    ["<S-tab>"] = { "<cmd>bprev<cr>", silent = true, desc = "Next Buffer" },
    ["<leader><tab>"] = {
      "<cmd>lua require('astronvim.utils.buffer').next()<cr>",
      silent = true,
      desc = "Swap Previous Buffer",
    },

    -- In/Undent w/o losing selection
    [">"] = { ">gv", desc = "Indent line" },
    ["<"] = { "<gv", desc = "UnIndent line" },

    --
    -- Window Controls
    --
    ["<F7>"] = { "<C-w>r", desc = "Rotate window stack Backwards" },
    ["<F9>"] = { "<C-w>R", desc = "Rotate window stack Forwards" },

    ["<F8>"] = { "<C-w>x", desc = "Swap window with prev in stack" },
  },
  -----------------------------------------------------------------------------
  -- MARK: Insert Mode --------------------------------------------------------
  -----------------------------------------------------------------------------
  i = {

    ["<F4>"] = { function() require("ranger-nvim").open(true) end, noremap = true, desc = "Ranger rides again!" },

    -- Push Lines
    ["<A-j>"] = { "<ESC>:m .+1<CR>==gi", desc = "Move Line Down", silent = true },
    ["<A-k>"] = { "<ESC>:m .-2<CR>==gi", desc = "Move Line Up", silent = true },

    ["<A-u>"] = { "<ESC>gUiwea", desc = "Quick uppercase word" },
    ["<A-l>"] = { "<ESC>guiwea", desc = "Quick lowercase word" },

    -- -- Jostle Windows
    -- TODO: add function to this for ui message of toggle state
    ["<F2>"] = { "<cmd>WindowsToggleAutowidth<cr>", desc = "Toggle window sizing" },
  },
  -----------------------------------------------------------------------------
  -- MARK: Terminal Mode -------------------------------------------------------
  -----------------------------------------------------------------------------
  t = {},
  -----------------------------------------------------------------------------
  -- TODO: come back to me
  -----------------------------------------------------------------------------
  x = {
    -- primeagen keymap
    --   ["<C-p>"] = { "\"_dP", desc = "Clone Stamp (Paste and Keep)" },

    -- ["<Right>"] = { "$", noremap = true, desc = "Alt end of line" },
  },
  o = {
    ["<Right>"] = { "$", noremap = true, desc = "Alt end of line" },
    ["<Left>"] = { "_", noremap = true, desc = "Alt Beginning of line (First non-whitespace)" },

    ["]<space>"] = { "mzo<ESC>`z", desc = "Blank line below" },
    ["[<space>"] = { "mzO<ESC>`z", desc = "Blank line above" },
    ["=<space>"] = { "mzO<ESC>`zo<ESC>`z", desc = "Blank line above and below" },
  },
}
