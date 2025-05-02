if status is-interactive

    # Environment variables
    set -x COLORTERM truecolor
    set -x EDITOR hx

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

    # Initialize Homebrew
    eval (/opt/homebrew/bin/brew shellenv)

    # Aliases
    alias zc="hx ~/.config/fish/config.fish"
    alias zs="source ~/.config/fish/config.fish"
    alias v="nvim ."
    alias vc="cd ~/.config/nvim && nvim ."
    alias zl="zellij"
    alias lz="lazygit"
    alias ghstc="$EDITOR $HOME/Library/Application\ Support/com.mitchellh.ghostty/config"
    alias cd="z"

    # Initialize zoxide
    zoxide init fish | source

    # fzf integration
    fzf --fish | source

    set fish_greeting ""

    # yazi function
    function y
        set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if test -f $tmp
            set -l new_dir (cat $tmp)
            if test -n "$new_dir" -a "$new_dir" != "$PWD"
                cd $new_dir
            end
            rm -f $tmp
        end
    end

end
