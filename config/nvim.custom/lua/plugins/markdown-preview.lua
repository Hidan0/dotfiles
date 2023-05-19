local setup, m_preview = pcall(require, "markdown-preview.nvim")
if not setup then
	return
end

m_preview.setup({})
