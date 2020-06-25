passgen() {
  < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;
}

# For use from within WSL on Windows
cmd() {
  CMD=$1
  shift;
  ARGS=$@
  WIN_PWD=`wslpath -w "$(pwd)"`
  cmd.exe /c "pushd ${WIN_PWD} && ${CMD} ${ARGS}"
}