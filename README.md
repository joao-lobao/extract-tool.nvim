# extract-tool.nvim

A simple and easy to use Neovim plugin to extract chunks of code to function,
class method, class, etc...

Extraction can be made in the current file or to a new file.

## Installation

Install with [lazy.nvim](https://github.com/folke/lazy.nvim):

Add this in your init.lua or plugins.lua:

```lua
{
  "joao-lobao/extract-tool.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-treesitter/nvim-treesitter-textobjects" },
  config = function()
    require("extract-tool").setup()
  end
}
```

## Usage

In Visual Mode select the code you want to extract. Press the keymap to extract
the selected code. You'll be prompted to choose how you want to extract it.
Default keymap is:

```lua
vim.api.nvim_set_keymap("v", "<leader>e", "<cmd>lua require('extract-tool').extract()<CR>", {})
```

The plugin natively supports extraction for javascript and typescript languages.
But one can also create their own keymap to extract code from any type of language.
Like so:

```lua
-- eg: extract code to c++ main function inside current file
vim.api.nvim_set_keymap("v", "<leader>e", "<cmd>lua require('extract-tool').extract('int main() {\\n}')<CR>", {})
-- another eg: extract code to c++ main function to another file (just leave second argument like that -> 'file').
-- You'll be prompted to enter the directory and file name
vim.api.nvim_set_keymap("v", "<leader>e", "<cmd>lua require('extract-tool').extract('int main() {\\n}', 'file')<CR>", {})
```

Below are the plugin defaults. You can override the keymap
configuration by changing the properties inside the setup function.

```lua
{
  "joao-lobao/extract-tool.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-treesitter/nvim-treesitter-textobjects" },
  config = function()
    require("extract-tool").setup({
        -- default configuration
        keymaps = {
            extract = "<leader>e",
        },
    })
  end
}
```
