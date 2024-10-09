all:
	stow nvim
	stow zsh
	stow oh-my-posh

destroy:
	stow -D nvim zsh oh-my-posh
