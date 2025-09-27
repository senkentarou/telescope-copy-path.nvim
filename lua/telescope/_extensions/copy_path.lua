local builtin = require('copy_path.builtin')

return require('telescope').register_extension {
  exports = {
    copy_path = builtin.copy_path,
  },
}