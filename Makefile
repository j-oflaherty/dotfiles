oh-my-posh:
	echo "Installing oh-my-posh"
	curl -s https://ohmyposh.dev/install.sh | sudo bash -s
	stow oh-my-posh

tmux:
	chmod +x setup/tmux.sh
	setup/tmux.sh

all: oh-my-posh tmux
	stow nvim
	stow zsh

destroy:
	stow -D nvim zsh oh-my-posh
