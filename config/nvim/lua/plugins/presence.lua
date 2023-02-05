local setup, presence = pcall(require, "presence")
if not setup then
	return
end

presence.setup({
	main_image = "file",
	neovim_image_text = "I don't know how to exit vim",
})
