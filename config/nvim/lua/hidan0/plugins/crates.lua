return {
  "saecki/crates.nvim",
  dependencies = "hrsh7th/nvim-cmp",
  event = { "BufRead Cargo.toml" },
  config = function()
    local crates = require("crates")
    crates.setup()

    local cmp = require("cmp")

    cmp.setup.buffer({
      sources = {
        { name = "crates" },
      },
    })

    crates.show()
  end,
}
