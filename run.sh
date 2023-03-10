# The cwd of the shell that ran this script
RUN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

./build/kitty.app/bin/kitty \
  --class=kitty \
  --name=ZetoVim \
  --title=ZetoVim \
  -c ./src/config/kitty/kitty.conf \
  -d "$RUN_DIR"