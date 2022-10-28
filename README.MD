# bigquery-vim

Execute BigQuery queries and view the results from within Vim/Neovim buffers.

![](/screenshots/bigquery-vim.png)

The selected query is run with the [bq command-line tool](https://cloud.google.com/bigquery/docs/bq-command-line-tool).

Before the bq shell command is executed the query is modified in the following ways:
1. Comments are removed
2. Single quotes are replaced with double quotes

## Requirements

[gcloud CLI](https://cloud.google.com/sdk/docs/install)

## Installation

Install manually or with your favorite plugin manager and add keybindings for the [functions](#functions) below.

## Configuration

Example key mappings:

```vim
" execute the visual selection
vnoremap <buffer> <enter> :BQExecute<CR>
" execute the current paragraph
nnoremap <buffer> <enter> m'vap:BQExecute<CR>g`'
```

The following variables can be modified to alter the shell command run by BQExecute:

```vim
let g:bq_command = 'bq'
let g:bq_params = ['query', '--nouse_legacy_sql']
```

## Functions

### BQExecute

Executes the selected query.

## Example Configuration

This is the configuration I use. When opening a .bq file keymappings are created and syntax is set to sql.

```lua
local function create_keymaps()
  local opts = { noremap=true, silent=true }
  vim.api.nvim_set_keymap('n', '<leader><CR>', "m'vap:BQExecute<CR>g`'", opts);
end

local au_group_name = 'bigquery_vim_aug'
vim.api.nvim_create_augroup(au_group_name, { clear = true })
vim.api.nvim_create_autocmd(
  'BufEnter',
  { command = 'set syntax=sql', group = au_group_name, pattern = { '*.bq' } }
)
vim.api.nvim_create_autocmd(
  { 'BufReadPost', 'BufNewFile' },
  { callback = create_keymaps, group = au_group_name, pattern = { '*.bq' } }
)
```
