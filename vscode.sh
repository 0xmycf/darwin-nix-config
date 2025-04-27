#! /usr/bin/env bash

# doesnt work well with nix as vscode expects a mutable file
fixVscode() 
{
    VSCODESETTINGS="$HOME/Library/Application Support/VSCodium/User/"
    NOW="$(date +"%Y%m%d%H%M%S")"
    if [[ -f "$VSCODESETTINGS/settings.json" ]]; then
        echo "Backing up current settings.json to $VSCODESETTINGS/$NOW-settings.bak.json"
        mv "$VSCODESETTINGS/settings.json" "$VSCODESETTINGS/$NOW-settings.bak.json"
    else 
        echo "No settings.json found, creating one"
    fi

    ln -sf "$HOME/.config/nix-darwin/home-manager/.config/vscode/settings.json" "$VSCODESETTINGS/settings.json"
}

fixKeybindings()
{
    VSCODESETTINGS="$HOME/Library/Application Support/VSCodium/User/"
    NOW="$(date +"%Y%m%d%H%M%S")"
    if [[ -f "$VSCODESETTINGS/keybindings.json" ]]; then
        echo "Backing up current keybindings.json to $VSCODESETTINGS/$NOW-keybindings.bak.json"
        mv "$VSCODESETTINGS/keybindings.json" "$VSCODESETTINGS/$NOW-keybindings.bak.json"
    else 
        echo "No keybindings.json found, creating one"
    fi

    ln -sf "$HOME/.config/nix-darwin/home-manager/.config/vscode/keybindings.json" "$VSCODESETTINGS/keybindings.json"

}
