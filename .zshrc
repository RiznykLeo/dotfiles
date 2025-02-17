export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh
source <(fzf --zsh) 

export EDITOR=hx

alias zc="hx ~/.zshrc"
alias zs="source ~/.zshrc"

# vim
alias v="nvim ."
alias vc="cd ~/.config/nvim && nvim ."

#zellij
#spawn zellij on terminal open
# eval "$(zellij setup --generate-auto-start zsh)"
alias zl="zellij"


# lazygit
alias lz="lazygit"

# ghostty
alias ghstc="nvim $HOME/Library/Application\ Support/com.mitchellh.ghostty/config"

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# bun completions
[ -s "/Users/riznykleo/.bun/_bun" ] && source "/Users/riznykleo/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#nvm
#
 export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#zoxide
eval "$(zoxide init zsh)"
