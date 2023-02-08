function theme {
    local theme_name="$1"
    if [ -d "$ZSH_PLUG/$theme_name" ]; then
        # If already present, load theme
        _load_plugin "$theme_name"
    else
        # Else, curl and load theme
        mkdir -p $ZSH_PLUG/$theme_name
        curl "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/themes/$theme_name.zsh-theme" >> "$ZSH_PLUG/$theme_name/$theme_name.plugin.zsh"
        _load_plugin "$theme_name"
    fi
}

function plug {
    local plugin_name=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZSH_PLUG/$plugin_name" ]; then
        # If already present, load plugin
        _load_plugin "$plugin_name"
    else
        # Else, http-clone and load plugin
        git clone "https://github.com/$1.git" "$ZSH_PLUG/$plugin_name"
        _load_plugin "$plugin_name"
    fi
}

function _load_plugin {
    local name="$1"
    source "$ZSH_PLUG/$name/$name.plugin.zsh" || source "$ZSH_PLUG/$name/$name.zsh"
}

function _exit_code_color {
    local exit_code="$?"
    if [ $exit_code -eq 0 ]; then
        echo -n green
    else
        echo -n red
    fi
}
