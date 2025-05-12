return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = "   ",
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" }) -- find files within current working directory, respects .gitignore
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find string in cwd" }) -- find string in current working directory as you type
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Fuzzy find string under cursor in cwd" }) -- find string under cursor in current working directory
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find buffers" }) -- list open buffers in current neovim instance
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Fuzzy find help tags" }) -- list available help tags

    keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>") -- see definition and make edits in window
    keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>") -- go to implementation
    keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>") -- go to references
    keymap.set("n", "<leader>wS", "<cmd>Telescope lsp_workspace_symbols<CR>")
    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>") -- show  diagnostics for file

    keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Fuzzy find git commits" }) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
    keymap.set(
      "n",
      "<leader>gfc",
      "<cmd>Telescope git_bcommits<cr>",
      { desc = "Fuzzy find git commits for current file/buff" }
    ) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
    keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Fuzzy find git branches" }) -- list git branches (use <cr> to checkout) ["gb" for git branch]
    keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Fuzzy find current changes" }) -- list current changes per file with diff
  end,
}
