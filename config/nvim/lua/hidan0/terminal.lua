local state = {
    buf = -1,
    win = -1,
}

local function create_window(opts)
    opts = opts or {}
    local w = opts.width or vim.o.columns
    local h = opts.height or math.floor(vim.o.lines * 0.5)

    -- Window position
    local col = 0
    local row = vim.o.lines - h

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    -- Define window configuration
    local win_conf = {
        relative = "editor",
        width = w,
        height = h,
        col = col,
        row = row,
        style = "minimal",
        border = { "", "─", "", "", "", "", "", "" },
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, win_conf)

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.win) then
        state = create_window({ buf = state.buf })
        if vim.bo[state.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.win)
    end
end

-- Terminal Keymaps
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Go to normal mode in terminal" })
vim.keymap.set("n", "<leader>tt", function()
    toggle_terminal()
end, { desc = "Toggle Terminal" })
