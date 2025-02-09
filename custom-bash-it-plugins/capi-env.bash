# shell prompt settings
export HISTTIMEFORMAT="%F %T "
export THEME_CLOCK_CHAR="⛅️ "

# Set nvim as default editor
export GIT_EDITOR=nvim
export EDITOR=nvim

# Setup GOPATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Add capi-workspace/scripts to PATH
export PATH="$PATH:$HOME/workspace/capi-workspace/scripts"

# Add brew-installed python to the path.
# Must go at the beginning so that it's prioritized over the system installation.
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

launchctl setenv PATH $PATH
