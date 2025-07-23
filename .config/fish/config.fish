if status is-interactive

    # Environment variables
    set -x COLORTERM truecolor
    set -x EDITOR nvim 

    # Path for deno completions
    set fish_complete_path $fish_complete_path /Users/riznykleo/.zsh/completions

    # Tmux
    set -x TMUX_CONF "$HOME/.config/tmux/tmux.conf"

    # Deno
    set -x DENO_INSTALL "$HOME/.deno"
    set -x PATH "$DENO_INSTALL/bin" $PATH

    # Cargo
    set -x PATH "$HOME/.cargo/bin" $PATH

    # Bun
    set -x BUN_INSTALL "$HOME/.bun"
    set -x PATH "$BUN_INSTALL/bin" $PATH

    # GO
    set -x GOPATH "$HOME/go"
    set -x PATH "$GOPATH/bin" $PATH

    # PNPM
    set -x PNPM_HOME /Users/riznykleo/Library/pnpm
    if not contains -- "$PNPM_HOME" $PATH
        set -gx PATH "$PNPM_HOME" $PATH
    end

    # Initialize Homebrew
    eval (/opt/homebrew/bin/brew shellenv)

    # Aliases
    alias fconf ="nvim ~/.config/fish/config.fish"
    alias fsource="source ~/.config/fish/config.fish"
    alias v="nvim ."
    alias nivm="nvim"
    alias vc="cd ~/.config/nvim && nvim ."
    alias ghstc="$EDITOR $HOME/Library/Application\ Support/com.mitchellh.ghostty/config"

    alias cd="z"
    alias cat="bat"
    alias ls="eza"
    alias lzd="lazydocker"
    alias lzg="lazygit"
    alias grep="rg"

    # Initialize zoxide
    zoxide init fish | source

    # fzf integration
    fzf --fish | source

    set fish_greeting ""

end
