# My ZSH config.

This is my personal ZSH config that I run on my laptop.
It works for what I want from a configured shell.

I would recommend you actually create your own config before just using
mine since you will gain a proper understanding of how ZSH works and just
what it can do.

I have attempted to organise my config into a series of files that each
perform a specific task, that way it is easier for me to change small
sections as the need arises.

## How to use

If you really really want to just blindly copy me then you will need to
clone this repository to `~/.config/zsh`

Inside of the cloned repository run:
```sh
git submodule init
git submodule update
```
This will pull in the latest version of my plugin manager.

And then add the following into your `~/.profile`:  
```sh
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
```

After your next reboot you _should_ be using my config.

If anything goes wrong feel free to open an issue. But this is entirely a
personal project for my own use, so don't expect anything.
