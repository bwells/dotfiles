local lspconfig_util = require 'lspconfig.util'
local uv = vim.uv or vim.loop


local M = {}

-- Helper function to check if a path is a git directory or worktree
local function is_git_path(path)
  local gitpath = lspconfig_util.path.join(path, '.git')
  return vim.fn.isdirectory(gitpath) == 1 or (uv.fs_stat(gitpath) or {}).type == 'file'
end

--- Finds the git ancestor closest to the root directory
--- @param startpath string: The starting path to search from
--- @return string|nil: Returns the highest git ancestor path found, or nil if none found
function M.find_highest_git_ancestor(startpath)
  -- Validate input
  if not startpath or type(startpath) ~= 'string' then
    return nil
  end

  local current_path = startpath
  local highest_git = nil

  -- Keep searching until we reach the root
  while current_path do
    if is_git_path(current_path) then
      highest_git = current_path
    end

    -- Get parent directory
    local parent = lspconfig_util.path.dirname(current_path)

    -- Break if we've reached the root (parent same as current)
    if parent == current_path then
      break
    end

    current_path = parent
  end

  return highest_git
end

-- Helper function that combines git ancestor detection with pattern matching
function M.get_root_dir(patterns)
  return function(fname)
    -- First check for the highest git ancestor
    local git_root = M.find_highest_git_ancestor(fname)
    if git_root then
      return git_root
    end

    -- Fallback to pattern matching if no git root found
    return lspconfig_util.root_pattern(patterns)(fname)
  end
end

return M
