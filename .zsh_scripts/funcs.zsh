#!/bin/zsh
passgen() {
  < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;
}

search-class() {
  rg -thtml "class=\"[a-zA-Z0-9-]* ?$1 ?[a-zA-Z0-9-]*\""
}
