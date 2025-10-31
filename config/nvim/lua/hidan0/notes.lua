-- Fix for nvim overwriting tab opts
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
    end,
})

local opts = {
    base_dir = vim.fn.expand("~/notes/second_brain"),
    daily_dir = "1_Daily",
    inbox_dir = "0_Inbox",
}

local Snacks = require("snacks")

local function uuid()
    return vim.fn.system("uuidgen"):gsub("%s+", "")
end

local Daily = {
    TODAY = "today",
    TOMORROW = "tomorrow",
    YESTERDAY = "yesterday",
}
local Daily_offset = (24 * 60 * 60)

local function daily_note(when)
    local when = when or Daily.TODAY

    local time = os.time()
    if when == Daily.TOMORROW then
        time = time + Daily_offset
    elseif when == Daily.YESTERDAY then
        time = time - Daily_offset
    end

    local date = os.date("*t", time)
    local year = date.year
    local month = date.month
    local day = string.format("%04d-%02d-%02d", date.year, date.month, date.day)

    local dir = string.format("%s/%s/%s/%s", opts.base_dir, opts.daily_dir, year, month)
    local filepath = string.format("%s/%s.md", dir, day)

    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end

    if vim.fn.filereadable(filepath) == 0 then
        local template = string.format(
            [[---
id: %s
tags:
  - daily-note
---

# %s

## Tasks

## Completed Tasks
]],
            uuid(),
            day,
            date.hour,
            date.min
        )

        -- write the file
        local file = io.open(filepath, "w")
        file:write(template)
        file:close()
    end

    return filepath
end

local function open_daily_note(when)
    local filepath = daily_note(when)
    vim.cmd("edit " .. vim.fn.fnameescape(filepath))
end

--- Creates a new note in the inbox directory
local function new_note()
    local date = os.date("%Y-%m-%d")
    local dir = string.format("%s/%s", opts.base_dir, opts.inbox_dir)

    if not vim.fn.isdirectory(dir) then
        vim.notify("Notes inbox directory not found", vim.log.levels.WARN)
        return
    end

    vim.ui.input({ prompt = "Note name:" }, function(notename)
        if not notename or notename == "" then
            vim.notify("Cancelled input", vim.log.levels.INFO)
            return
        end
        local filepath = string.format("%s/%s.md", dir, notename)

        if vim.fn.filereadable(filepath) then
            local template = string.format(
                [[---
id: %s
created: %s
tags: []
---

# %s

]],
                uuid(),
                date,
                notename
            )

            local file = io.open(filepath, "w")
            file:write(template)
            file:close()
        else
            vim.notify("Failed to create new note", vim.log.levels.WARN)
            return
        end

        vim.cmd("edit " .. vim.fn.fnameescape(filepath))
    end)
end

-- split string `s` at first occurrence of `c`
local function split_at(s, c)
    local pos = string.find(s, c)

    if pos == nil then
        return nil
    end

    local left = string.sub(s, 0, pos - 1)
    local right = string.sub(s, pos + 1)

    return { left = left, right = right }
end

local function process_ripgrep_line(line)
    -- file:row:col:grepped_string

    local split = split_at(line, ":")
    if not split then
        vim.notify("Failed to parse ripgrep output [file]:\n" .. line, vim.log.levels.ERROR)
        return nil
    end

    local file = split.left

    split = split_at(split.right, ":")
    if not split then
        vim.notify("Failed to parse ripgrep output [row]:\n" .. line, vim.log.levels.ERROR)
        return nil
    end

    local row = tonumber(split.left)

    split = split_at(split.right, ":")
    if not split then
        vim.notify("Failed to parse ripgrep output [col]:\n" .. line, vim.log.levels.ERROR)
        return nil
    end

    local col = tonumber(split.left)

    -- clean text
    local text = string.gsub(split.right, "%- %[ %]%s+", "")

    return { file = file, row = row, col = col, text = text }
end

local function find_unchecked_todos()
    local query = "\\- \\[ \\]"
    local cmd = { "rg", "--vimgrep", "--no-heading", "-tmd", "--glob", "!Spesa.*", query, opts.base_dir }

    local res = vim.fn.systemlist(cmd)

    if vim.v.shell_error ~= 0 then
        vim.notify("ripgrep error: " .. table.concat(res, "\n"), vim.log.levels.ERROR)
        return
    end

    local items = {}
    for i, line in ipairs(res) do
        local item = process_ripgrep_line(line)
        if item ~= nil then
            table.insert(items, {
                idx = i,
                score = i,
                pos = { item.row, item.col },
                file = item.file,
                text = item.text,
            })
        end
    end

    return Snacks.picker({
        title = "All Tasks",
        items = items,
        format = function(item, _)
            return {
                { item.text },
            }
        end,
    })
end

-- Moves the current TODO under the cursor to the daily completed tasks marking it as done
-- and adds a completed tag: `done: YYYY-MM-DD HH:mm`
local function check_todo()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1] - 1 -- treesitter is 0 based

    local bufnr = vim.api.nvim_get_current_buf()

    local parser = require("nvim-treesitter.parsers").get_parser(bufnr, "markdown")
    if not parser then
        vim.notify("Failed to parse markdown", vim.log.levels.ERROR)
        return
    end
    local tree = parser:parse()[1]

    local query = [[
(list_item
	(_)
	(task_list_marker_unchecked)
	) @li]]
    local ok, q = pcall(vim.treesitter.query.parse, "markdown", query)
    if not ok then
        vim.notify("Failed to parse Tree-sitter query: " .. q, vim.log.levels.ERROR)
        return
    end

    for _, node in q:iter_captures(tree:root(), bufnr) do
        local s_row, _, e_row, _ = node:range()

        if row >= s_row and row < e_row then
            local lines = vim.api.nvim_buf_get_lines(bufnr, s_row, e_row, false)

            lines[1] = lines[1]:gsub("%[%s%]", "[x]") -- check the todo

            if lines[#lines] == "" then
                lines[#lines - 1] = lines[#lines - 1] .. string.format(" `done: %s`", os.date("%Y-%m-%d %H:%M"))
            else
                lines[#lines] = lines[#lines] .. string.format(" `done: %s`", os.date("%Y-%m-%d %H:%M"))
            end

            vim.api.nvim_buf_set_lines(bufnr, s_row, e_row, false, {})
            -- Adjust cursor position if it's beyond the buffer
            local total_lines = vim.api.nvim_buf_line_count(bufnr)
            if cursor[1] > total_lines then
                vim.api.nvim_win_set_cursor(0, { total_lines, 0 })
            end
            -- Create Daily note if doesn't exists
            local daily_fp = daily_note() -- gets daily note path

            -- Check if there is a buffer with the daily note opened
            local daily_bufnr = nil
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) then
                    local buf_name = vim.api.nvim_buf_get_name(buf)
                    if buf_name == daily_fp then
                        daily_bufnr = buf
                        break
                    end
                end
            end

            if not daily_bufnr then
                vim.cmd("edit " .. vim.fn.fnameescape(daily_fp))
                daily_bufnr = vim.api.nvim_get_current_buf()
            else
                local daily_win = vim.fn.bufwinid(daily_bufnr)
                if daily_win ~= -1 then
                    vim.api.nvim_set_current_win(daily_win)
                else
                    vim.cmd("buffer " .. daily_bufnr)
                end
            end

            local daily_lines = vim.api.nvim_buf_get_lines(daily_bufnr, 0, -1, false)
            for _, line in ipairs(lines) do
                table.insert(daily_lines, line)
            end
            vim.api.nvim_buf_set_lines(daily_bufnr, 0, -1, false, daily_lines)

            if bufnr ~= daily_bufnr then
                vim.api.nvim_buf_call(daily_bufnr, function()
                    vim.cmd("write")
                end)
            end

            vim.api.nvim_buf_call(bufnr, function()
                vim.cmd("write")
            end)

            return
        end
    end
end

local function cancel_todo()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1] - 1 -- treesitter is 0 based

    local bufnr = vim.api.nvim_get_current_buf()

    local parser = require("nvim-treesitter.parsers").get_parser(bufnr, "markdown")
    if not parser then
        vim.notify("Failed to parse markdown", vim.log.levels.ERROR)
        return
    end
    local tree = parser:parse()[1]

    local query = [[
(list_item
	(_)
	(task_list_marker_unchecked)
	) @li]]
    local ok, q = pcall(vim.treesitter.query.parse, "markdown", query)
    if not ok then
        vim.notify("Failed to parse Tree-sitter query: " .. q, vim.log.levels.ERROR)
        return
    end

    for _, node in q:iter_captures(tree:root(), bufnr) do
        local s_row, _, e_row, _ = node:range()

        if row >= s_row and row < e_row then
            local lines = vim.api.nvim_buf_get_lines(bufnr, s_row, e_row, false)

            lines[1] = lines[1]:gsub("%[%s%]%s", "[x] ~~") -- check the task, add the chars for strike through

            if lines[#lines] == "" then
                lines[#lines - 1] = lines[#lines - 1] .. string.format("~~ `cancelled: %s`", os.date("%Y-%m-%d %H:%M"))
            else
                lines[#lines] = lines[#lines] .. string.format("~~ `cancelled: %s`", os.date("%Y-%m-%d %H:%M"))
            end

            vim.api.nvim_buf_set_lines(bufnr, s_row, e_row, false, {})
            -- Adjust cursor position if it's beyond the buffer
            local total_lines = vim.api.nvim_buf_line_count(bufnr)
            if cursor[1] > total_lines then
                vim.api.nvim_win_set_cursor(0, { total_lines, 0 })
            end
            -- Create Daily note if doesn't exists
            local daily_fp = daily_note() -- gets daily note path

            -- Check if there is a buffer with the daily note opened
            local daily_bufnr = nil
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) then
                    local buf_name = vim.api.nvim_buf_get_name(buf)
                    if buf_name == daily_fp then
                        daily_bufnr = buf
                        break
                    end
                end
            end

            if not daily_bufnr then
                vim.cmd("edit " .. vim.fn.fnameescape(daily_fp))
                daily_bufnr = vim.api.nvim_get_current_buf()
            else
                local daily_win = vim.fn.bufwinid(daily_bufnr)
                if daily_win ~= -1 then
                    vim.api.nvim_set_current_win(daily_win)
                else
                    vim.cmd("buffer " .. daily_bufnr)
                end
            end

            local daily_lines = vim.api.nvim_buf_get_lines(daily_bufnr, 0, -1, false)
            for _, line in ipairs(lines) do
                table.insert(daily_lines, line)
            end
            vim.api.nvim_buf_set_lines(daily_bufnr, 0, -1, false, daily_lines)

            if bufnr ~= daily_bufnr then
                vim.api.nvim_buf_call(daily_bufnr, function()
                    vim.cmd("write")
                end)
            end

            vim.api.nvim_buf_call(bufnr, function()
                vim.cmd("write")
            end)

            return
        end
    end
end

-- KEYMAPS
vim.keymap.set("n", "<leader>nt", open_daily_note, { desc = "Create\\Open today daily note" })
vim.keymap.set("n", "<leader>nT", function()
    open_daily_note(Daily.TOMORROW)
end, { desc = "Create\\Open tomorrow daily note" })
vim.keymap.set("n", "<leader>ny", function()
    open_daily_note(Daily.YESTERDAY)
end, { desc = "Create\\Open yesterday daily note" })

vim.keymap.set("n", "<leader>nn", new_note, { desc = "Create a new note in the inbox" })

vim.keymap.set("n", "<leader>nst", find_unchecked_todos, { desc = "Find all tasks" })

-- LOCAL KEYMAPS
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    pattern = opts.base_dir .. "/*.md",
    callback = function()
        vim.keymap.set("n", "<localleader>td", check_todo, { desc = "Set task as completed", buffer = true })
    end,
})
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    pattern = opts.base_dir .. "/*.md",
    callback = function()
        vim.keymap.set("n", "<localleader>tc", cancel_todo, { desc = "Set task as cancelled", buffer = true })
    end,
})
