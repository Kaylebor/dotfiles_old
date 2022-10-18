function _fish_elixir_mix_needs_command
    set cmd (commandline -opc)
    test (count $cmd) -eq 1 -a $cmd[1] = mix
end

function _fish_elixir_mix_tasks
    mix help 2>/dev/null | string replace -f -r '^mix\s+(\S+)\s+#\s+(.*)' '$1\t$2'
end

complete -c mix -n _fish_elixir_mix_needs_command -f -a '(_fish_elixir_mix_tasks)'
