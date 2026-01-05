-- Fix for nvim overwriting tab opts
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
    end,
})

local BASE_DIR = vim.fn.expand("~/notes/second_brain")
local INBOX_DIR = BASE_DIR .. "/0_Inbox"
local DAILY_DIR = BASE_DIR .. "/1_Daily"
local TEMPLATE_DIR = BASE_DIR .. "/7_Metadata/templates"

local UNCHECKED_TASK_QUERY = [[
(list_item
	(_)
	(task_list_marker_unchecked)
	) @li]]

local Snacks = require("snacks")

local function read_all_file(file)
    local f = assert(io.open(file, "r"))
    local content = f:read("*a")
    f:close()
    return content
end

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
    when = when or Daily.TODAY

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

    local dir = string.format("%s/%s/%02d", DAILY_DIR, year, month)
    local filepath = string.format("%s/%s.md", dir, day)

    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end

    if vim.fn.filereadable(filepath) == 0 then
        local template = read_all_file(TEMPLATE_DIR .. "/nvim_daily_note_tp.md")
        local content = string.format(template, uuid(), day, date.hour, date.min)

        -- write the file
        local file = assert(io.open(filepath, "w"))
        file:write(content)
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

    if not vim.fn.isdirectory(INBOX_DIR) then
        vim.notify("Notes inbox directory not found", vim.log.levels.WARN)
        return
    end

    vim.ui.input({ prompt = "Note name:" }, function(notename)
        if not notename or notename == "" then
            vim.notify("Cancelled input", vim.log.levels.INFO)
            return
        end
        local filepath = string.format("%s/%s.md", INBOX_DIR, notename)

        if vim.fn.filereadable(filepath) then
            local template = read_all_file(TEMPLATE_DIR .. "/nvim_note_tp.md")
            local content = string.format(template, uuid(), date, notename)

            local file = assert(io.open(filepath, "w"))
            file:write(content)
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
    local cmd = { "rg", "--vimgrep", "--no-heading", "-tmd", "--glob", "!Spesa.*", query, BASE_DIR }

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

local function process_task(process_lines)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1] - 1 -- treesitter is 0 based

    local bufnr = vim.api.nvim_get_current_buf()
    local file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t:r")

    local parser = require("nvim-treesitter.parsers").get_parser(bufnr, "markdown")
    if not parser then
        vim.notify("Failed to parse markdown", vim.log.levels.ERROR)
        return
    end
    local tree = parser:parse()[1]

    local ok, q = pcall(vim.treesitter.query.parse, "markdown", UNCHECKED_TASK_QUERY)
    if not ok then
        vim.notify("Failed to parse Tree-sitter query: " .. q, vim.log.levels.ERROR)
        return
    end

    for _, node in q:iter_captures(tree:root(), bufnr) do
        local s_row, _, e_row, _ = node:range()

        if row >= s_row and row < e_row then
            local lines = vim.api.nvim_buf_get_lines(bufnr, s_row, e_row, false)

            -- Create Daily note if doesn't exists
            local daily_fp = daily_note() -- gets daily note path
            local daily_name = vim.fn.fnamemodify(daily_fp, ":t:r")

            if file_name ~= daily_name then
                process_lines(lines, file_name)
            else
                process_lines(lines)
            end

            vim.api.nvim_buf_set_lines(bufnr, s_row, e_row, false, {})
            -- Adjust cursor position if it's beyond the buffer
            local total_lines = vim.api.nvim_buf_line_count(bufnr)
            if cursor[1] > total_lines then
                vim.api.nvim_win_set_cursor(0, { total_lines, 0 })
            end

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

            -- Find the "## Completed Tasks" heading
            local insert_position = nil
            for i, line in ipairs(daily_lines) do
                if line:match("^##%s+Completed%s+Tasks") then
                    insert_position = i
                    -- Skip blank lines under the title
                    while insert_position < #daily_lines and daily_lines[insert_position + 1]:match("^%s*$") do
                        insert_position = insert_position + 1
                    end
                    break
                end
            end

            if insert_position then
                for i = #lines, 1, -1 do
                    if lines[i]:match("%S") then
                        table.insert(daily_lines, insert_position + 1, lines[i])
                    end
                end
            else
                -- Fallback at the end
                for _, line in ipairs(lines) do
                    table.insert(daily_lines, line)
                end
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

            vim.api.nvim_set_current_buf(bufnr)

            return
        end
    end
end

local function complete_task(lines, backlink)
    lines[1] = lines[1]:gsub("%[%s%]", "[x]") -- check the todo

    local metadata = string.format(" `done: %s`", os.date("%Y-%m-%d %H:%M"))
    if backlink then
        metadata = metadata .. string.format(" [[%s]]", backlink)
    end

    if lines[#lines] == "" then
        lines[#lines - 1] = lines[#lines - 1] .. metadata
    else
        lines[#lines] = lines[#lines] .. metadata
    end
end

local function cancel_task(lines, backlink)
    lines[1] = lines[1]:gsub("%[%s%]%s", "[x] ~~") -- check the task, add the chars for strike through

    local metadata = string.format("~~ `cancelled: %s`", os.date("%Y-%m-%d %H:%M"))
    if backlink then
        metadata = metadata .. string.format(" [[%s]]", backlink)
    end

    if lines[#lines] == "" then
        lines[#lines - 1] = lines[#lines - 1] .. metadata
    else
        lines[#lines] = lines[#lines] .. metadata
    end
end

local function headlines()
    local bufrn = vim.api.nvim_get_current_buf()

    local lines = vim.api.nvim_buf_get_lines(bufrn, 0, -1, false)

    if not lines then
        return
    end

    local heading_regex = "^(#+)%s+(.+)"

    local items = {}
    local idx = 0

    for row, line in ipairs(lines) do
        local hashes, title = string.match(line, heading_regex, 0)

        if hashes and title then
            local level = #hashes
            local col = level + 1 -- hashes + space

            table.insert(items, {
                idx = idx,
                pos = { row, col },
                file = vim.api.nvim_buf_get_name(bufrn),
                text = title,
                level = level,
            })

            idx = idx + 1
        end
    end

    return Snacks.picker({
        title = "Headlines",
        items = items,
        format = function(item, _)
            -- local prefix = item.level == 1 and "■ " or string.rep("  ", item.level - 1) .. "▪ "

            local indent = string.rep("  ", item.level - 1)

            local level_colors = {
                "@markup.heading.1.markdown",
                "@markup.heading.2.markdown",
                "@markup.heading.3.markdown",
                "@markup.heading.4.markdown",
                "@markup.heading.5.markdown",
                "@markup.heading.6.markdown",
            }

            local hl_group = level_colors[item.level] or "@markup.heading.markdown"

            local icon = item.level == 1 and "■" or "▪"
            return {
                { indent, "Comment" },
                { icon .. " " .. item.text, hl_group },
            }
        end,
    })
end

local function move_daily_tasks_to_current_day()
    open_daily_note()
    local daily_bufrn = vim.api.nvim_get_current_buf() -- daily

    local tasks_h_rgx = "^(#+)%s+Tasks"

    local tasks_section_row = nil
    for row, line in ipairs(vim.api.nvim_buf_get_lines(daily_bufrn, 0, -1, false)) do
        if string.match(line, tasks_h_rgx) then
            tasks_section_row = row + 1
            break
        end
    end

    if not tasks_section_row then
        vim.notify("Can not find `Tasks` section in current note", vim.log.levels.ERROR)
        return
    end

    -- Search tasks
    local query = "\\- \\[ \\]"
    local filterout_daily = "!" .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(daily_bufrn), ":t")
    local cmd = { "rg", "-l", "-tmd", "-g", filterout_daily, query, DAILY_DIR }

    local res = vim.fn.systemlist(cmd)

    if vim.v.shell_error ~= 0 then
        vim.notify("ripgrep error: " .. table.concat(res, "\n"), vim.log.levels.ERROR)
        return
    end

    if not res then
        vim.notify("No unchecked tasks found", vim.log.levels.INFO)
        return
    end

    for _, filepath in ipairs(res) do
        local bufrn = vim.fn.bufadd(filepath)
        vim.fn.bufload(filepath)

        local parser = require("nvim-treesitter.parsers").get_parser(bufrn, "markdown")
        if not parser then
            vim.notify("Failed to parse markdown", vim.log.levels.ERROR)
            return
        end
        local tree = parser:parse()[1]

        local ok, q = pcall(vim.treesitter.query.parse, "markdown", UNCHECKED_TASK_QUERY)
        if not ok then
            vim.notify("Failed to parse Tree-sitter query: " .. q, vim.log.levels.ERROR)
            return
        end

        local local_tasks = {}
        for _, node in q:iter_captures(tree:root(), bufrn) do
            local s_row, _, e_row, _ = node:range()

            local lines = vim.api.nvim_buf_get_lines(bufrn, s_row, e_row, false)
            table.insert(local_tasks, {
                lines = lines,
                start_row = s_row,
                end_row = e_row,
            })
        end

        for _, task in ipairs(local_tasks) do
            for _, task_line in ipairs(task.lines) do
                if task_line ~= "" then
                    vim.api.nvim_buf_set_lines(daily_bufrn, tasks_section_row, tasks_section_row, false, task.lines)
                end
            end
        end

        -- remove lines bottom up
        table.sort(local_tasks, function(a, b)
            return a.start_row > b.start_row
        end)

        for _, task in ipairs(local_tasks) do
            vim.api.nvim_buf_set_lines(bufrn, task.start_row, task.end_row, false, {})
        end

        vim.api.nvim_buf_call(bufrn, function()
            vim.cmd("write")
        end)

        vim.api.nvim_buf_delete(bufrn, { unload = true })
    end

    vim.api.nvim_buf_call(daily_bufrn, function()
        vim.cmd("write")
    end)
end

local function find_index_notes()
    local query = "^type: index"
    local cmd = { "rg", "-l", "-tmd", query, BASE_DIR }

    local res = vim.fn.systemlist(cmd)

    if vim.v.shell_error ~= 0 then
        vim.notify("ripgrep error: " .. table.concat(res, "\n"), vim.log.levels.ERROR)
        return
    end

    local items = {}
    for idx, file in ipairs(res) do
        table.insert(items, {
            idx = idx,
            file = file,
            text = vim.fn.fnamemodify(file, ":t:r"),
        })
    end

    return Snacks.picker({
        title = "Index Notes",
        items = items,
        format = function(item, _)
            return { { item.text } }
        end,
    })
end

local function escape_regex(text)
    return text:gsub("([%.%^%$%*%+%-%?%(%)%[%]%{%}%|\\])", "\\%1")
end

local function display_backlinks()
    local bufnr = vim.api.nvim_get_current_buf()
    local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t:r")
    fname = escape_regex(fname)

    local query = "\\[\\[" .. fname .. "\\]\\]"
    local cmd = { "rg", "--vimgrep", "--no-heading", "-tmd", query, BASE_DIR }

    local res = vim.fn.systemlist(cmd)

    if vim.v.shell_error == 2 then
        vim.notify("ripgrep error: " .. table.concat(res, "\n"), vim.log.levels.ERROR)
        return
    elseif vim.v.shell_error == 1 then
        return
    end

    local ns_id = vim.api.nvim_create_namespace("backlinks")
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

    local mentions = {}
    local dailies = {}
    local seen = {}

    for _, line in pairs(res) do
        local item = assert(process_ripgrep_line(line))
        local mention = vim.fn.fnamemodify(item.file, ":t:r")

        if not seen[mention] then
            if mention:match("^%d%d%d%d%-%d%d%-%d%d$") then
                table.insert(dailies, mention)
            else
                table.insert(mentions, mention)
            end
            seen[mention] = true
        end
    end

    -- Sort by most recent (ISO 8601 format (YYYY-MM-DD) is lexicographically sortable)
    table.sort(dailies, function(d1, d2)
        if d1 > d2 then
            return true
        else
            return false
        end
    end)

    local last_line = vim.api.nvim_buf_line_count(bufnr) - 1
    local virt_lines = {}

    if #mentions > 0 then
        table.insert(virt_lines, { { "", "Normal" } })
        table.insert(virt_lines, { { "Linked mentions:", "Comment" } })
        table.insert(virt_lines, { { "", "Normal" } })
        for _, mention in ipairs(mentions) do
            table.insert(virt_lines, { { "[[" .. mention .. "]]", "Comment" } })
        end
    end

    if #dailies > 0 then
        table.insert(virt_lines, { { "", "Normal" } })
        table.insert(virt_lines, { { "Daily mentions:", "Comment" } })
        table.insert(virt_lines, { { "", "Normal" } })
        for _, daily in ipairs(dailies) do
            table.insert(virt_lines, { { "[[" .. daily .. "]]", "Comment" } })
        end
    end

    if #virt_lines > 0 then
        vim.api.nvim_buf_set_extmark(bufnr, ns_id, last_line, 0, {
            virt_lines = virt_lines,
        })
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
vim.keymap.set("n", "<leader>nsi", find_index_notes, { desc = "Find index notes" })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    pattern = "*.md",
    callback = function()
        vim.keymap.set("n", "<leader>nsh", headlines, { desc = "Search headlines", buffer = true })
    end,
})

-- LOCAL KEYMAPS
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    pattern = BASE_DIR .. "/*.md",
    callback = function()
        vim.keymap.set("n", "<localleader>td", function()
            process_task(complete_task)
        end, { desc = "Set task as completed", buffer = true })
    end,
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    pattern = BASE_DIR .. "/*.md",
    callback = function()
        vim.keymap.set("n", "<localleader>tc", function()
            process_task(cancel_task)
        end, { desc = "Set task as cancelled", buffer = true })
    end,
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    pattern = "*.md",
    callback = function()
        vim.keymap.set({ "n", "i" }, "<M-i><M-t>", function()
            local time = os.date("%H:%M")

            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            local line = vim.api.nvim_get_current_line()

            -- insert time at cursor position
            local new_line = line:sub(1, col) .. time .. line:sub(col + 1)

            vim.api.nvim_set_current_line(new_line)

            -- move cursor to end of inserted time
            vim.api.nvim_win_set_cursor(0, { row, col + #time })
        end, { desc = "Insert current time", buffer = true })
    end,
})

-- COMMANDS
vim.api.nvim_create_user_command("RefileAllTasksToDailyNote", function(_)
    move_daily_tasks_to_current_day()
end, { nargs = 0, desc = "Moves all the tasks in the daily dir to the current daily note" })

-- QOL FUNCTIONS

-- Display backlinks
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
    pattern = BASE_DIR .. "/*.md",
    callback = function()
        display_backlinks()
    end,
})
