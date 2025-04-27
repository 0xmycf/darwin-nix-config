#! /usr/bin/env bash

source ./vscode.sh

echo "using vscodium instead of vscode" 

fixVscode
echo "linked vscode settings.json"

fixKeybindings
echo "linked vscode keybindings.json"

