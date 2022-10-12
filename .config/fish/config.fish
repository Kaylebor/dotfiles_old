# Define JAVA_HOME from asdf
if command -qv asdf
    set -gx JAVA_HOME (asdf env java | rg JAVA_HOME | string split -f2 =)
end

# Enable starship.rs prompt
if command -qv starship
    starship init fish | source
end

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Set aliases
    alias exa 'exa -h -L2 --icons'
    alias ls exa
    alias lsg 'exa --git-ignore'
    alias quit exit
    if command -qv wine64
        alias wine wine64
    end
    alias sed 'sed -E'
    alias cat 'bat --paging=never'
    alias emacs emacsc
    alias diff delta
end
