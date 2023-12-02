return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "VeryLazy",
  opts = {
    -- INFO: Uncomment to use treeitter as fold provider, otherwise nvim lsp is used
    -- provider_selector = function(bufnr, filetype, buftype)
    --   return { "treesitter", "indent" }
    -- end,
    open_fold_hl_timeout = 400,
    close_fold_kinds = { "imports", "comment" },
    preview = {
      win_config = {
        border = { "", "─", "", "", "", "─", "", "" },
        -- winhighlight = "Normal:Folded",
        winblend = 0,
      },
      mappings = {
        scrollU = "<C-u>",
        scrollD = "<C-d>",
        jumpTop = "[",
        jumpBot = "]",
      },
    },
  },
  init = function()
    vim.o.fillchars = [[eob:~,fold:-,foldopen:,foldsep: ,foldclose:]]
    vim.o.foldcolumn = "1" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  config = function(_, opts)
    -- local handler = function(virtText, lnum, endLnum, width, truncate)
    local handler = function(virtText, lnum, endLnum, _, _)
      local trunc = function(str, w)
        local str_width = vim.fn.strdisplaywidth(str)
        if str_width > w then
          -- chop chop
          return string.sub(str, 1, w)
        end
        return str --- length 70
      end

      local return_val = {}
      local fill = "·"

      local totalLines = vim.api.nvim_buf_line_count(0)
      local foldedLines = endLnum - lnum
      local sizeInBuf = foldedLines / totalLines * 100

      local suffix = (" 󰘕 %d lines %d%% %s"):format(foldedLines, sizeInBuf, fill)

      local target_width = 80
      local header_cutoff = 70

      local current_width = 0

      for _, chunk in ipairs(virtText) do
        local chunk_text = chunk[1]
        local chunk_width = vim.fn.strdisplaywidth(chunk_text)

        if header_cutoff >= current_width + chunk_width then
          table.insert(return_val, chunk)
        else
          chunk_text = trunc(chunk_text, header_cutoff - current_width)

          local hlGroup = chunk[2]
          table.insert(return_val, { chunk_text, hlGroup })
          current_width = header_cutoff

          break
        end

        current_width = current_width + chunk_width
      end

      local fill_amount = target_width - current_width

      suffix = (fill):rep(fill_amount) .. suffix
      table.insert(return_val, { suffix, "MoreMsg" })

      return return_val
    end

    opts["fold_virt_text_handler"] = handler
    require("ufo").setup(opts)

    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    vim.keymap.set("n", "K", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        -- vim.lsp.buf.hover()
        vim.cmd [[ Lspsaga hover_doc ]]
      end
    end)
  end,
}
