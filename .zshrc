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

alias cd="z"

# GO
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH" 

# GH

pr-stats() {

local added=$(gh pr diff | grep "^+" | grep -v "^+++" | wc -l)
  local deleted=$(gh pr diff | grep "^-" | grep -v "^---" | wc -l)
  local net_change=$((deleted - added))
  local percentage=0
  local change_description=""
  
  if [ $deleted -ne 0 ] && [ $net_change -gt 0 ]; then
    percentage=$(echo "scale=1; ($net_change * 100) / $deleted" | bc)
    change_description="thinner"
  elif [ $added -ne 0 ] && [ $net_change -lt 0 ]; then
    percentage=$(echo "scale=1; (${net_change#-} * 100) / $added" | bc)
    change_description="thiccccer"
  else
    percentage="0.0"
    change_description="unchanged"
  fi
  
  local green='\033[0;32m'
  local red='\033[0;31m'
  local blue='\033[0;34m'
  local reset='\033[0m'
  
  printf "Lines added:   ${green}%-8d${reset}\n" $added
  printf "Lines deleted: ${red}%-8d${reset}\n" $deleted
  printf "Net change:    ${blue}%-8d${reset} (code became ${blue}%.1f%%${reset} ${change_description})\n" $net_change $percentage
}
