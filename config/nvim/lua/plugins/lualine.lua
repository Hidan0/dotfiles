local status, lualine = pcall(require, "lualine")
if not status then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "catppuccin",
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "undotree" },
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
})
