local function Base64Transform(type, operation)
	local save_cursor = vim.fn.getcurpos()
	local old_reg = vim.fn.getreg("")

	if type == "v" then
		vim.cmd("normal! gvy")
	elseif type == "V" then
		vim.cmd("normal! Vy")
	elseif type == "char" then
		vim.cmd("normal! `[v`]y")
	else
		vim.cmd("normal! `[v`]y")
	end

	local ok, result
	if operation == 'encode' then
		ok, result = pcall(function()
			return vim.fn.systemlist("echo -n " .. vim.fn.shellescape(vim.fn.getreg("")) .. " | base64 -w 0")
		end)
	else
		ok, result = pcall(function()
			return vim.fn.systemlist("echo -n " .. vim.fn.shellescape(vim.fn.getreg("")) .. " | base64 -d")
		end)
	end

	if ok then
		local exit_code = vim.v.shell_error
		if exit_code == 0 then
			local transformed = table.concat(result, "\n")
			vim.cmd("normal! gvc" .. transformed)
		else
			vim.api.nvim_err_writeln("base64: invalid input")
		end
	end

	vim.fn.setreg("", old_reg)
	vim.fn.setpos(".", save_cursor)
end

function Base64Encode(type)
	Base64Transform(type, "encode")
end

function Base64Decode(type)
	Base64Transform(type, "decode")
end

vim.api.nvim_set_keymap("n", "[4", "<Cmd>set opfunc=v:lua.Base64Encode<CR>g@", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]4", "<Cmd>set opfunc=v:lua.Base64Decode<CR>g@", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[44", "<Cmd>set opfunc=v:lua.Base64Encode<CR>0g@$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]44", "<Cmd>set opfunc=v:lua.Base64Decode<CR>0g@$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "[4", "<Cmd>lua Base64Encode(vim.fn.visualmode())<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "]4", "<Cmd>lua Base64Decode(vim.fn.visualmode())<CR>", { noremap = true, silent = true })
