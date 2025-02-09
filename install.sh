#!/usr/bin/env bash

set -e

LOGFILE=$HOME/workspace/capi-workspace/launchagent-daily-install.log

function install {

if [ ! -t 1 ] ; then
  echo '=================================================================='
  date
  echo '=================================================================='
fi >> $LOGFILE

cd "$(dirname "$0")"

# first switch remote to https so that we can pull without keys in
git remote set-url origin https://github.com/cloudfoundry/capi-workspace

# make sure we're up to date
git pull

# restore remote to ssh
git remote set-url origin git@github.com:cloudfoundry/capi-workspace

# nightly autoinstall setup
source ./setup/launchagent-daily-install.sh
source ./setup/local_connections.sh

# install brew and its packages
source ./setup/brew.sh
source ./setup/xcode.sh
source ./brew-bundle.sh

# Setup radar menu bar item to point at our concourse
source ./setup/radar.sh

# bash-it / terminal
source ./setup/bash-it.sh
source ./setup/custom-bash-it-plugins.sh
source ./setup/iterm2.sh
source ./setup/vim.sh
source ./setup/jarg.sh

# ruby setup
source ./setup/ruby.sh
source ./setup/bundler.sh
source ./setup/uaac.sh

# git setup
source ./setup/git-config.sh
source ./setup/git-author.sh
source ./setup/git-hooks.sh

# ide prefs
source ./setup/ide-prefs.sh

source ./setup/keyboard.sh
source ./setup/dock.sh
source ./setup/spectacle.sh

# daemons to launch databases at startup
source ./setup/mysql.sh
source ./setup/postgres.sh

# Golang setup
source ./setup/go.sh

# Depends on existence of GOPATH, created earlier on
source ./clone-repos.sh

source ./setup/cats.sh

source ./setup/fly.sh

source ./setup/misc.sh

# Instal CLI cf-httpie plugin
source ./setup/httpie.sh

source ./setup/snyk.sh

# Add gem dependencies for CAPI-Workspace
bundle

echo "Please set your computer name using \"./setup/system-name.sh <name>\" if you have not already. Thanks!"
}



function open_picklecat() {
  open http://dn.ht/picklecat/
}

function exit_successfully() {
  # clean up autoinstall logs on autoinstall success
  if [ ! -t 1 ] ; then
    echo -n > $LOGFILE
  fi

  echo "Successfully installed!"
}

trap '{ case $? in
   0) exit_successfully; exit 0;;
   *) open_picklecat ; exit 0;;
 esac ; }' EXIT

install
