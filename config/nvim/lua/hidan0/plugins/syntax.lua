return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main", -- explicitly target the new rewritten branch
        build = ":TSUpdate",
        init = function()
            -- Parser installation (replaces ensure_installed)
            local parsers = {
                "json",
                "javascript",
                "typescript",
                "tsx",
                "yaml",
                "html",
                "css",
                "scss",
                "markdown",
                "markdown_inline",
                "bash",
                "lua",
                "vim",
                "dockerfile",
                "gitignore",
                "rust",
                "go",
                "c",
                "latex",
                "typst",
            }

            local installed = require("nvim-treesitter.config").get_installed()
            local to_install = vim.iter(parsers)
                :filter(function(p)
                    return not vim.tbl_contains(installed, p)
                end)
                :totable()

            if #to_install > 0 then
                require("nvim-treesitter").install(to_install)
            end

            -- Enable highlighting and (optionally) indentation per filetype
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            vim.o.foldcolumn = "1" -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            -- To show number of folded lines
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (" 󰁂 %d "):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end

            local ufo = require("ufo")

            vim.keymap.set("n", "zK", ufo.peekFoldedLinesUnderCursor, { desc = "Peek Folded Lines" })
            vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
            vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
            vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, { desc = "Close folds with" })
            vim.keymap.set("n", "zm", ufo.closeFoldsWith, { desc = "Close folds with" })

            ufo.setup({
                provider_selector = function(_, filetype, _)
                    if filetype == "markdown" then
                        return { "treesitter", "indent" }
                    end

                    return { "lsp", "indent" }
                end,
                fold_virt_text_handler = handler,
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                python = { "pylint" },
                lua = { "luacheck" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })

            vim.keymap.set("n", "<leader>l", function()
                lint.try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },
}
