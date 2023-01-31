function theme {
    local theme_name="$1"
    if [ -d "$ZSH_PLUG/$theme_name" ]; then
        # If already present, load theme
        load_plugin "$theme_name"
    else
        # Else, curl and load theme
        mkdir -p $ZSH_PLUG/$theme_name
        curl "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/themes/$theme_name.zsh-theme" >> "$ZSH_PLUG/$theme_name/$theme_name.plugin.zsh"
        load_plugin "$theme_name"
    fi
}

function plug {
    local plugin_name=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZSH_PLUG/$plugin_name" ]; then
        # If already present, load plugin
        load_plugin "$plugin_name"
    else
        # Else, http-clone and load plugin
        git clone "https://github.com/$1.git" "$ZSH_PLUG/$plugin_name"
        load_plugin "$plugin_name"
    fi
}

function load_plugin {
    local name="$1"
    source "$ZSH_PLUG/$name/$name.plugin.zsh" || source "$ZSH_PLUG/$name/$name.zsh"
}

function set_title_cwd {
    print -Pn "\e]0;📂 %~\a"
}

function set_title_process {
    print -Pn "\e]0;🚀 ${1}\a"
}

function exit_code_color {
    local exit_code="$?"
    if [ $exit_code -eq 0 ]; then
        echo -n green
    else
        echo -n red
    fi
}

# TODO.Separate vcs stuff
function prompt_vcs_preexec_hook {
    case "$2" in
        *git*|*svn*) PR_GIT_UPDATE=1 ;;
    esac
}

function prompt_vcs_chpwd_hook {
    PR_GIT_UPDATE=1
}

function prompt_vcs_precmd_hook {
    (( PR_GIT_UPDATE )) || return

    # check for untracked files or updated submodules, since vcs_info doesn't
    if [[ -n "$(git ls-files --other --exclude-standard 2> /dev/null)" ]]; then
        PR_GIT_UPDATE=1
        FMT_BRANCH="$PM_RST $blue%b%u%c$red ●$PR_RST"
    else
        FMT_BRANCH="$PM_RST $blue%b%u%c$PR_RST"
    fi
    git_separator=$' \ue0a0'
    zstyle ':vcs_info:*:prompt:*' formats       $git_separator"$FMT_BRANCH"

    vcs_info 'prompt'
    PR_GIT_UPDATE=
}
