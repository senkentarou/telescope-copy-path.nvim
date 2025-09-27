local M = {}

function M.get_current_file_paths()
	local current_file = vim.api.nvim_buf_get_name(0)
	if current_file == "" then
		return {}
	end

	return {
		{ display = "Relative Path", path = vim.fn.fnamemodify(current_file, ":.") },
		{ display = "Absolute Path", path = vim.fn.fnamemodify(current_file, ":p") },
		{ display = "Filename Only", path = vim.fn.fnamemodify(current_file, ":t") },
		{ display = "Directory", path = vim.fn.fnamemodify(current_file, ":h") },
	}
end

function M.copy_to_clipboard(text)
	vim.fn.setreg("+", text)
	vim.fn.setreg('"', text)
	vim.notify("Copied to clipboard: " .. text)
end

function M.is_file_open()
	local current_file = vim.api.nvim_buf_get_name(0)
	return current_file ~= ""
end

return M
