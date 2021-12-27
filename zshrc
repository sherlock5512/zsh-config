#############################
#     Sherlock's ZSHRC      #
# This may not work for you #
#    Try making your own    #
#############################

## Unalias Defaults that I am going to change later
unalias run-help

## autoload Modules
autoload -U +X colors && colors
autoload -U calendar
autoload -U run-help 
autoload -U +X compinit
autoload -U edit-command-line

## zmodload Modules
zmodload zsh/complist

## Source Other files
source $HOME/.profile
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/dir_aliases
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/prompt
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/keyboard

## Source Functions
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/functions/*

## Set option
setopt emacs         ## Emacs style keybinds
setopt autocd        ## Change to directory if given as command
setopt autopushd     ## Automatically use pushd and stack
setopt correct       ## Pick up on Spelling errors
setopt SHARE_HISTORY ## Share history across sessions
setopt hist_verify   ## Edit Commands after expansion

## Configure History File
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.zhistory

## Configure Completions
zstyle ':completion:*' menu select ## use menu to select where possible
zstyle ':completion:*:descriptions' format '%U%B%d%b%u' ## better descriptions format
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b' ## show when no matches
zstyle ':completion:*' completer _complete _match _approximate ## fuzzy match
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' \
        max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)' ## more errors in longer lines
zstyle ':completion:*:functions' ignored-patterns '_*' ## ignore completions for commands I dont have
zstyle ':completion:*' squeeze-slashes true ## remove trailing slashes
zstyle ':completion:*:cd:*' ignore-parents parent pwd ## don't complete parent dir

compinit
_comp_options+=(globdots)

## Configure command line editor
zle -N edit-command-line
bindkey "" edit-command-line

## Configure Plugins
export ZSH_AUTOSUGGEST_STRATEGY=(completion history) # suggest from completion then history
export ZSH_AUTOSUGGEST_USE_ASYNC=1 # make async for SPEED
export ZSH_AUTOSUGGEST_HISTORY_IGNORE='(cd|cp|tar|mv|ls|nvim|rm|rmdir|git) *'

## Load Plugins with ZshPlug

export ZSH_PLUG_plugins=( "zsh-users/zsh-autosuggestions" "zdharma-continuum/fast-syntax-highlighting" "MichaelAquilina/zsh-you-should-use" )
source $ZDOTDIR/ZshPlug/ZshPlug.zsh

[[ -n "${key[Home]}" ]]      && bindkey "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}" ]]       && bindkey "${key[End]}"        end-of-line
[[ -n "${key[Insert]}" ]]    && bindkey "${key[Insert]}"     overwrite-mode
[[ -n "${key[Delete]}" ]]    && bindkey "${key[Delete]}"     delete-char
[[ -n "${key[Backspace]}" ]] && bindkey "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Up]}" ]]        && bindkey "${key[Up]}"         up-line-or-search
[[ -n "${key[Down]}" ]]      && bindkey "${key[Down]}"       down-line-or-search
[[ -n "${key[Left]}" ]]      && bindkey "${key[Left]}"       backward-char
[[ -n "${key[Right]}" ]]     && bindkey "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}" ]]    && bindkey "${key[PageUp]}"     history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey "${key[PageDown]}"   history-beginning-search-forward

$ZDOTDIR/greet
