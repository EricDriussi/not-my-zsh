# Enable colors
autoload -U colors && colors
# Enable pretty tab in multiplexer terminal
autoload -U add-zsh-hook
add-zsh-hook precmd (){ print -Pn "\e]0;📂 %~\a" }
add-zsh-hook preexec (){ print -Pn "\e]0;🚀 ${1}\a" }

export CUSTOM_ZSH=$ZSH/not-my-zsh
export ZSH_PLUG=$CUSTOM_ZSH/.plug

source $CUSTOM_ZSH/settings.zsh
# Zsh history settings
_history_settings
# Enable command editor/vi mode
_edit_command
# Enable fancy tab-complete
_fancy_complete_menu
# Enable fuzzy-find history
_fuzzy_history_search

source $CUSTOM_ZSH/funcs.zsh
source $CUSTOM_ZSH/bindings.zsh
source $CUSTOM_ZSH/aliases/aliases.zsh
source $CUSTOM_ZSH/prompt/prompt.zsh

# Disables error if autocompletion returns no match
unsetopt nomatch
unsetopt BEEP
