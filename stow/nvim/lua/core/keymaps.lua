-- Navigate vim panes better
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Navegação entre panes no Neovim
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>') -- Mover para a janela acima
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>') -- Mover para a janela abaixo
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>') -- Mover para a janela à esquerda
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>') -- Mover para a janela à direita

-- Ajuste do tamanho das janelas
vim.keymap.set('n', '<c-Up>', ':resize +2<CR>')    -- Aumentar altura da janela
vim.keymap.set('n', '<c-Down>', ':resize -2<CR>')  -- Diminuir altura da janela
vim.keymap.set('n', '<c-Left>', ':vertical resize -2<CR>') -- Diminuir largura da janela
vim.keymap.set('n', '<c-Right>', ':vertical resize +2<CR>') -- Aumentar largura da janela

-- Gerenciamento de splits
vim.keymap.set('n', '<leader>v', ':vsplit<CR>') -- Criar uma divisão vertical
vim.keymap.set('n', '<leader>s', ':split<CR>')  -- Criar uma divisão horizontal
vim.keymap.set('n', '<leader>q', ':close<CR>')  -- Fechar a janela atual

