############
#  COLORS  #
############
blue="%{${(%):-"%F{blue}"}%}"
yellow="%{${(%):-"%F{yellow}"}%}"
red="%{${(%):-"%F{red}"}%}"
green="%{${(%):-"%F{green}"}%}"

###########
#   VCS   #
###########
# TODO.Separate vcs stuff
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
# Slow in large repos
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr
# %c - stagedstr
# %a - action
# %R - repository path
# %S - path in the repository
PR_RST="$reset_color"
FMT_BRANCH="$blue%b%u%c$PR_RST"
FMT_ACTION=" performing a $green%a$PR_RST"
FMT_UNSTAGED="$yellow ●"
FMT_STAGED="$green ●"

git_separator=$' \ue0a0'

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats $git_separator" ${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

############
#  PROMPT  #
############
user='$red%n%f'
host='$blue%m%f'
user_host=$user'@'$host'%f'

dir_separator=' 📂 '
dir='$green%~%f'

git='$vcs_info_msg_0_%f'

line_one=$user_host$dir_separator$dir$git'%f'
line_two=$'%F{$(exit_code_color)}\U2994%f '

setopt prompt_subst
PROMPT=$line_one$'\n'$line_two
