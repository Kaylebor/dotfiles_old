#!/bin/zsh
passgen() {
  < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;
}

html-search-class() {
  rg -thtml "class=\"[a-zA-Z0-9-]* ?$1 ?[a-zA-Z0-9-]*\""
}

html-search-id() {
  rg -thtml "id=\"$1\""
}
