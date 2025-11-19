local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local make_entry = require 'telescope.make_entry'
local conf = require('telescope.config').values

local M = {}

local script_path = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'plugins', 'telescope', 'search.jl')

-- This function creates the name of the cashefile
-- This function is a seperate julia call, whichshould be eliminated
local function get_cache_file()
  -- crate cache dir if it does not exist
  local cache_dir = vim.fs.joinpath(vim.fn.stdpath 'cache', 'julia_search')
  vim.fn.mkdir(cache_dir, 'p')

  -- get the path to the Manifest.toml
  -- This function is a seperate julia call, whichshould be eliminated
  local manifest_cmd = 'julia --project -e \'using Pkg; print(joinpath(dirname(Pkg.project().path), "Manifest.toml"))\''
  local manifest_path = vim.fn.trim(vim.fn.system(manifest_cmd))
  print(manifest_path)

  if manifest_path == '' or vim.fn.filereadable(manifest_path) == 0 then
    vim.notify('Could not find Manifest.toml.', vim.log.levels.WARN)
    return nil
  end

  local hash_cmd = 'shasum -a 256 ' .. vim.fn.shellescape(manifest_path) .. " | cut -d' ' -f1"
  local manifest_hash = vim.fn.trim(vim.fn.system(hash_cmd))

  if manifest_hash == '' then
    vim.notify('Could not hash Manifest.toml. Is `shasum` installed?', vim.log.levels.WARN)
    return nil
  end
  return vim.fs.joinpath(cache_dir, manifest_hash)
end

local julia_help_grep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == '' then
        return nil
      end
      -- now we have to setup the the command itself
      local cache_file = get_cache_file()
      if cache_file == nil then
        return
      end
      if vim.fn.filereadable(cache_file) == 0 then
        --create the cache file
        local cache_cmd = 'julia --project ' .. script_path
        vim.fn.system(cache_cmd)
      end
      local args = { 'rg' }
      table.insert(args, '-e')
      table.insert(args, prompt)
      local kwargs = { args, { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' } }
      return kwargs:flatten()
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }
  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = 'Multi Grep',
      finders = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require('telescope.sorters').empty(),
    })
    :find()
end

M.setup = function()
  vim.keymap('n', '<leader>fg', julia_help_grep())
end

return M
