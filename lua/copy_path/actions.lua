local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local utilities = require("copy_path.utilities")

local M = {}

local function copy_selected_path(prompt_bufnr)
	actions.close(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	utilities.copy_to_clipboard(selection.value)
end

function M.attach_mappings(prompt_bufnr, _)
	actions.select_default:replace(function()
		copy_selected_path(prompt_bufnr)
	end)

	return true
end

return M
