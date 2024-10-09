# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

COMPLETION_WAITING_DOTS="true"

plugins=(
  git
#  aliases
#  tmux
#  aws
#  redis-cli
)

source $ZSH/oh-my-zsh.sh

bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/joflaherty/.zshrc'

fpath+=~/.zsh/
# autoload -Uz compinit
# compinit
# End of lines added by compinstall

# User specific environment
if [ -d ~/.zshrc.d ]; then
	for rc in ~/.zshrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc
unsetopt autocd
unsetopt share_history

# Pyenv setup
# Pyenv setup
if command -v pyenv >/dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
fi

# fzf
# if [ -x "$(command -v fzf)"  ]
# then
# 	source /usr/share/fzf/shell/key-bindings.zsh
# fi

export VISUAL=vim
export EDITOR="$VISUAL"

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/segments.json)"

# # keep at end of the file
eval "$(zoxide init zsh)"

# poetry
export PATH="$HOME/.local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    nvm "$@"
}


zstyle ':completion:*' menu select
fpath+=~/.zfunc

# Go installation
export PATH=$PATH:/usr/local/go/bin

. "$HOME/.cargo/env"
