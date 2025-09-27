local pickers = require("telescope.pickers")
local conf = require("telescope.config").values

local utilities = require("copy_path.utilities")
local copy_actions = require("copy_path.actions")
local copy_finders = require("copy_path.finders")
local copy_previewers = require("copy_path.previewers")

local M = {}

function M.copy_path(opts)
	opts = opts or {}

	if not utilities.is_file_open() then
		vim.notify("No file is currently open")
		return
	end

	pickers
		.new(opts, {
			prompt_title = "Copy File Path",
			results_title = "<CR>:copy",
			finder = copy_finders.create_path_finder(),
			sorter = conf.generic_sorter(opts),
			previewer = copy_previewers.create_path_previewer(),
			attach_mappings = copy_actions.attach_mappings,
		})
		:find()
end

return M
