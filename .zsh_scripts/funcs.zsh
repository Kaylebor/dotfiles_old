#!/bin/zsh
passgen() {
  < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;
}

html-search() {
  for arg in "$@"; do
    case $arg in
      -c|--class)
      local search_class=1
      ;;
      -i|--id)
      local search_id=1
      ;;
      -f|--files)
      local search_files=1
      ;;
      --count)
      local count=1
      ;;
      -h|--help)
      echo "Searches for a given class or id on all html files in the project"
      echo "Ripgrep must be installed to work"
      echo ""
      echo "Usage: $0 [OPTIONS] [QUERY]"
      echo "options:"
      echo "  -h, --help      displays this message"
      echo "  -c, --class     searches for html classes that match the query"
      echo "  -i, --id        searches for html ids that match the query"
      echo "  -f, --files     modifies the query to return only the files that match without the matches"
      echo "  --count         instead of displaying results, counts how many matches it finds"
      echo "                  if --class or --id are set, counts total matches in all files"
      echo "                  if --file is set, counts files that contains matches"
      ;;
      *)
      local regex=$arg
    esac
  done

  if [[ $search_class -eq 1 && $search_id -eq 1 ]]; then
    echo "No more than one of [--class, --id] must be set; please specify only one of these options and try again"
    return -1
  fi
  if [[ $search_class -ne 1 && $search_id -ne 1 ]]; then
    echo "At least one of [--class, --id] must be set; please specify one of these options and try again"
    return -1
  fi
  if [[ -z $regex ]]; then
    echo "Please specify a search query"
    return -1
  fi

  local args=(-P -o -thtml)
  [[ $search_files -eq 1 ]] && args+=-l

  if [[ $search_class -eq 1 ]]; then
    local regex="class=[\\\"']([[:alnum:]_-]* +)*\K$regex(?=[ \\\"])"
  elif [[ $search_id -eq 1 ]]; then
    local regex="id=[\\\"'] *\K$regex(?=[ \\\"])"
  fi

  if [[ $count -eq 1 ]]; then
    rg $args "$regex" | wc -l
  else
    rg $args "$regex"
  fi
}
