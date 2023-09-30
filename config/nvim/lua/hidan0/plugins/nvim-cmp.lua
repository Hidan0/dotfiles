local border = require("hidan0.utils.borders")
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    {
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets", -- useful snippets
      version = "2.*",
      build = "make install_jsregexp",
    }, -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "onsails/lspkind.nvim", -- vs-code like pictograms
    { "zbirenbaum/copilot-cmp", config = true },
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      performance = {
        debounce = 150,
      },
      completion = {
        completeopt = "menu,menuone",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<C-y>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      -- sources for autocompletion
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
        { name = "copilot" },
        -- crates are loaded from a different file
      },
      formatting = {
        format = function(entry, vim_item)
          local custom_kinds = {
            Copilot = "",
          }

          vim_item.kind =
            string.format("%s %s", lspkind.presets.default[vim_item.kind] or custom_kinds[vim_item.kind], vim_item.kind)
          vim_item.menu = ({
            nvim_lsp = "󱐌",
            luasnip = "",
            path = "",
            buffer = "",
            crates = "󰆨",
            copilot = "",
          })[entry.source.name]

          return vim_item
        end,
      },
      window = {
        completition = {
          border = border("CmpBorder"),
        },
        documentation = {
          border = border("CmpDocBorder"),
        },
      },
    })
  end,
}
