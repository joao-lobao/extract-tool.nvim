local M = {}

M.config = {
	keymaps = {
		extract = "<leader>e",
	},
}

local feedkeys = function(extract_as)
	vim.api.nvim_command("normal! ]}")
	vim.api.nvim_command("normal! o\n" .. extract_as)
	vim.api.nvim_command("normal! P`[=`]")
end

local create = function(as, to)
	vim.cmd("normal! d")
	if to == "file" then
		local fname = vim.fn.input("Enter file name: ", vim.fn.expand("%:p:h"), "file")
		vim.cmd("e " .. fname)
	end
	feedkeys(as)
end

local map_as = {
	[1] = {
		name = "1. as_class",
		extract = function()
			create("class Name {\n}")
		end,
	},
	[2] = {
		name = "2. as_function",
		extract = function()
			create("function name() {\n}")
		end,
	},
	[3] = {
		name = "3. to_file_as_class",
		extract = function()
			create("class Name {\n}", "file")
		end,
	},
	[4] = {
		name = "4. to_file_as_function",
		extract = function()
			create("function name() {\n}", "file")
		end,
	},
	[5] = {
		name = "5. as_method",
		extract = function()
			create("name() {\n}")
		end,
	},
}

function M.extract(as, to)
	if as ~= nil then
		create(as, to)
		return
	end
	local pick = vim.fn.inputlist({
		"Extract as: ",
		map_as[1].name,
		map_as[2].name,
		map_as[3].name,
		map_as[4].name,
		map_as[5].name,
	})
	if pick ~= nil and pick > 0 then
		map_as[pick].extract()
	end
end

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})

	local keymap_opts = { noremap = true, silent = true }
	if M.config.keymaps.extract ~= nil then
		vim.api.nvim_set_keymap(
			"v",
			M.config.keymaps.extract,
			"<cmd>lua require('extract-tool').extract()<CR>",
			keymap_opts
		)
	end
end

return M
