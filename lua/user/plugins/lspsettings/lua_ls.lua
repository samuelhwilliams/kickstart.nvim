return {
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      runtime = {
        version = 'LuaJIT',
        special = {
          register_plugin = 'require',
        },
      },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = { disable = { 'missing-fields' } },
      hint = {
        enable = false,
        await = true,
        paramName = "All",
        paramType = true,
        semicolon = "All",
      },
    },
  },
}
