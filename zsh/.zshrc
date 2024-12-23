# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  aliases
  aws
  docker
#  redis-cli
)

source $ZSH/oh-my-zsh.sh

bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/joflaherty/.zshrc'

fpath+=~/.zsh/
fpath+=~/.zfunc/
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

# Lazy load pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(command pyenv init --path)"

if [ -x "$(command -v fzf)"  ]
then
 	source <(fzf --zsh)
fi


export VISUAL=vim
export EDITOR="$VISUAL"

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/segments.yaml)"

# # keep at end of the file
eval "$(zoxide init zsh)"

# poetry
export PATH="$HOME/.local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


zstyle ':completion:*' menu select
fpath+=~/.zfunc

# Go installation
export PATH=$PATH:/usr/local/go/bin

# . "$HOME/.cargo/env"

# pnpm
# export PNPM_HOME="/home/joflaherty/.local/share/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# pnpm end
. "$HOME/.cargo/env"
