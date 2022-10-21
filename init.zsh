# zsh_history settings
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

export KEYTIMEOUT=1

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache

export CUSTOM_ZSH=$ZSH/not-my-zsh
export ZSH_PLUG=$CUSTOM_ZSH/.plug

source $CUSTOM_ZSH/functions.zsh
source $CUSTOM_ZSH/settings.zsh
source $CUSTOM_ZSH/bindings.zsh
source $CUSTOM_ZSH/aliases.zsh

# Theme
source $CUSTOM_ZSH/custom-prompt.zsh
