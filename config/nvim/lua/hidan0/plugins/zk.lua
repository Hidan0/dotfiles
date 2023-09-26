return {
  "mickael-menu/zk-nvim",
  config = function()
    local opts = { noremap = true, silent = false }
    local keymap = vim.keymap

    -- Create a new note after asking for its title.
    keymap.set("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

    -- Open notes.
    keymap.set("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
    -- Open notes associated with the selected tags.
    keymap.set("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

    -- Search for the notes matching a given query.
    keymap.set(
      "n",
      "<leader>zf",
      "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
      opts
    )
    -- Search for the notes matching the current visual selection.
    keymap.set("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)

    require("zk").setup({
      picker = "telescope",
    })
  end,
}
