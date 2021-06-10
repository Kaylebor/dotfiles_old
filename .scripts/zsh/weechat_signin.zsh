#!/bin/zsh

op get account &>/dev/null
[[ $? -ne 0 ]] && eval $(op signin my)

op get item ukukysdnjzftzmcrk46o6ef76e --fields password
