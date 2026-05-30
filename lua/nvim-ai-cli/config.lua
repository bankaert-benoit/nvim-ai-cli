local M = {}

local defaults = {
  cmd = nil,
  width = 40,
  side = "right",
}

M.values = {}

function M.merge(opts)
  opts = opts or {}
  M.values = vim.tbl_deep_extend("keep", vim.deepcopy(opts), vim.deepcopy(defaults))
  return M.values
end

return M
