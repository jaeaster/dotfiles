local M = {}

local function file_exists(file)
  local f = io.open(file, 'rb')
  if f then
    f:close()
  end
  return f ~= nil
end

local function get_remappings(file)
  if not file_exists(file) then
    return {}
  end

  local remappings = {}
  for remapping in io.lines(file) do
    for from, to in string.gmatch(remapping, '(.+)=(.+)') do
      table.insert(remappings, { context = '', prefix = from, target = to })
    end
  end

  return remappings
end

M.setup = function(on_attach, capabilities)
  require('lspconfig')['solc'].setup {
    on_init = function(client)
      local project_root = client.workspace_folders[1].name
      local lib_path = project_root .. '/lib'
      local node_modules_path = project_root .. '/node_modules'
      local remappings_path = project_root .. '/remappings.txt'
      local remappings = get_remappings(remappings_path)

      client.config.settings['include-paths'] = { lib_path, node_modules_path }
      client.config.settings['remappings'] = remappings

      client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
      return true
    end,
    settings = {
      ['include-paths'] = {},
      ['remappings'] = {},
    },
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

return M
