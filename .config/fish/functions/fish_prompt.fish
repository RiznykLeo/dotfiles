function fish_prompt
    set -l last_status $status

    set_color blue
    echo -n (prompt_pwd)
    set_color normal

    if command -sq git
        set -l git_branch (git branch --show-current 2>/dev/null)
        if test -n "$git_branch"
            set_color yellow
            echo -n " ($git_branch)"
            set_color normal
        end
    end

    echo -n " ><> "
end
