require 'core.keymaps'
require 'core.options'
require 'core.autocommands'
require 'core.lazy_setup' -- Installs Lazy if not available
require 'plugins.floaterm'

-- [[ Configure and install plugins ]]
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  require 'plugins.gitsigns',

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.
  require 'plugins.whichkey',

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  require 'plugins.telescope',

  -- LSP Plugins
  require 'lsp.lazy_dev',
  require 'lsp.lsp_config',
  require 'plugins.auto_format',
  require 'plugins.auto_completion',

  -- Theme
  require 'plugins.theme',

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  require 'plugins.mini-nvim',
  require 'core.treesitter',
  -- For additional information with loading, sourcing and examples in normal mode
  -- type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search

  -- Better Markdown
  require 'plugins.markdown',
  require 'plugins.lazygit',

  -- latex support
  require 'plugins.vimtex',
  require 'plugins.tex-conceal',
  require 'plugins.ultisnip',

  -- Oil.nvim for files
  require 'plugins.oil',
  -- tunnell for code execution
  require 'plugins.tunnell',
}, {
  ui = require 'core.ui',
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
