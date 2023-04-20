function find_fonts {
    fc-list | grep -i "$1" | awk -F: '{print $2}' | sort | uniq
}
function kill_process_by_port {
    lsof -i tcp:"$1" | awk 'NR!=1 {print $2}' | xargs kill
}

function repeat_command {
    cmd=("${@:2}")
    for i in {1.."$1"}; do
        $cmd
        if [[ $? != 0 ]]; then
            echo "\nCommand failed on run $i"; return 1
        fi
    done; echo "\nCommand never failed"
}

function run_on_change {
    color_command(){
        # Modify these values to change behavior
        pass_terms="\<pass\>|\<ok\>|\<success\>"
        fail_terms="\<fail\>|\<failed\>|\<failure\>"
        pass_color=$'\e[1;32m'
        fail_color=$'\e[1;31m'
        reset_color=$'\e[0m'

        colored_pass_terms="✅ ${pass_color}&${reset_color}"
        colored_fail_terms="❌ ${fail_color}&${reset_color}"

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

function add_origin {
    git remote add origin "$1" && git remote set-url --add --push origin "$1"
}
function new_branch {
    git checkout -b "$(echo $@ | sed 's/ /-/g')"
}
function git_push {
    git push --set-upstream origin "$(git rev-parse --abbrev-ref HEAD)"
}
function rm_all_branches {
    for branch in $(git for-each-ref --format '%(refname:short)' --merged HEAD refs/heads/)
    do
        git branch -d ${branch}
    done
}
function git_dry_merge {
    git merge "$1" --no-commit --no-ff; git merge --abort
}
function git_log {
    git log -15 --graph --abbrev-commit --decorate --format=tformat:"%C(yellow)%h%C(reset)%C(reset)%C(auto)%d%C(reset) %s %C(white) -  %C(bold green)(%ar)%C(reset) %C(dim blue)<%an>%Creset"
}
function git_log_files {
    git log -10 --name-only --graph --abbrev-commit --decorate --format=tformat:"%C(yellow)%h%C(reset)%C(reset)%C(auto)%d%C(reset) %s %C(white) -  %C(bold green)(%ar)%C(reset) %C(dim blue)<%an>%C(reset)"
}

function create_PR {
    gh pr create \
        --title "$(git rev-parse --abbrev-ref HEAD | sed -e 's/-/ /g' -Ee 's/\w*/\u&/g')" \
        --assignee "@me" --body ""
}

function docker_list {
    echo -e "\n------------------------------------IMAGES------------------------------------" && \
        docker image ls && \
        echo -e "\n----------------------------------CONTAINERS-----------------------------------" && \
        docker container ls --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}" && \
        echo -e "\n------------------------------------VOLUMES------------------------------------" && \
        docker volume ls
}

function docker_logs {
    if _docker_running; then
        container=$(_containers_selector)
        if [[ -n $container ]]; then
            container_id=$(_container_id $container)
            docker logs -f $container_id
        fi
    else
        echo "Docker daemon is not running! (ಠ_ಠ)"
    fi
}

function docker_shell {
    if _docker_running; then
        container=$(_containers_selector)
        if [[ -n $container ]]; then
            container_id=$(_container_id $container)
            shell=$(_get_available_shell $container_id)
            docker exec -it $container_id $shell
        fi
    else
        echo "Docker daemon is not running! (ಠ_ಠ)"
    fi
}

function _docker_running {
    docker ps >/dev/null 2>&1
}

function _containers_selector {
    docker ps | awk '{if (NR!=1) print $2 " <-> " $1}' | fzf --height 40%
}

function _container_id {
    echo "$1" | awk -v FS=' <-> ' '{print $2}'
}

function _get_available_shell {
    docker exec -it "$1" which bash && echo "/bin/bash" || echo "/bin/sh"
}

function decode_jwt(){
    if [ "$#" -eq 0 ]; then
        xclip -o | jq -R 'split(".") | .[1] | @base64d | fromjson'
    else
        echo "$1" | jq -R 'split(".") | .[1] | @base64d | fromjson'
    fi
}
