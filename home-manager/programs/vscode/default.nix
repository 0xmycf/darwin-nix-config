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
    # this needs to be an absoulte path
    # then fromJSON (readFile "${homeDir}/.config/nix-darwin/home-manager/.config/nvim-snippets/${path}")
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

    userSettings = {
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.colorCustomizations" = {
        "symbolIcon.keywordForeground" = "#9586CF";
      };
      "editor.tokenColorCustomizations" = {
        "textMateRules" = [
          {
            "scope" = "constant.other.haskell";
            "settings" = {
              "foreground" = "#EBCB8B";
            };
          }
        ];
      };
      "security.workspace.trust.untrustedFiles" = "open";
      "explorer.confirmDelete" = false;
      "editor.suggestSelection" = "first";
      "vsintellicode.modify.editor.suggestSelection" = "automaticallyOverrodeDefaultValue";
      "editor.fontFamily" = "Fira Code";
      "editor.fontLigatures" = "'onum', 'ss04', 'ss08', 'ss09', 'ss03'";
      "editor.lineHeight" = 0;
      "editor.fontSize" = 14;
      "editor.fontWeight" = 600;
      "workbench.fontAliasing" = "antialiased";
      "editor.quickSuggestions" = {
        "comments" = "on";
        "strings" = "on";
        "other" = "on";
      };
      "[markdown]" = {
        "editor.quickSuggestions" = {
          "comments" = "on";
          "strings" = "on";
          "other" = "on";
        };
      };
      "latex-utilities.countWord.format" = "\${wordsBody} Words";
      "files.exclude" = {};
      "explorer.confirmDragAndDrop" = false;
      "cSpell.language" = "en,en-GB,de-DE,de";
      "zenMode.hideLineNumbers" = false;
      "vim.normalModeKeyBindingsNonRecursive" = [];
      "vim.leader" = "<space>";
      "vim.vimrc.enable" = true;
      "editor.cursorBlinking" = "smooth";
      "telemetry.telemetryLevel" = "off";
      "workbench.colorTheme" = "Spacegray Ocean Dark";
      "files.autoSave" = "onWindowChange";
      "editor.bracketPairColorization.enabled" = false;
      "notebook.cellFocusIndicator" = "border";
      "window.restoreWindows" = "none";
      "notebook.output.textLineLimit" = 300;
      "git.openRepositoryInParentFolders" = "never";
      "notebook.lineNumbers" = "on";
      "update.mode" = "manual";
      "editor.minimap.enabled" = false;
      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
    };

    languageSnippets = snippets;
    keybindings = builtins.fromJSON (builtins.readFile ../../.config/vscode/keybindings.json);
  };
}
