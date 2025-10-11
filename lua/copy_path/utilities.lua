local M = {}

-- Get the line range information
-- Returns a string like "#L10" or "#L10-L20" for visual range
function M.get_line_info(mode)
	mode = mode or vim.fn.mode()

	-- Check if we're in visual mode or have a visual selection
	if mode == "v" or mode == "V" or mode == "\22" then -- \22 is <C-v>
		local start_line = vim.fn.line("'<")
		local end_line = vim.fn.line("'>")

		if start_line == end_line then
			return "#L" .. start_line
		else
			return "#L" .. start_line .. "-L" .. end_line
		end
	else
		-- Normal mode, use current line
		return "#L" .. vim.fn.line(".")
	end
end

function M.get_current_file_paths(mode)
	local current_file = vim.api.nvim_buf_get_name(0)
	if current_file == "" then
		return {}
	end

	local line_info = M.get_line_info(mode)

	local relative_path = vim.fn.fnamemodify(current_file, ":.")
	local relative_path_with_line = relative_path .. line_info
	local home_relative_path = vim.fn.fnamemodify(current_file, ":~")
	local home_relative_path_with_line = home_relative_path .. line_info

	return {
		{ display = "relative path", path = relative_path },
		{ display = "relative path with line", path = relative_path_with_line },
		{ display = "home-relative path", path = home_relative_path },
		{ display = "home-relative path with line", path = home_relative_path_with_line },
		{ display = "absolute path", path = vim.fn.fnamemodify(current_file, ":p") },
		{ display = "filename only", path = vim.fn.fnamemodify(current_file, ":t") },
		{ display = "current directory", path = vim.fn.fnamemodify(current_file, ":h") },
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
