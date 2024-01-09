return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    local theta = require("alpha.themes.theta")

    local header = {
      type = "text",
      val = {
        "⠀⠀⠀⠀⠀⠀⠀⡰⠀⠀⠀⠀⠀⢀⠀⢀⣠⠂⠀⢀⠀⣠⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀ ⣀⣼⠃⢀⢠⣄⣾⣶⣿⣆⣾⣿⢂⣶⣿⣿⡃⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀ ⢠⣶⡿⠃⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢁⣴⣤⣾⣤⣶⠞⠁⠀",
        "⠀ ⣬⣾⡿⠁⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡥⠀⠀⠀",
        " ⣠⣿⣿⠃⠀⢸⣿⡟⣿⠟⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀",
        "⢠⣾⣿⡟⠀⠀⠀⠿⠁⠿⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣾⣷⣖⣀⣀",
        "⠘⣿⣿⡇⠀⠀⠀⠀⠀⠀⢀⣀⣀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠉⠁",
        "⢺⣿⣿⣇⠀⠀⠀⠀⠀⠀⡠⢾⣿⠟⠉⠉⢸⣿⣿⣿⣿⣿⣿⣿⣿⣏⡉⠀⠀⠀",
        "⢨⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠁⠃⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡆⠀⠀",
        "⠘⢿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠙⠋⠉⠁⠀",
        "⠀⠺⣿⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡅⠀⠀⠀⠀",
        "⠀⠀⠠⣿⣿⣿⣿⣿⣿⣶⣦⣤⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⡅⠈⠈⠀⠀⠀⠀",
        "⠀⠀⠀⠈⠩⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠻⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠻⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠻⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠀⠙⠉⠀⠘⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      },
      opts = {
        position = "center",
        hl = "AlphaHeader",
      },
    }

    local footer = {
      type = "text",
      val = {
        "A good programmer looks both ways before crossing a one way street…",
        "                   then gets hit by a car that falls out of the sky.",
      },
      opts = {
        position = "center",
        hl = "AlphaFooter",
        shrink_margin = false,
      },
    }

    -- Links and tools
    local tools = {
      type = "group",
      val = {
        {
          type = "text",
          val = "-- Tools --",
          opts = {
            position = "center",
            hl = "AlphaButtons",
            shrink_margin = false,
          },
        },
        dashboard.button("l", "󰒲  > Lazy", "<cmd>Lazy<CR>"),
        dashboard.button("m", "󱊈  > Mason", "<cmd>Mason<CR>"),
        dashboard.button("t", "  > Tmux Sessionizer", "<cmd>silent !tmux neww tms<CR>"),
      },
      position = "center",
    }

    local buttons = {
      type = "group",
      val = {
        {
          type = "text",
          val = "-- Quick links --",
          opts = {
            position = "center",
            hl = "AlphaButtons",
            shrink_margin = false,
          },
        },
        dashboard.button("e", "  > New file", "<cmd>ene <CR>"),
        dashboard.button("SPC ff", "󰈞  > Find file"),
        dashboard.button("SPC fs", "  > Live grep"),
        dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
      },
    }

    local mru = {
      type = "group",
      val = {
        {
          type = "text",
          val = "-- Recent files --",
          opts = {
            position = "center",
            hl = "AlphaButtons",
            shrink_margin = false,
          },
        },
        {
          type = "group",
          val = function()
            return { theta.mru(0, vim.fn.getcwd(), 5) }
          end,
          opts = {
            shrink_margin = false,
          },
        },
      },
    }

    local config = {
      layout = {
        { type = "padding", val = 2 },
        header,
        { type = "padding", val = 2 },
        buttons,
        { type = "padding", val = 2 },
        tools,
        { type = "padding", val = 2 },
        mru,
        { type = "padding", val = 1 },
        footer,
      },
    }

    require("alpha").setup(config)
  end,
}
