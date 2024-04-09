{lib, ...}:
with lib; {
  options = {
    fonts.program-specific = mkOption {
      type = types.listOf types.package;
      default = [];
      description = ''
        List of fonts to install.

        Use this where a special application needs a font instead of
        directly installing this through home.packages.

        This will be called in the $ROOT/home-manager/fonts.nix file.
      '';

      example = "[ font-roboto ]";
    };
  };
}
