# Detect OS
if [[ "$(uname)" == "Darwin" ]]; then
  # macOS Homebrew path
  [ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$(uname)" == "Linux" ]]; then
  # Linux/WSL Homebrew path
  [ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  # Alternative Linux Homebrew path
  [ -f "$HOME/.linuxbrew/bin/brew" ] && eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
fi
