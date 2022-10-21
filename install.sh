#!/bin/sh

set -e

mkdir -p "$HOME"/.config/zsh/not-my-zsh
ZSH="$HOME"/.config/zsh/not-my-zsh

main() {
	git clone git@github.com:EricDriussi/not-my-zsh.git "$ZSH"
	exec zsh -l
}

main "$@"
