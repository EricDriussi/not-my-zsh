source "$CUSTOM_ZSH/prompt/colors.zsh"
source "$CUSTOM_ZSH/prompt/vcs.zsh"

user=$red%n%f
host=$blue%m%f
user_host="$user@$host%f"

dir_data=$' 📂 $green%~%f'
git_data='$vcs_info_msg_0_%f'
arrow=$'%F{$(exit_code_color)}\U2994'

line_one=$user_host$dir_data$git_data%f
cr=$'\n'
line_two=$arrow%f

setopt prompt_subst
PROMPT=$line_one$cr$line_two" "
