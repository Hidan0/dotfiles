return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("colorizer").setup({
      filetypes = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "tsx",
        "jsx",
        "xml",
        "php",
        "markdown",
        "conf",
        "zsh",
      },
      user_default_options = {
        names = false,
        RRGGBB = true,
        RRGGBBAA = true,
        css = true,
        css_fn = true,
        sass = { enable = true, parsers = { "css" } },
      },
    })
  end,
}
