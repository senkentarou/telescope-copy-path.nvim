local finders = require("telescope.finders")
local utilities = require("copy_path.utilities")

local M = {}

function M.create_path_finder(mode)
	local paths = utilities.get_current_file_paths(mode)

	return finders.new_table({
		results = paths,
		entry_maker = function(entry)
			return {
				value = entry.path,
				display = entry.display,
				ordinal = entry.display,
			}
		end,
	})
end

return M
