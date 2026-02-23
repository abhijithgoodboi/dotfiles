local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        c_cpp = { "clang-format" }, -- Hack to force download.
        c = { "clang-format" },
        cpp = { "clang-format" },
        python = { "isort", "black" },
        -- css = { "prettier" },
        -- html = { "prettier" },
    },

    formatters = {
        ["clang-format"] = {
            prepend_args = {
                "-style={ \
                IndentWidth: 4, \
                TabWidth: 4, \
                UseTab: Never, \
                AccessModifierOffset: 0, \
                IndentAccessModifiers: true, \
                PackConstructorInitializers: Never}",
            },
        },
        -- Python
        black = {
            prepend_args = {
                "--fast",
                "--line-length",
                "80",
            },
        },
        isort = {
            prepend_args = {
                "--profile",
                "black",
            },
        },
    },

    -- format_on_save = {
    --     -- These options will be passed to conform.format()
    --     timeout_ms = 500,
    --     lsp_fallback = true,
    -- },
}

return options
