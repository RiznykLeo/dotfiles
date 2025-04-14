# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/riznykleo/.zsh/completions:"* ]]; then export FPATH="/Users/riznykleo/.zsh/completions:$FPATH"; fi
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
export COLORTERM=truecolor
plugins=(git)
source $ZSH/oh-my-zsh.sh

ZSH_DISABLE_COMPFIX=true

# Detect OS
is_macos() {
  [[ "$(uname)" == "Darwin" ]]
}

is_linux() {
  [[ "$(uname)" == "Linux" ]]
}

# Helper function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# fzf
if command_exists fzf; then
  source <(fzf --zsh) 2>/dev/null || true
fi

export EDITOR=hx
alias zc="hx ~/.zshrc"
alias zs="source ~/.zshrc"

# vim
alias v="nvim ."
alias vc="cd ~/.config/nvim && nvim ."

# zellij
# spawn zellij on terminal open
# if command_exists zellij; then
#   eval "$(zellij setup --generate-auto-start zsh)"
# fi
if command_exists zellij; then
  alias zl="zellij"
fi

# lazygit
if command_exists lazygit; then
  alias lz="lazygit"
fi

# ghostty (macOS only)
if is_macos; then
  alias ghstc="nvim $HOME/Library/Application\ Support/com.mitchellh.ghostty/config"
fi

# yazi
if command_exists yazi; then
  function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
fi

# bun completions (macOS specific path)
if is_macos; then
  [ -s "/Users/riznykleo/.bun/_bun" ] && source "/Users/riznykleo/.bun/_bun"
elif is_linux; then
  [ -s "/home/leo/.bun/_bun" ] && source "/home/leo/.bun/_bun"
fi

# bun
if command_exists bun; then
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
if is_macos; then
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
elif is_linux; then
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# zoxide
if command_exists zoxide; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

# GO
if [ -d "$HOME/go" ]; then
  export GOPATH="$HOME/go"
  export PATH="$GOPATH/bin:$PATH"
fi

# GH
if command_exists gh; then
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
fi

# Tmux
export TMUX_CONF="$HOME/.config/tmux/.tmux.conf"

# Homebrew - different paths for macOS and Linux
if is_macos; then
  [ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
elif is_linux; then
  [ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi



export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

