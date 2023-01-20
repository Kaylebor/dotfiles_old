function find-socket -a QUERY TYPE
  if test -z "$TYPE"
      set -f TYPE unix
  end
  jc lsof -c $QUERY | jq -r ".[] | select(.type == \"$TYPE\").name"
end
