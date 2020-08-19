#!/usr/bin/env bash

# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

if ! command -v nvm > /dev/null 2>&1 /dev/null; then
	echo 'Error: nvm is not installed and is required.' >&2
	exit 1
fi

project_directory="$(dirname "${BASH_SOURCE[0]}")"

cd "$project_directory"

if [[ "$1" == "--install" ]]; then
	nvm exec npm install
	exit 0
elif [[ "$1" == "--update" ]]; then
	if [[ "$2" == "" ]]; then
		>&2 echo "Usage: nbr --update <package-name>"
		exit 1
	fi
	nvm exec npm install "$2@latest"
	exit 0
elif [[ "$1" == "--add" ]]; then
	if [[ "$2" == "" ]]; then
		>&2 echo "Usage: nbr --add <package-name>"
		exit 1
	fi
	nvm exec npm install --save "$2"
	exit 0
elif [[ "$1" == "" ]]; then
	echo "Usage: nbr [--install|--add|<command>]"
	exit 1
else
	cd -
	nvm use
	PATH="$project_directory/node_modules/.bin/:$PATH" \
	"$@"
fi
