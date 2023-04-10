# My ZSH configuration

This repository has a fully loaded configuration for ZSH.
The configuration make opinionated choices based on my own desires for what
a shell should be like.

It's strongly advised that you write your own configuration instead of
just using this one. That way you can understand what you are doing and
maybe gain a better appreciation for the shell and its features.

The configuration is broken down into modules where possible, this
makes it easier to hack on.

## Usage

Clone this repository to `~/.config/zsh`

Inside of that directory run:
```sh
git submodule init
git submodule update
```
This will pull my plug-in manager `ZshPlug`.

And then add the following into `~/.zshenv`:
```sh
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
```
This tells ZSH where the ZSH dotfiles are.

### Important note
It is possible that your system might not be happy with this.
I have yet to fully work out the little issues that I have with making a
consistent environment across *all* of my user session.

This might result in a need to create a system of linked environment files
to ensure that everything can access the environment variables that are
meant to be set.

## Issues
This is a personal project and is unlikely to be maintained in a
professional manner.
If you do find any technical issues during your usage of this config then
feel free to open a GitHub issue.
Please remember that GitHub issues are not a forum nor a place for you to
ask questions not related to *technical issues*, and it is completely up to
my own discretion what issues I handle and which ones I close.

## General overview
The main goals for this configuration are look good, work good, and be
quick.
The less things getting in my way the better.

This is why I have made opinionated decisions about what options to enable
and how it works.

### Notable features

 - Edit the command line in $EDITOR by pressing `C-x C-e`
 - Fully configured completion
 - Automatic typo repair
 - vi mode enabled
 - Automatic use of the directory stack `popd` to go back whence you came
 - Smart history
 - Plug-ins chosen for greatness
 - Extended Globbing enabled.
 - 10 second thinking time enforced for big deletes
 - Expanded directories automatically have `/` appended
 - Allow comments in interactive mode (this may be useful to mark history
		 items)
 - Neaten paths like `../foo/..` to `..` (ChaseDots)

## Breakdown
The following sections break down what is in the repository and what
function it does.

### Modules

#### `./aliases`
This module features aliases that I find useful or ones that improve
existing tools.
Any alias that uses external tools uses the `has` function to disable it
when the tool isn't installed.

##### Current aliases:
 - `ls` => `exa --icons --group-directories-first` (see: [Exa Website](https://the.exa.website/) )
 - `xopen` => `xdg-open`
 - `cls` => `clear; ls`
 - `se` => `scriptedit` (wrapper script for fzf and nvim)
 - `yt` => `youtube-dl`
 - `yta` => `youtube-dl --ignore-config --add-metadata --ignore-errors --extract-audio --format "bestaudio/best"`
 - `cp` => `cp --interactive --verbose`
 - `mv` => `mv --interactive --verbose`
 - `rm` => `rm --interactive=once --verbose`
 - `mkd` => `mkdir --parents --verbose`
 - `diff` => `diff --color=auto`
 - `grep` => `grep --color=auto`
 - `ip` => `ip --colour=auto`
 - `vw` => `nvim -c VimwikiIndex`
 - `ws` => `wineselect` (script to choose and set wine-prefix)
 - `zero` => `dirs -c && clear`

##### File associations
This module is also responsible for in terminal file associations. Given a
file with a particular extension ZSH can open it with the appropriate
program.
`tex`, `html`, and `md` files are mapped to either `nvim`, `vim`, or `vi`
in that order of preference.
`pdf` files are mapped to `zathura` when it's installed.

#### `./chpwd`
This module sets the `chpwd` hook and makes ZSH display any (markdown
formatted) readme files
found in the current directory using glow.

#### `./completion`
This file configures the powerful completion engine of
ZSH.
Documenting this here would be a waste since the file has decent comments.
For more information on ZSH completion see `man zshcompsys`

#### `./dir_aliases`
This file uses `hash` to add entries into the named directory hash table.
(See: `man zshbuiltins`)
This gives the effect of these "aliases" that represent directories.
- `~dx` => `$HOME/Documents`
- `~dl` => `$HOME/Downloads`
- `~cn` => `${XDG_CONFIG_HOME:-$HOME/.config}`
- `~px` => `$HOME/Pictures`
- `~pr` => `$HOME/Projects`

#### `./greet`
This file gets executed at the end of `zshrc` to provide a little message
on startup.

#### `./history`
This file configures the ZSH history system.

This makes a few changes:
 - Moves history to `${XDG_STATE_HOME/zsh/history}`
 - Ignores duplicate entries
 - Ignore entries starting with a space
 - Compacts whitespace
 - Never saves duplicates
 - Ignores duplicates when searching history
 - Requires you press enter after expanding `!!`

#### `./keyboard`
This file uses `zkbd`(see `man zshcontrib`) to get information about your
keyboard and how your terminal handles it. This can fix issues with keys
not being recognised in programs.

#### `./prompt`
This file configures the prompts, and yes there's two.
ZSH has both a left and right prompt and I use both of them.

##### Left prompt
The left prompt shows user, hostname, current directory, and the status of
the last command.

##### Right prompt
The right prompt shows the status of git repository information while
you're in one.

##### `precmd`
This file also sets the `precmd` hook to set the terminal title (for
terminals which support the escape codes that do this.)

#### `zshrc`
This is the true `zshrc` file with `.zshrc` a symbolic link to this
file.
This makes it a little easier to edit the file since you can actually see
it in `ls` and in editors.

This file draws together the modules and actually makes
settings apply.

### Functions
This configuration defines and loads some functions,
some of which are helper functions used in the configuration.

#### `CleanTmp`
Function called during exit to clean a local tmp directory (`~/tmp`).

#### `has`
Just a wrapper for calling `command -v $COMMAND`.
This function gets used to check for external tools.

#### `setTermTitle`
This function gets used in the prompt to set the terminal title.
It makes use of escape sequences to control the terminal and might have
issues on rare or unusual terminals.

#### `tempPersist`
This function controls if the local tmp directory (`~/tmp`) will persist across sessions or
not.

#### `_dotnet`
This completion function that tells the completion engine how to
complete `dotnet` commands.
