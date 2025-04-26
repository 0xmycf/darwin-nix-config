{
  lib,
  pkgs,
  ...
}: let
  sets = lib.attrsets;
  files = builtins.readDir ../../.config/nvim-snippets;
  fileData = with builtins; (mapAttrs (path: type: let
    length = stringLength path;
    fileEnding = substring (length - 5) length path;
  in
    if type != "directory" && fileEnding == ".json"
    then fromJSON (readFile (../../.config/nvim-snippets + "/${path}"))
    else "")
  files);
  cleanedFileData = sets.filterAttrs (key: value: value == "") fileData;
  snippets = sets.concatMapAttrs (key: value: let
    fileName = p: builtins.head (builtins.split "\." p);
  in {"${fileName key}" = value;})
  cleanedFileData;
in {
  home.packages = [pkgs.nodejs];

  programs.vscode = {
    enable = true;

    package = pkgs.vscodium;

    profiles.default = {
      extensions = with pkgs.vscode-extensions;
        [
          # asvetliakov.vscode-neovim
          vscodevim.vim
          pkief.material-icon-theme
          ms-toolsai.jupyter

          github.copilot-chat
          github.copilot

          # csv
          mechatroner.rainbow-csv

          # Usually when I need vscode I also need python
          ms-pyright.pyright
          ms-python.python
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "Spacegray";
            publisher = "Spacegray";
            version = "0.4.0";
            sha256 = "sha256-0K+01atbqFkqwj/4TRcIiaLji3tZBBsHW5LsLiIzxOg=";
          }

          {
            name = "intellij-idea-keybindings";
            publisher = "k--kato";
            version = "1.7.0";
            sha256 = "sha256-mIcSZANZlj5iO2oLiJBUHn08rXVhu/9SKsRhlu/hcvI=";
          }
        ];

      # this doesnt work well
      # userSettings = builtins.fromJSON (builtins.readFile ../../.config/vscode/settings.json);

      languageSnippets = snippets;
      keybindings = builtins.fromJSON (builtins.readFile ../../.config/vscode/keybindings.json);
    };
  };
}
