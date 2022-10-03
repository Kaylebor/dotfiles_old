function emacsc --wraps=emacsclient
    set -l socket_file (lsof -c Emacs | grep unix | tail -n1 | tr -s ' ' | cut -d' ' -f8)
    if test -S $socket_file
        emacsclient -nw --socket-name=$socket_file $argv
    else
        printf 'Emacs server not found; please start the server first'
    end
end
