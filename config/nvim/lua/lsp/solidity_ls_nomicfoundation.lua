-- Read remappings from remappings.txt
local function read_remappings_txt(root_dir)
  local remappings = {}
  local file = io.open(root_dir .. '/remappings.txt', 'r')
  if not file then return remappings end

  for line in file:lines() do
    if line:match '^%s*[^%s#]' then
      local from_path, to_path = line:match '([^=]+)=(.+)'
      if from_path and to_path then
        from_path = from_path:gsub('^%s*(.-)%s*$', '%1')
        to_path = to_path:gsub('^%s*(.-)%s*$', '%1')
        table.insert(remappings, from_path .. '=' .. to_path)
      end
    end
  end

  file:close()
  return remappings
end

-- Read remappings from foundry.toml
local function read_foundry_toml(root_dir)
  local remappings = {}
  local file = io.open(root_dir .. '/foundry.toml', 'r')
  if not file then return remappings end

  local in_profile = false
  for line in file:lines() do
    if line:match '^%[profile%.' then
      in_profile = true
    elseif line:match '^%[' then
      in_profile = false
    end

    if not in_profile or line:match '^%[profile%.default%]' then
      if line:match '^remappings%s*=%s*%[' then
        local content = line:match '%[(.*)%]'
        if content then
          for remapping in content:gmatch '[^,]+' do
            remapping = remapping:gsub('"', ''):gsub("'", ''):gsub('^%s*(.-)%s*$', '%1')
            if remapping ~= '' then
              table.insert(remappings, remapping)
            end
          end
        end
      end
    end
  end

  file:close()
  return remappings
end

local function get_remappings(root_dir)
  local remappings = read_remappings_txt(root_dir)
  if #remappings == 0 then
    remappings = read_foundry_toml(root_dir)
  end
  return remappings
end

return {
  cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
  filetypes = { 'solidity' },
  root_markers = { 'hardhat.config.*', 'foundry.toml', 'remappings.txt', 'forge.toml', '.git' },
  single_file_support = true,
  on_init = function(client)
    local root_dir = client.config.root_dir
    if root_dir then
      local remappings = get_remappings(root_dir)
      client.config.settings = client.config.settings or {}
      client.config.settings.solidity = client.config.settings.solidity or {}
      client.config.settings.solidity.remappings = remappings
      client:notify('workspace/didChangeConfiguration', { settings = client.config.settings })
    end
  end,
  settings = {
    solidity = {
      formatter = { defaultFormatter = 'forge' },
      validationRules = {
        validateUnusedVariables = 'warn',
        disambiguateIdentifiers = 'warn',
        declarationOrder = 'warn',
        compilerSettings = {
          optimizer = { enabled = true, runs = 200 },
          evmVersion = 'cancun',
        },
      },
    },
  },
}
