-- Map the split commands to your Rust script
vim.api.nvim_set_keymap('n', '<C-w>s', ':Split<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>v', ':Vsplit<CR>', { noremap = true, silent = true })

- Replace the split and vsplit commands with custom Lua functions
vim.cmd([[command! -nargs=? -complete=file -bar Split lua OpenWithRustScript('')]])
vim.cmd([[command! -nargs=? -complete=file -bar VSplit lua OpenWithRustScript('v')]])

function OpenWithRustScript(direction)
    local current_file = vim.fn.expand("%")
    local cmd = "/home/juicy/git/personal/hyprland-nvim/target/release/hyprland-nvim " .. current_file
    if direction == 'v' then cmd = cmd .. " --vertical" end
    os.execute(cmd)
end
