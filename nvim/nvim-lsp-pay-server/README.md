# nvim-lsp-pay-server

If you are running the built-in Neovim LSP client (`nvim-lsp`), this plugin
adds an `on_exit` handler for the Sorbet LSP client to gracefully recover VPN
disconnects, 2FA refreshes, and `pay up` not running.

It also draws in your status bar:

![pay-up](https://git.corp.stripe.com/storage/user/3866/files/f8943b00-6f21-11eb-8a78-b2f04b187ccb)

## Requirements

* Neovim 0.5+
* You are using the built-in `nvim-lsp` in Neovim 0.5+
* Configuring your LSP with `nvim-lspconfig`
* A status line (I use `galaxyline.nvim`)

## LSP setup

### nvim-lspconfig setup

```lua
local lspconfig = require('lspconfig')
local util = require('lspconfig/util')
local payServer = require('nvim-lsp-pay-server/lsp/nvim-lspconfig')

lspconfig.sorbet.setup({
  cmd = {
    "scripts/dev_productivity/while_pay_up_connected.sh",
    "pay",
    "exec",
    "scripts/bin/typecheck",
    "--lsp",
    "--enable-all-experimental-lsp-features",
  },
  -- This handler will take care of prompting you for 2fa and running `pay up`
  on_exit = payServer.handleExit,
  root_dir = util.root_pattern("sorbet", ".git"),
  settings = {},
})
```

### Other LSPs

If you want to add support for another LSP, ping @dbalatero to pair on Slack.

The main entry point is `recoveryFromExit`, which wraps up all the 2FA / connection logic:

```lua
local someExitHandler = function()
  payServer.recoverFromExit(function()
    -- this function called on successful recovery
    restartMyLsp()
  end)
end

-- wire up someExitHandler to your LSP client somehow
```

## Status line API

To generate basic statusline text, you can manually call:

```lua
local getStatusText = payServer.statusLine()

print(vim.inspect(getStatusText()))
```

If you want to use fancier NerdFont glyphs for the status spinners, you can do:

```lua
-- Requires a patched Nerd Font, see https://www.nerdfonts.com
local getStatusText = payServer.statusLine({ nerdFonts = true })

print(vim.inspect(getStatusText()))
```

While the LSP client is recovering, this plugin will emit `:doautocmd User
PayStatusUpdated` every `100ms`. You can hook into this event to force your
status line to redraw, so you get fancy spinners while waiting for input.

## Status line setup (galaxyline.nvim)

To integrate with galaxyline.nvim, you can add a new entry:

```lua
local gl = require('galaxyline')
local gls = gl.section
local payServer = require('nvim-lsp-pay-server')

gls.right[1] = {
  PayStatus = {
    -- Using Nerd Font glyphs to draw the spinners
    provider = payServer.statusLine({ nerdFonts = true }),
    highlight = {colors.offsetGray, colors.background},
    icon = ' ',
    -- Hook into this event so we can animate spinners every 100ms.
    event = 'PayStatusUpdated',
  }
}
```

## Status line setup (lualine.nvim)

```lua
require('lualine').setup {
  sections = {
    lualine_x = {
      "require'nvim-lsp-pay-server'.statusLine()()",
      'encoding', 'fileformat', 'filetype' -- defaults; adjust as desired
    }
  },
}

vim.api.nvim_exec([[autocmd user PayStatusUpdated redrawstatus]], false)
```

## Other status line

TODO - please ping @dbalatero on Slack to pair on integrating this with your
status line (Airline, lightline, whatever).
