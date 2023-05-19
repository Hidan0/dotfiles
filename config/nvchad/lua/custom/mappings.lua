local M = {}

M.disabled = {
  n = {
    ["<Esc>"] = "",
    ["<C-s>"] = "",
    ["<C-c>"] = "",
    -- LSP CONFIG
    ["<leader>ra"] = "",
  },
  x = {
    ["p"] = "",
  },
}

M.general = {
  i = {
    ["jk"] = {
      "<ESC>",
      "Go to normalmode",
    },
  },
  n = {
    ["<leader>nh"] = {
      ":nohl<CR>",
      "Clear highlight after search",
    },
    ["<leader>+"] = {
      "<C-a>",
      "Increment number",
    },
    ["<leader>-"] = {
      "<C-x>",
      "Decrement number",
    },
    ["<leader>wv"] = {
      "<C-w>v",
      "Split vertically",
    },
    ["<leader>ws"] = {
      "<C-w>s",
      "Split horizontally",
    },
    ["<leader>wq"] = {
      ":close<CR>",
      "Close current window",
    },
    ["<leader>we"] = {
      "<C-w>=",
      "Make split windows equal size",
    },
    ["Q"] = {
      "<nop>",
    },
    ["<C-d>"] = {
      "<C-d>zz",
    },
    ["<C-u>"] = {
      "<C-u>zz",
    },
    ["<C-f>"] = {
      "<cmd>silent !tmux neww tms<CR>",
      "Open tmux sessionizer",
    },
    ["x"] = {
      '"_x',
      "Doesn't copy single char",
    },
    ["<leader>y"] = {
      [["+y]],
      "Copy into sys clipboard",
    },
    ["<leader>Y"] = {
      [["+Y]],
      "Copy into sys clipboard",
    },
  },
  v = {
    ["J"] = {
      ":m '>+1<CR>gv=gv",
      "Move text down",
    },
    ["K"] = {
      ":m '<-2<CR>gv=gv",
      "Move text up",
    },
    ["<leader>y"] = {
      [["+y]],
      "Copy into sys clipboard",
    },
    ["<leader>d"] = {
      [["_d]],
      "Delete into void",
    },
  },
  x = {
    ["<leader>p"] = {
      [["_dP]],
      "Delete into void",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    ["<leader>e"] = {
      "<cmd> NvimTreeToggle <CR>",
      "Toggle nvimtree",
    },
    ["<C-n>"] = {
      "<cmd> NvimTreeFocus <CR>",
      "Focus nvimtree",
    },
  },
}

M.lspconfig = {
  plugin = true,

  n = {
    ["<leader>rn"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },
    ["<leader>wS"] = {
      function()
        vim.lsp.buf.workspace_symbol()
      end,
      "List workspace symbols",
    },
  },
}

M.dap = {
  n = {
    ["<leader>db"] = {
      "<cmd>DapToggleBreakpoint<CR>",
      "Toggle breakpoint",
    },
    ["<leader>dus"] = {
      function()
        require("dapui").toggle()
      end,
      "Toggle dap ui",
    },
    ["<leader>duk"] = {
      function()
        require("dapui").eval()
      end,
      "Toggle float dap ui",
    },
  },
}

M.tmux_nav = {
  n = {
    ["<C-h>"] = { "<Cmd>TmuxNavigateLeft<CR>", "Tmux navigate left" },
    ["<C-l>"] = { "<Cmd>TmuxNavigateRight<CR>", "Tmux navigate right" },
    ["<C-j>"] = { "<Cmd>TmuxNavigateDown<CR>", "Tmux navigate down" },
    ["<C-k>"] = { "<Cmd>TmuxNavigateUp<CR>", "Tmux navigate up" },
  },
}

M.undotree = {
  n = {
    ["<leader>u"] = { "<cmd>UndotreeToggle<CR>", "Open undotree" },
  },
}

return M
