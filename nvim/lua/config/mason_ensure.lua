-- Simple central accumulator for mason-tool-installer
local M = {
  tools = {},      -- set-style table
  order = {},      -- optional, for stable ordering
}

function M.add(list)
  for _, name in ipairs(list or {}) do
    if not M.tools[name] then
      M.tools[name] = true
      table.insert(M.order, name)
    end
  end
end

function M.list()
  -- stable ordering; or return vim.tbl_keys(M.tools)
  return M.order
end

return M
