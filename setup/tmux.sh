if command -v tmux >/dev/null 2>&1; then 
		echo "Installing TPM (tmux package manager)"; 
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; 
		stow tmux
else 
		echo "tmux is not installed. Please install tmux first."; 
		exit 1; 
fi
