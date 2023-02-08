# zsh_history settings
export HISTFILE=$ZSH/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

export KEYTIMEOUT=1

export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache

export CUSTOM_ZSH=$ZSH/not-my-zsh
export ZSH_PLUG=$CUSTOM_ZSH/.plug

source $CUSTOM_ZSH/funcs.zsh
source $CUSTOM_ZSH/settings.zsh
source $CUSTOM_ZSH/bindings.zsh
source $CUSTOM_ZSH/aliases/init.zsh

# Default Theme
source $CUSTOM_ZSH/prompt/prompt.zsh
