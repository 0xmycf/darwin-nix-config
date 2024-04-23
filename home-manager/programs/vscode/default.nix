{
  lib,
  pkgs,
  config,
  ...
}: let
  sets = lib.attrsets;
  homeDir = config.home.homeDirectory;
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

    # TODO
    extensions = with pkgs.vscode-extensions;
      [
        asvetliakov.vscode-neovim
        pkief.material-icon-theme
        ms-toolsai.jupyter

        github.copilot-chat
        github.copilot

        ms-pyright.pyright
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

        {
          name = "vscode-pvs";
          publisher = "paolomasci";
          version = "1.0.64";
          sha256 = "sha256-xKxIMYVhCTfCHwG/ecfn/ae3pr4Ku/37KBB4lbHWgNI=";
        }
      ];

    # this doesnt work well
    # userSettings = builtins.fromJSON (builtins.readFile ../../.config/vscode/settings.json);

    languageSnippets = snippets;
    keybindings = builtins.fromJSON (builtins.readFile ../../.config/vscode/keybindings.json);
  };
}
