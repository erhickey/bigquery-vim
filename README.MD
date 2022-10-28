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
