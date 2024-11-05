local M = {}

-- Function to read remappings from remappings.txt
local function read_remappings_txt(root_dir)
  local remappings_path = root_dir .. '/remappings.txt'
  local remappings = {}

  local file = io.open(remappings_path, 'r')
  if not file then
    return remappings
  end

  for line in file:lines() do
    -- Skip empty lines and comments
    if line:match '^%s*[^%s#]' then
      local from_path, to_path = line:match '([^=]+)=(.+)'
      if from_path and to_path then
        -- Trim whitespace
        from_path = from_path:gsub('^%s*(.-)%s*$', '%1')
        to_path = to_path:gsub('^%s*(.-)%s*$', '%1')
        table.insert(remappings, from_path .. '=' .. to_path)
      end
    end
  end

  file:close()
  return remappings
end

-- Function to read remappings from foundry.toml
local function read_foundry_toml(root_dir)
  local foundry_path = root_dir .. '/foundry.toml'
  local remappings = {}

  local file = io.open(foundry_path, 'r')
  if not file then
    return remappings
  end

  local in_profile = false
  for line in file:lines() do
    -- Handle profile sections
    if line:match '^%[profile%.' then
      in_profile = true
    elseif line:match '^%[' then
      in_profile = false
    end

    -- Only process remappings outside of profiles or in default profile
    if not in_profile or line:match '^%[profile%.default%]' then
      -- Look for remappings array
      if line:match '^remappings%s*=%s*%[' then
        -- Extract content between brackets
        local content = line:match '%[(.*)%]'
        if content then
          -- Split by comma and process each remapping
          for remapping in content:gmatch '[^,]+' do
            -- Clean up the remapping string
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

-- Function to get all remappings
local function get_remappings(root_dir)
  -- Try remappings.txt first
  local remappings = read_remappings_txt(root_dir)

  -- If no remappings found, try foundry.toml
  if #remappings == 0 then
    remappings = read_foundry_toml(root_dir)
  end

  return remappings
end

M.setup = function(on_attach, capabilities)
  require('lspconfig').solidity_ls_nomicfoundation.setup {
    cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
    filetypes = { 'solidity' },
    root_dir = require('lspconfig.util').root_pattern(
      'hardhat.config.*',
      'foundry.toml',
      'remappings.txt',
      'forge.toml',
      '.git'
    ),
    single_file_support = true,
    on_new_config = function(new_config, new_root_dir)
      -- Get remappings when the config is created
      local remappings = get_remappings(new_root_dir)
      new_config.settings = new_config.settings or {}
      new_config.settings.solidity = new_config.settings.solidity or {}
      new_config.settings.solidity.remappings = remappings
    end,
    settings = {
      solidity = {
        formatter = {
          defaultFormatter = 'forge',
        },
        validationRules = {
          validateUnusedVariables = 'warn',
          disambiguateIdentifiers = 'warn',
          declarationOrder = 'warn',
          compilerSettings = {
            optimizer = {
              enabled = true,
              runs = 200,
            },
            evmVersion = 'cancun',
          },
        },
      },
    },
    on_attach = function(client, bufnr)
      -- Call the original on_attach function
      on_attach(client, bufnr)

      -- Additional Solidity-specific keymaps can go here
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      -- vim.keymap.set(
      --   'n',
      --   '<leader>t',
      --   "<cmd>lua require('lspconfig').solidity_ls_nomicfoundation.commands.test()<CR>",
      --   bufopts
      -- )
    end,
    capabilities = capabilities,
  }
end

return M
