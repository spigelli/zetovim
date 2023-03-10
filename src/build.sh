#! /bin/bash

# Assign the directory of this script to SCRIPT_DIR
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Assign the directory of the parent of this script to DIR
DIR="$(dirname "$SCRIPT_DIR")"

cd "$DIR"

MINIMUM_LOG_LEVEL="debug"

SKIP_NEOVIM_BUILD=true
SKIP_KITTY_BUILD=true
SKIP_OS_INTEGRATION=true

# If the directory doesn't exist, creates it
function create_dir {
  if [ ! -d "$1" ]; then
    log "info" "$1 doesn't exist, creating it"
    mkdir "$1"
  else 
    log "debug" "$1 exists"
  fi
}

# Logs a message to the console
# The first argument is the log level 
# The second argument is the message
function log {
  # Parse the log level
  case "$1" in
    "debug")
      local LOG_LEVEL="DEBUG"
      shift
      ;;
    "info")
      local LOG_LEVEL="INFO"
      shift
      ;;
    "warn")
      local LOG_LEVEL="WARN"
      shift
      ;;
    "error")
      local LOG_LEVEL="ERROR"
      shift
      ;;
    *)
      local LOG_LEVEL="INFO"
      # Don't shift, the first argument is the message
      ;;
  esac
  
  # Colors for the log level
  declare -A LOG_LEVEL_COLORS
  # Info is cyan bright
  LOG_LEVEL_COLORS["INFO"]="\e[1;36m"
  # Warn is yellow bright
  LOG_LEVEL_COLORS["WARN"]="\e[1;33m"
  # Error is red bright
  LOG_LEVEL_COLORS["ERROR"]="\e[1;31m"
  # Debug is gray
  LOG_LEVEL_COLORS["DEBUG"]="\e[0;37m"
  
  # If the LOG_LEVEL of this message is greater than the
  # MINIMUM_LOG_LEVEL, don't print it
  case "$LOG_LEVEL" in
    "DEBUG")
      if [ "$MINIMUM_LOG_LEVEL" != "debug" ]; then
        return
      fi
      ;;
    "INFO")
      if [ "$MINIMUM_LOG_LEVEL" != "info" ] && [ "$MINIMUM_LOG_LEVEL" != "debug" ]; then
        return
      fi
      ;;
    "WARN")
      if [ "$MINIMUM_LOG_LEVEL" == "error" ]; then
        return
      fi
      ;;
    "ERROR")
      if false; then # We'll go ahead and print errors
        return
      fi
      ;;
  esac
  
  echo -e "${LOG_LEVEL_COLORS[$LOG_LEVEL]}[$LOG_LEVEL] $1\e[0m"
}

log "info" "Starting build"
log "info" "Ensuring directories exist"
# If the build directory doesn't exist, create it
create_dir "$DIR/build"
# If the nvim directory doesn't exist, create it
create_dir "$DIR/build/nvim"

# nvim state and data directories, see :h standard_path
create_dir "$DIR/build/nvim/state"
create_dir "$DIR/build/nvim/data"
create_dir "$DIR/build/nvim/log"

# Build neovim
if [ "$SKIP_NEOVIM_BUILD" = false ] ; then
  log "info" "Building neovim"
  git clone https://github.com/neovim/neovim.git && \
  cd neovim && \
  git checkout stable && \
  rm -r build/ ;
  make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$DIR/build/nvim/" && \
  make install && \
  cd .. && \
  rm -rf neovim
else
  log "info" "Skipping neovim build"
fi

# Build kitty
if [ "$SKIP_KITTY_BUILD" = false ] ; then
  log "info" "Building kitty"
  cd into kitty
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh \
    | sh /dev/stdin \
      launch=n \
      dest=$DIR/build/ && \
    cd ..
else
  log "info" "Skipping kitty build"
fi

# OS Integration
if [ "$SKIP_OS_INTEGRATION" = false ] ; then
  log "info" "Installing OS integration"
  # Create the .desktop file
  cd "$SCRIPT_DIR"
  cp ./resources/ZetoVim.desktop $HOME/.local/share/applications/ZetoVim.desktop
  cp ./resources/logo.png $HOME/.local/share/icons/ZetoVim.png
else
  log "info" "Skipping OS integration"
fi
