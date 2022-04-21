-- dumb script for linking dotfiles

local lfs = require("lfs")

local function is_in_blacklist(file)
	for _, value in pairs({ ".", "..", ".git", ".gitmodules", ".gitignore", "LICENSE", "README.md", "link_dot.lua" }) do
		if file == value then
			return true
		end
	end
	return false
end

local PATH = lfs.currentdir()
local HOME = "/home/hidan0/"

for file in lfs.dir(PATH) do
	if not is_in_blacklist(file) then
		print(file)
		if lfs.attributes(file, "mode") == "directory" and file == "config" then
			-- dirs for $HOME/.config
			print(string.format("Found 'config': %s/%s", PATH, file))

			local CONF = PATH .. "/" .. file
			for c_dir in lfs.dir(CONF) do
				if c_dir == "." or c_dir == ".." then
					goto continue
				end
				print("Processing '" .. c_dir .. "'")
				if lfs.attributes(HOME .. ".config/" .. c_dir, "mode") == "directory" then -- works with links
					print("Found directory " .. c_dir)
					local n_dir = "old_" .. os.date("%d-%m-%y_%H-%m") .. "_" .. c_dir -- new dir name
					os.execute(string.format("mv %s.config/%s %s.config/%s", HOME, c_dir, HOME, n_dir))
					print("Renamed to " .. n_dir)
				else
					print("'" .. c_dir .. "' not found.")
				end
				print("Linking " .. c_dir)
				lfs.link(CONF .. "/" .. c_dir, HOME .. ".config/" .. c_dir, true)
				::continue::
			end
		elseif lfs.attributes(file, "mode") == "file" then
			-- files for $HOME
			print("Processing '" .. file .. "'")
			if lfs.attributes(HOME .. file, "mode") == "file" then -- works with links
				print("Found file " .. file)
				local n_file = "old_" .. os.date("%d-%m-%y_%H-%m") .. "_" .. file -- new file name
				os.execute(string.format("mv %s/%s %s/%s", HOME, file, HOME, n_file))
				print("Renamed to " .. n_file)
			else
				print("'" .. file .. "' not found.")
			end
			print("Linking " .. file)
			lfs.link(PATH .. "/" .. file, HOME .. file, true)
		end
	end
end
