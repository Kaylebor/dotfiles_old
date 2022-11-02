function emacsc --wraps=emacsclient
    set -l socket_file (find-socket Emacs)
    if test -S $socket_file
        emacsclient -nw --socket-name=$socket_file $argv
    else
        printf 'Emacs server not found; please start the server first'
    end
end
