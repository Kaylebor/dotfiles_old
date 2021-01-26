#!/bin/zsh

passgen() { < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo; }

html-search() {
  local search_tags_count=0
  local regex=()
  for arg in "$@"; do
    case $arg in
      -c|--class)
      local search_class=1
      ((search_tags_count++))
      ;;
      -i|--id)
      local search_id=1
      ((search_tags_count++))
      ;;
      -t|--tag)
      local search_tag=1
      ((search_tags_count++))
      ;;
      -f|--files)
      local search_files=1
      ;;
      -g|--glob)
      local set_glob=1
      ;;
      --count)
      local count=1
      ;;
      -h|--help)
      echo "Searches for a given class or id on all html files in the project"
      echo "Depends on Ripgrep for the actual search"
      echo ""
      echo "Usage: $0 [OPTIONS] [QUERY1] [QUERY2] ..."
      echo "options:"
      echo "  -h, --help          displays this message"
      echo "  -c, --class         searches for html classes that match the query"
      echo "  -i, --id            searches for html ids that match the query"
      echo "  -t, --tag           searches for html tags that match the query"
      echo "  -f, --files         modifies the query to return only the files that match without the matches"
      echo "  -g, --glob          sets glob option on the ripgrep query to the specified value"
      echo "  --count             instead of displaying results, counts how many matches it finds"
      echo "                      if --class or --id are set, counts total matches in all files"
      echo "                      if --file is set, counts files that contains matches"
      return 0
      ;;
      *)
      if [[ $set_glob -eq 1 && ! -v glob ]]; then
        local glob=$arg
      else
        regex+=("$arg")
      fi
    esac
  done

  if [[ $search_tags_count -gt 1 ]]; then
    echo "No more than one of [--class, --id, --tag] must be set; please specify only one of these options and try again"
    return -1
  fi
  if [[ $search_tags_count -lt 1 ]]; then
    echo "At least one of [--class, --id, --tag] must be set; please specify one of these options and try again"
    return -1
  fi
  if [[ -z $regex ]]; then
    read -A regex
    if [[ -z $regex ]]; then
      echo "Please specify a search query"
      return -1
    fi
    regex=("${(f)regex}")
  fi

  local args=(-P -o -thtml)
  [[ $search_files -eq 1 ]] && args+=-l
  if [[ -v glob ]]; then
    args+=-g
    args+=glob
  fi

  local valid_css_name="-?[_a-zA-Z]+[_a-zA-Z0-9-]*"
  local quote_regex="[\"\\']"

  local full_regex=()
  if [[ $search_class -eq 1 ]]; then
    for reg in $regex; do
      full_regex+=-e
      full_regex+="class=$quote_regex*( *$valid_css_name +)*\K$reg(?=( +$valid_css_name *)*$quote_regex)"
    done
  elif [[ $search_id -eq 1 ]]; then
    for reg in $regex; do
      full_regex+=-e
      full_regex+="id=$quote_regex *\K$reg(?= *$quote_regex)"
    done
  elif [[ $search_tag -eq 1 ]]; then
    for reg in $regex; do
      full_regex+=-e
      full_regex+="< *\K$reg(?= *)"
    done
  fi

  if [[ $count -eq 1 ]]; then
    echo "Total: $(rg $args $full_regex | wc -l)"
  else
    rg $args $full_regex
  fi
}
