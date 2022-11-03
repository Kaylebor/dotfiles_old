function find-socket
  jc lsof -c $argv[1] | jq -r '.[] | select(.type == "unix").name'
end
