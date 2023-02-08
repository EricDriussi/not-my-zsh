# Fancy functions!
source "$CUSTOM_ZSH/aliases/aliases_funcs.zsh"

# Sys
alias cl="clear"
alias cpd="cp -ir"
alias diskUsage="sudo du -h | sort -hr | head -10"
alias fd="find_in_cwd"; find_in_cwd() { find . -iname "*$1*" | sort }
alias fonts=find_fonts
alias freeport=kill_process_by_port
alias grep="grep --color=always"
alias l="exa --group --all --long --icons"
alias loop=repeat_command
alias mkdir="mkdir -p"
alias mv="mv -i"
alias ports="open_ports"; open_ports() { sudo ss -tulpn | grep LISTEN }
alias rg="rg --hidden -g '!.git'"
alias rmd="rm -rf"
alias sctl="sudo systemctl"
alias tre="exa --all --icons --group-directories-first --tree --level=2 --ignore-glob='node_modules|.git|.idea'"
alias tree="tree -L 2 -C -a -I 'node_modules' -I 'build' -I '.git' -I '.idea'"

# Change ssh key
alias ssauth='eval "$(ssh-agent -s)" && ssh-add'
# Navigation
alias c="cd_and_ls"; cd_and_ls() { cd "$1" && l }
alias cb="cd .."
alias mkd="mkdir_and_cd"; mkdir_and_cd() { mkdir "$1" && cd "$1" }
# Nvim
alias v="nvim"
alias vo="fzf_nvim"; fzf_nvim() { nvim "$(fzf)" }
# Dev
alias goask="go_docs"; go_docs() { go doc "$1" | nvim }
alias gob="go build"
alias goi="go env -w GOBIN=$HOME/.local/bin && go install"
alias gor="go run"
alias nr="npm run"
alias nv="source /usr/share/nvm/init-nvm.sh && nvm"
alias pr="pipenv run"
alias todos='grep -nrsi "todo\|fixme" --exclude-dir=".*"'
alias watch=run_on_change

# Git
alias ga="git add ."
alias gaddorigin=add_origin
alias gaddremote="git remote set-url --add --push origin"
alias gamen="git commit --amend"
alias gc="git commit"
alias gcempty="git commit --allow-empty --allow-empty-message"
alias gcom="git add -A && git commit"
alias gfs="git fetch && git status"
alias ginit="git init"
alias glb="git branch -a"
alias glg=git_log
alias glog=git_log_files
alias gme="git merge --no-squash --no-edit"
alias gmkb=new_branch
alias gmv="git checkout"
alias gp="git pull"
alias gpush=git_push
alias gpushf="git push --force"
alias gres="git mergetool"
alias grmB=rm_all_branches
alias grmb="git branch -D"
alias gs="git status"
alias gstash="git stash -u"
alias gsuperp="git fetch origin && git reset --hard origin"
alias gundo="git reset HEAD~1"
alias gunmerge="git revert -m 1"
alias gunstage="git restore --staged ."
alias gunstash="git stash pop"
alias lg="lazygit"
alias rollback="git restore"
alias trymerge=git_dry_merge

# Github
alias ghpr=create_PR
alias ghs="gh pr checks --watch"
alias ghv="gh pr view --web"

# Docker
alias dc='docker container ls --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}"'
alias ddown="docker-compose down"
alias di="docker image ls"
alias dlist=docker_list
alias dlog=docker_logs
alias dnuke='docker stop $(docker container ls -a -q); docker system prune -a -f --volumes'
alias dshel=docker_shell
alias dstop="docker stop"
alias dup="docker-compose up -d"
alias dv="docker volume ls"

# Globals!
alias -g C="| xclip -sel clipboard"
alias -g G="| grep"
alias -g L="| less"
alias -g NOER="2> /dev/null"
alias -g NOUT="> /dev/null 2>&1"
alias -g SU="| sort -u"
