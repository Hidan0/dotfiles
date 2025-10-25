local opts = {
    base_dir = vim.fn.expand("~/notes/second_brain"),
    daily_dir = "1_Daily",
    inbox_dir = "0_Inbox",
}

local Snacks = require("snacks")

local function uuid()
    return vim.fn.system("uuidgen"):gsub("%s+", "")
end

--- Creates a daily note if there is not one for the current day, otherwise it opens the daily note
local function open_daily_note()
    local date = os.date("*t")
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

# %s @ %s

## Tasks

## Completed Tasks
]],
            uuid(),
            day,
            date.hour .. ":" .. date.min
        )

        -- write the file
        local file = io.open(filepath, "w")
        file:write(template)
        file:close()
    end

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
        return nil, nil
    end

    local left = string.sub(s, 0, pos - 1)
    local right = string.sub(s, pos + 1)

    return left, right
end

local function find_todos()
    local query = "\\- \\[ \\]"
    local cmd = { "rg", "--vimgrep", "--no-heading", "-tmd", query, opts.base_dir }

    local res = vim.fn.systemlist(cmd)

    if vim.v.shell_error ~= 0 then
        vim.notify("ripgrep error: " .. table.concat(res, "\n"), vim.log.levels.ERROR)
        return
    end

    local items = {}
    for i, raw in ipairs(res) do
        -- assume no errors
        local file, rest = split_at(raw, ":")

        local row, rest = split_at(rest, ":")

        local col, rest = split_at(rest, ":")

        local text = string.gsub(rest, ":- [ ]", "")

        table.insert(items, {
            idx = i,
            score = i,
            pos = { tonumber(row), tonumber(col) },
            file = file,
            text = text,
        })
    end

    return Snacks.picker({
        items = items,
    })
end

-- KEYMAPS
vim.keymap.set("n", "<leader>nt", open_daily_note, { desc = "Create\\Open daily note" })
vim.keymap.set("n", "<leader>nn", new_note, { desc = "Create a new note in the inbox" })

vim.keymap.set("n", "<leader>nst", find_todos, { desc = "Find all tasks" })
