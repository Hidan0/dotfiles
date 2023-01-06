local setup, bufferline = pcall(require, "bufferline")
if not setup then
	return
end

bufferline.setup({
	options = {
		diagnostics = "nvim_lsp",
		offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		separator_style = "slant",
		always_show_bufferline = true,
	},
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
})
