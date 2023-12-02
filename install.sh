#!/bin/bash

set -eu

echo "Updating, upgrading and cleaning distribution"
sudo apt -y update
sudo apt -y upgrade
sudo apt -y autoremove

if ! command -v git >/dev/null; then
	echo "Installing git"
	sudo apt -y install git
fi

if ! command -v zsh >/dev/null; then
	echo "Installing ZSH"
	sudo apt -y install zsh

	echo "Setting ZSH as default shell"
	sudo chsh -s $(which zsh)
fi

if [ ! -f ~/antigen.zsh ]; then
	echo "Installing antigen"
	curl -L git.io/antigen > $HOME/.antigen/antigen.zsh
fi

echo "Copying zsh configuration"
cp .devcontainer/config/.zshrc $HOME/.zshrc

echo "Copying powerlevel10k configuration"
cp .devcontainer/config/.p10k.zsh $HOME/.p10k.zsh
