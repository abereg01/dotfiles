local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "dockerfile-language-server",
        "yaml-language-server",
        "bash-language-server",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "dockerfile",
        "yaml",
        "bash",
        "json",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
  },
}

return plugins
