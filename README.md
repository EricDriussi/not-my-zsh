# Not my zsh

> Basic zsh config with sane defaults

Also comes with a mini plugin/theme manager and a pretty prompt with full git integration.

## Install

1. Either clone the repo into `~/.config/zsh/not-my-zsh` or run the following command:

```sh
wget https://raw.githubusercontent.com/EricDriussi/not-my-zsh/master/install.sh -O install.sh && sh install.sh
```

2. Then, in your `.zshrc`, add the following at the beginning of the file if you want your config to override this one **or** at the end to have this config override yours.

```sh
export XDG_CONFIG_HOME=$HOME/.config
export ZSH=$XDG_CONFIG_HOME/zsh
source $ZSH/not-my-zsh/init.zsh
```

## Use

You can add whatever [OMZ plugins](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins) you like.
These two for example are often times useful:

```sh
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
```

Same goes for [OMZ themes](https://github.com/ohmyzsh/ohmyzsh/tree/master/themes):

```sh
theme "agnoster"
```

## Tinker

Aliases are in `aliases.zsh`.

Some sane default settings can be found in `settings.zsh` and `init.zsh`.

Bindings are in `bindings.zsh`.

The default prompt can be modified in `default-prompt.zsh`.

`functions.zsh` contains utility functions used elsewhere (like `plug` and `theme`).
