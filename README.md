# My Neovim Configuration

This directory contains my Neovim configuration that I have been building since January 
of 2022. 

The main idea behind this configuration is that I want to use as little plugin as possible 
and attempt to build the tools that I need from scratch so that the configuration is as
portable as possible.

## Notes and Resources
The best thing to do when looking for specific API's is going to be the following vim command
`:h vim.` or `:h nvim_` since these are going to give the full list of configuration functions
available within lua and vim script.

Other than that, the Neovim documentation is pretty comprehensive and worth the read if
you want to configure nvim yourself.

## Backlog Items
- For neo-notes I want to see if I can put in a navigation menu so that it is easier
to switch between different notes files within the directory. Also, since tree-sitter has been
introduced into neovim is might be a cool project to see if there is an easy way to handle
working with markdown files in terms of searching through stuff.
