return {
  "saecki/crates.nvim",
  dependencies = "hrsh7th/nvim-cmp",
  event = { "BufRead Cargo.toml" },
  config = function()
    local crates = require("crates")
    crates.setup({
      src = {
        cmp = {
          enabled = true,
        },
      },
    })

    local cmp = require("cmp")

    vim.api.nvim_create_autocmd("BufRead", {
      group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
      pattern = "Cargo.toml",
      callback = function()
        cmp.setup.buffer({ sources = { { name = "crates" } } })
      end,
    })
  end,
}
