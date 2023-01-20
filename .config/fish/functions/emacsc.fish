function emacsc --wraps=emacsclient
    set -l socket_file (find-socket Emacs | sort -u)
    if test -S "$socket_file[1]"
        emacsclient -nw --socket-name=$socket_file[1] $argv
    else if test -n "$ALTERNATE_EDITOR"
        $ALTERNATE_EDITOR $argv
    else
        printf "Emacs socket missing, and there are no fallbacks, aborting...\n"
    end
end
