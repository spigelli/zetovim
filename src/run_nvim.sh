RUN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ZETOVIM_DIR="$RUN_DIR"
XDG_CONFIG_HOME="$ZETOVIM_DIR/src/config" \
XDG_STATE_HOME="$ZETOVIM_DIR/build/nvim/state" \
XDG_DATA_HOME="$ZETOVIM_DIR/build/nvim/data" \
NVIM_LOG_FILE="$ZETOVIM_DIR/build/nvim/log/nvim.log" \
./build/nvim/bin/nvim