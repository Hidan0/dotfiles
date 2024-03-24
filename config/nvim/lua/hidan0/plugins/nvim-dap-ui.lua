return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local dapui = require("dapui")
    dapui.setup()

    local keymap = vim.keymap
    keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>")
    keymap.set("n", "<leader>dus", function()
      dapui.toggle()
    end)
    keymap.set("n", "<leader>duk", function()
      dapui.eval()
    end)
  end,
}
