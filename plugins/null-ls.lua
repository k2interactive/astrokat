return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- TODO: update me for none instead of null
    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.black.with {
        extra_args = { "--line-length=88" },
      },
      null_ls.builtins.formatting.isort,
      null_ls.builtins.diagnostics.mypy,
      null_ls.builtins.completion.spell.with {
        -- Force the severity to be HINT
        diagnostics_postprocess = function(diagnostic) diagnostic.severity = vim.diagnostic.severity.HINT end,
      },
    }
    return config -- return final config table
  end,
}
