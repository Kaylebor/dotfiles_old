function find-socket
  lsof -Fnt -c$argv[1] | rg -U 'tunix\n\K' | cut -c 2-
end
