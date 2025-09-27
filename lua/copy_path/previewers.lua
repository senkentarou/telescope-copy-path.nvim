local previewers = require("telescope.previewers")

local M = {}

function M.create_path_previewer()
	return previewers.new_buffer_previewer({
		title = "Path Preview",
		define_preview = function(self, entry, _)
			vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { entry.value })
		end,
	})
end

return M
