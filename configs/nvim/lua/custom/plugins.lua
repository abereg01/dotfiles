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
  {
    "kevinhwang91/nvim-bqf", -- Better quickfix
    event = "VeryLazy",
  },
    {
    "chrisbra/csv.vim", -- CSV handling
    ft = "csv",
  },
  {
    "mhinz/vim-ssh",
    lazy = false,
    config = function()
      vim.g.ssh_configurations = {
        ["DSM01"] = "172.20.0.21"
      }
    end
  },  
  {
    "preservim/vimux",
    lazy = false,
  },
}

return plugins
