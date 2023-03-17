local status, mason_null_ls = pcall(require, "mason-null-ls")
if not status then
	return
end

mason_null_ls.setup({
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
		"rustfmt",
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})
