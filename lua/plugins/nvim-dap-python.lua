return {
    {
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = { "python" },
        config = function()
            local dap_python = require("dap-python")

            --python解释器路径:必须能执行python -m debugpy --version
            dap_python.setup(vim.fn.exepath("python3"))

            vim.keymap.set("n", "<space>dp", function() dap_python.test_method() end,
                { desc = "Python: debug test method" })
            vim.keymap.set("n", "<space>dP", function() dap_python.test_class() end,
                { desc = "Python: debug test class" })
            vim.keymap.set("v", "<space>dp", function() dap_python.debug_selection() end,
                { desc = "Python: debug选中的代码" })
        end,
    },
}
