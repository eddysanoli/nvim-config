return {
    'rcarriga/nvim-notify',
    config = function()
        require('notify').setup({
            stages = "fade_in_slide_out",
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.8)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.8)
            end,
        })

        vim.notify = require('notify')
    end,
}
