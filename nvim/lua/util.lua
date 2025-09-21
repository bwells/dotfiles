local lspconfig_util = require 'lspconfig.util'
local uv = vim.uv or vim.loop

local M = {}

local function is_git_path(path)
  local gitpath = lspconfig_util.path.join(path, '.git')
  return vim.fn.isdirectory(gitpath) == 1 or (uv.fs_stat(gitpath) or {}).type == 'file'
end

--- Return the topmost (highest) directory that contains a .git (dir or file)
---@param startpath string
---@return string|nil
function M.find_highest_git_ancestor(startpath)
  if type(startpath) ~= 'string' or startpath == '' then return nil end
  local current = startpath
  local highest
  while current do
    if is_git_path(current) then highest = current end
    -- local parent = lspconfig_util.path.dirname(current)
    local parent = vim.fs.dirname(current)
    if parent == current then break end
    current = parent
  end
  return highest
end

--- Build a root detector that prefers the topmost git root, else marker patterns.
--- Works with BOTH signatures:
---   1) dir = fn(fname)
---   2) fn(bufnr, on_dir)  -- must call on_dir(dir)
---@param patterns string[]
function M.get_root_dir(patterns)
  -- Prebuild the marker finder (unpack the list!)
  local marker_finder = lspconfig_util.root_pattern(unpack(patterns or {}))

  -- The actual detector
  local function detect(path_like)
    -- path_like is either a filename or a directory; use it as-is
    local git_root = M.find_highest_git_ancestor(path_like)
    if git_root then
      return git_root
    end
    return marker_finder(path_like)
  end

  -- Adapter that supports both calling conventions
  return function(a, b)
    -- New core API: (bufnr, on_dir)
    if type(a) == 'number' and type(b) == 'function' then
      local bufnr, on_dir = a, b
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local dir = detect(fname ~= '' and fname or vim.loop.cwd())
      -- MUST call on_dir (pass nil to disable/skip)
      return on_dir(dir)
    end
    -- Old lspconfig style: (fname) -> dir
    local fname = a
    return detect(fname)
  end
end

return M
