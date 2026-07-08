local uv = vim.uv or vim.loop

local M = {}

--- Return the topmost (highest) directory that contains a .git (dir or file)
---@param startpath string
---@return string|nil
function M.find_highest_git_ancestor(startpath)
  if type(startpath) ~= 'string' or startpath == '' then return nil end
  local current = startpath
  local highest
  while current do
    local gitpath = current .. '/.git'
    local stat = uv.fs_stat(gitpath)
    if stat and (stat.type == 'directory' or stat.type == 'file') then
      highest = current
    end
    local parent = vim.fs.dirname(current)
    if parent == current then break end
    current = parent
  end
  return highest
end

--- Find the highest (closest to filesystem root) directory containing any of the given markers.
---@param startpath string
---@param patterns string[]
---@return string|nil
local function find_highest_marker(startpath, patterns)
  local current = startpath
  local highest
  while current do
    for _, pattern in ipairs(patterns) do
      local stat = uv.fs_stat(current .. '/' .. pattern)
      if stat then
        highest = current
        break
      end
    end
    local parent = vim.fs.dirname(current)
    if parent == current then break end
    current = parent
  end
  return highest
end

--- Build a root detector for vim.lsp.config's root_dir.
--- Prefers the highest marker file (closest to fs root), falls back to highest git ancestor.
---@param patterns string[]
function M.get_root_dir(patterns)
  return function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local startpath = fname ~= '' and vim.fs.dirname(fname) or uv.cwd()

    local marker_root = find_highest_marker(startpath, patterns)
    if marker_root then
      return on_dir(marker_root)
    end

    local git_root = M.find_highest_git_ancestor(startpath)
    return on_dir(git_root)
  end
end

return M
