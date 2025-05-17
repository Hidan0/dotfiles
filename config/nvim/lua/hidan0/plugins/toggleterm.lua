return {
  -- TODO: REMOVE
  enabled = false,
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local keymap = vim.keymap

    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<a-i>]],
      hide_numbers = true,
      shade_filetypes = {},
      autochdir = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "curved",
        winblend = 0,
      },
    })

    function _G.set_terminal_keymaps()
      local opts = { noremap = true, buffer = 0 }
      keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      keymap.set("t", "jk", [[<C-\><C-n>]], opts)
      keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}
