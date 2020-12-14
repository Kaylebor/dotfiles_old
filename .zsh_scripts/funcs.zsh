#!/bin/zsh
passgen() {
  < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;
}

html-search-class() {
  rg --pcre2 -othtml "class=[\"']([[:alnum:]_-]* +)*\K$1(?=([[:alnum:]_-]* +)*[\"'])"
}

html-search-class-file() {
  rg --pcre2 -lthtml "class=[\"']([[:alnum:]_-]* +)*\K$1(?=([[:alnum:]_-]* +)*[\"'])"
}

html-search-id() {
  rg --pcre2 -othtml "id=[\"'] *\K$1(?= *[\"'])"
}

html-search-id-file() {
  rg --pcre2 -lthtml "id=[\"'] *\K$1(?= *[\"'])"
}
