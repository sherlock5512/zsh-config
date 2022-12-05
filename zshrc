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

## Load my functions
fpath=( $ZDOTDIR/functions $fpath )
autoload CleanTmp
autoload setTermTitle
autoload tempPersist
autoload has

## Source Other files
source ${ZDOTDIR}/aliases
source ${ZDOTDIR}/dir_aliases
source ${ZDOTDIR}/prompt
source ${ZDOTDIR}/keyboard
source ${ZDOTDIR}/history
source ${ZDOTDIR}/chpwd


## Set option
#setopt emacs         ## Emacs style keybinds
setopt vi
setopt autocd        ## Change to directory if given as command
setopt autopushd     ## Automatically use pushd and stack
setopt correct       ## Pick up on Spelling errors

source ${ZDOTDIR}/completion

## Configure command line editor
zle -N edit-command-line
bindkey "^X^E" edit-command-line

## Enable gpg-agent support
if [[ "$USE_GPG_AGENT" == "true" ]]; then
	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
	gpgconf --launch gpg-agent
	gpg-connect-agent /bye
	export GPG_TTY=$(tty)
fi

## Load external stuff

##Configure for homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

## Configure Plugins
export ZSH_AUTOSUGGEST_STRATEGY=(completion history) # suggest from completion then history
export ZSH_AUTOSUGGEST_USE_ASYNC=1 # make async for SPEED
export ZSH_AUTOSUGGEST_HISTORY_IGNORE='(cd|cp|tar|mv|ls|nvim|rm|rmdir|git) *'


## Load Plugins with ZshPlug

export ZSH_PLUG_plugins=( "zsh-users/zsh-autosuggestions" \
	"zdharma-continuum/fast-syntax-highlighting" \
	"jeffreytse/zsh-vi-mode" \
	"MichaelAquilina/zsh-you-should-use"\
)
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

source $ZDOTDIR/greet
