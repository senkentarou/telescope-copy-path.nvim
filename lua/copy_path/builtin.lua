local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

local M = {}

local function get_current_file_paths()
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

local function copy_to_clipboard(text)
	vim.fn.setreg("+", text)
	vim.fn.setreg('"', text)
	vim.notify("Copied to clipboard: " .. text)
end

function M.copy_path(opts)
	opts = opts or {}

	local current_file = vim.api.nvim_buf_get_name(0)
	if current_file == "" then
		vim.notify("No file is currently open")
		return
	end

	local paths = get_current_file_paths()

	pickers
		.new(opts, {
			prompt_title = "Copy File Path",
			results_title = "<CR>:cppy",
			finder = finders.new_table({
				results = paths,
				entry_maker = function(entry)
					return {
						value = entry.path,
						display = entry.display,
						ordinal = entry.display,
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			previewer = previewers.new_buffer_previewer({
				title = "Path Preview",
				define_preview = function(self, entry, _)
					-- Add file content preview if it's a file path
					vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { entry.value })
				end,
			}),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					copy_to_clipboard(selection.value)
				end)

				return true
			end,
		})
		:find()
end

return M
