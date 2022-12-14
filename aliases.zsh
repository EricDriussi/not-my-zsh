# Sys
alias cl="clear"
alias cp="cp"
alias cpd="cp -ir"
alias diskUsage="sudo du -h | sort -hr | head -10"
alias fd="find_in_cwd"; find_in_cwd() { find . -iname "*$1*" | sort }
alias fonts="find_fonts"; find_fonts() { fc-list | grep -i "$1" | awk -F: '{print $2}' | sort | uniq }
alias freeport="kill_process_in_port"; kill_process_in_port() {
    lsof -i tcp:"$1" | awk 'NR!=1 {print $2}' | xargs kill
}
alias grep="grep --color=always"
alias l="exa --group --all --long --icons"
alias mkdir="mkdir -p"
alias mv="mv -i"
alias ports="check_listening_ports"; check_listening_ports() {
    sudo ss -tulpn | grep LISTEN
}
alias redo="repeat_command"; repeat_command() {
    cmd=("${@:2}")
    for i in {1.."$1"}; do
        $cmd
        if [[ $? != 0 ]]; then
            echo "\nCommand failed on run $i"; return 1
        fi
    done; echo "\nCommand never failed"
}
alias rg="rg --hidden -g '!.git'"
alias rm="rm"
alias rmd="rm -irf"
alias sctl="sudo systemctl"
alias tre="exa --all --icons --group-directories-first --tree --level=2 --ignore-glob='node_modules|.git|.idea'"
alias tree="tree -L 2 -C -a -I 'node_modules' -I 'build' -I '.git' -I '.idea'"

# Globals!
alias -g G="| grep"
alias -g L="| less"
alias -g NOER="2> /dev/null"
alias -g NOUT="> /dev/null 2>&1"
alias -g SU="| sort -u"
alias -g C="| xclip -sel clipboard"

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
alias todos='grep -rsi "todo\|fixme" --exclude-dir=".*"'

alias watch="run_on_change"; run_on_change() {
    color_command(){
        # Modify these values to change behavior
        pass_terms="\<pass\>|\<ok\>|\<success\>"
        fail_terms="\<fail\>|\<failed\>|\<failure\>"
        pass_color=$'\e[1;32m'
        fail_color=$'\e[1;31m'
        reset_color=$'\e[0m'

        colored_pass_terms="??? ${pass_color}&${reset_color}"
        colored_fail_terms="??? ${fail_color}&${reset_color}"

        # Use sed to parse output and color it
        "$@" | sed -E "s/${pass_terms}/${colored_pass_terms}/I" |\
            sed -E "s/${fail_terms}/${colored_fail_terms}/I"
    }

    # Run command once
    color_command "$@"
    # Loop and use inotify-tools to re-run on change
    while true; do
        inotifywait -qq -r -e create,modify,move,delete ./ &&
        printf "\n[ . . . Re-running command . . . ]\n" &&
        color_command "$@"
    done
}

# Git
alias glb="git branch -a"
alias gadd="git add"
alias gaddorigin="add_origin"; add_origin() {
    git remote add origin "$1" && git remote set-url --add --push origin "$1"
}
alias gaddremote="git remote set-url --add --push origin"
alias gamen="git commit --amend"
alias gc="git commit"
alias gcempty="git commit --allow-empty --allow-empty-message"
alias gcom="git add -A && git commit"
alias gfs="git fetch && git status"
alias ginit="git init"
alias gme="git merge --no-squash --no-edit"
alias gmkb="new_git_branch"; new_git_branch() {
    git checkout -b "$(echo $@ | sed 's/ /-/g')"
}
alias gmv="git checkout"
alias gp="git pull"
alias gpush="git_push"; git_push() {
    git push --set-upstream origin "$(git rev-parse --abbrev-ref HEAD)"
}
alias gpushf="git push --force"
alias gres="git mergetool"
alias grmb="git branch -D"
alias grmB="rm_all_branches"; rm_all_branches() {
    for branch in $(git for-each-ref --format '%(refname:short)' --merged HEAD refs/heads/)
    do
        git branch -d ${branch}
    done
}
alias gs="git status"
alias gstash="git stash -u"
alias gsuperp="git fetch origin && git reset --hard origin"
alias gunstage="git restore --staged ."
alias gunstash="git stash pop"
alias lg="lazygit"
alias olreliable="git reset --soft HEAD~1 && git stash && git pull && git stash pop"
alias rollback="git restore"
alias trymerge="git_dry_merge"; git_dry_merge() {
    git merge "$1" --no-commit --no-ff; git merge --abort
}

alias glg='git log -15 --graph --abbrev-commit --decorate --format=tformat:"%C(yellow)%h%C(reset)%C(reset)%C(auto)%d%C(reset) %s %C(white) -  %C(bold green)(%ar)%C(reset) %C(dim blue)<%an>%Creset"'
alias glog='git log -10 --name-only --graph --abbrev-commit --decorate --format=tformat:"%C(yellow)%h%C(reset)%C(reset)%C(auto)%d%C(reset) %s %C(white) -  %C(bold green)(%ar)%C(reset) %C(dim blue)<%an>%C(reset)"'

# Github
alias ghs="gh pr checks --watch"
alias ghv="gh pr view --web"
alias ghpr="create_PR"; create_PR() {
    gh pr create \
        --title "$(git rev-parse --abbrev-ref HEAD | sed -e 's/-/ /g' -eE 's/\w*/\u&/g')" \
        --assignee "@me" --body ""
}

# Docker
alias dc='docker container ls --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}"'
alias ddown="docker-compose down"
alias di="docker image ls"
alias dnuke='docker stop $(docker container ls -a -q); docker system prune -a -f --volumes'
alias dstop="docker stop"
alias dup="docker-compose up -d"
alias dv="docker volume ls"

alias dlist="docker_list"; docker_list(){
    echo -e "\n------------------------------------IMAGES------------------------------------" && \
        docker image ls && \
        echo -e "\n----------------------------------CONTAINERS-----------------------------------" && \
        docker container ls --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}" && \
        echo -e "\n------------------------------------VOLUMES------------------------------------" && \
        docker volume ls
}
