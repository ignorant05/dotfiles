#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/vars.sh"
echo "This script will be deprecated. Please use theme.switch.sh instead."
# scrDir="$(dirname "$(realpath "$0")")"
"${scrDir}"/theme.switch.sh "$@"
