local status, lsp = pcall(require, "lsp-zero")
if not status then
	return
end

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"lua_ls",
})

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

local status_rstools, rstools = pcall(require, "rust-tools")
if not status_rstools then
	return
end

rstools.setup({
	tools = {
		inlay_hints = {
			auto = false,
		},
	},
	server = {
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
})

local status_inlayhints, inlay_hints = pcall(require, "lsp-inlayhints")
if not status_inlayhints then
	return
end

inlay_hints.setup({
	inlay_hints = {
		parameter_hints = {
			prefix = "<- ",
			separator = ", ",
		},
		type_hints = {
			prefix = "<T> ",
			separator = ", ",
			remove_colon_start = true,
		},
	},
})

--------
-- CMP
--------
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-b>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-e>"] = cmp.mapping.abort(),
})

local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})

local keymap = vim.keymap
lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false, noremap = true, silent = true }

	if client.name == "eslint" then
		vim.cmd.LspStop("eslint")
		return
	end

	keymap.set("n", "gD", function()
		vim.lsp.buf.declaration()
	end, opts) -- got to declaration
	keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts) -- see definition and make edits in window
	keymap.set("n", "gi", function()
		vim.lsp.buf.implementation()
	end, opts) -- go to implementation
	keymap.set("n", "gr", function()
		vim.lsp.buf.references()
	end, opts) -- go to implementation
	keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, opts) -- see available code actions
	keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts) -- smart rename
	keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float()
	end, opts) -- show diagnostics for cursor
	keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts) -- show documentation for what is under cursor
	keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
	keymap.set("n", "<leader>ws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)

	if client.name == "rust_analyzer" then
		keymap.set("n", "<leader>ca", rstools.code_action_group.code_action_group, opts)
		keymap.set("n", "K", rstools.hover_actions.hover_actions, opts)
	end

	inlay_hints.on_attach(client, bufnr)
end)

lsp.setup()

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.opt.completeopt = "menu,menuone,noselect"
