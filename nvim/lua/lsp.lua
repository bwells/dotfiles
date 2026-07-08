local M = {}

-- Initialize the disabled_servers table if it doesn't exist
vim.g.disabled_servers = vim.g.disabled_servers or {}

-- Function to globally disable a language server
local function disable_language_server(server_name)
  local disabled_servers = vim.g.disabled_servers or {}
  disabled_servers[server_name] = true
  vim.g.disabled_servers = disabled_servers

  -- Disable the server and stop any running clients
  vim.lsp.enable(server_name, false)
end

-- Function to enable a previously disabled language server
local function enable_language_server(server_name)
  local disabled_servers = vim.g.disabled_servers or {}
  disabled_servers[server_name] = nil
  vim.g.disabled_servers = disabled_servers

  -- Restart the server
  vim.lsp.enable(server_name)
end

-- Create user commands
vim.api.nvim_create_user_command('LspDisableGlobal', function(opts)
  disable_language_server(opts.args)
end, {
  nargs = 1,
  complete = function()
    local clients = vim.lsp.get_clients()
    local disabled_servers = vim.g.disabled_servers or {}
    local active_servers = {}

    for _, client in pairs(clients) do
      if not disabled_servers[client.name] then
        table.insert(active_servers, client.name)
      end
    end

    return active_servers
  end
})

vim.api.nvim_create_user_command('LspEnableGlobal', function(opts)
  enable_language_server(opts.args)
end, {
  nargs = 1,
  complete = function()
    local disabled_servers = vim.g.disabled_servers or {}
    local servers = {}

    for server_name, _ in pairs(disabled_servers) do
      table.insert(servers, server_name)
    end

    return servers
  end
})

-- Aliases for removed nvim-lspconfig commands
vim.api.nvim_create_user_command('LspInfo', function() vim.cmd('checkhealth vim.lsp') end, {})
vim.api.nvim_create_user_command('LspRestart', function() vim.cmd('lsp restart') end, {})
vim.api.nvim_create_user_command('LspLog', function() vim.cmd('edit ' .. vim.lsp.log.get_filename()) end, {})

return M
