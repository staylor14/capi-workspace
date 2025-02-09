#!/bin/bash

set -e

capi_brewfile="${PWD}/Brewfile"
brewfile_link="${HOME}/.Brewfile"
if [ ! -L "${brewfile_link}" ]; then
  echo "Creating Brewfile symlink"
  ln -s "${capi_brewfile}" "${brewfile_link}"
fi

echo "Installing from the Brewfile..."
brew update || echo "brew update failed, but continuing"
brew tap Homebrew/bundle
brew bundle --global || true
brew cleanup
