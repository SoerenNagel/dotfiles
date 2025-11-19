local get_env = function()
  local _ = require 'mason-core.functional'
  local path = require 'mason-core.path'
  local fs = require 'mason-core.fs'
  local workspace_dir = config.root_dir

  local env_path = config.julia_env_path and vim.fn.expand(config.julia_env_path)
  if not env_path then
    local file_exists = _.compose(fs.sync.file_exists, path.concat, _.concat { workspace_dir })
    if
      (file_exists { 'Project.toml' } and file_exists { 'Manifest.toml' })
      or (file_exists { 'JuliaProject.toml' } and file_exists { 'JuliaManifest.toml' })
    then
      print 'second try to get env found Project/Manifest'
      env_path = workspace_dir
      print('second try to get env', env_path)
    end
  end

  if not env_path then
    local ok, env = pcall(vim.fn.system, {
      'julia',
      '--startup-file=no',
      '--history-file=no',
      '-e',
      'using Pkg; print(dirname(Pkg.Types.Context().env.project_file))',
    }) --This julia code runs fine!!
    if ok then
      print('third try to get env', env)
      env_path = env
    end
  end

  return env_path
end
