{
  lib,
  config,
  ...
}: {
  options = {
    colors = {
      theme = lib.mkOption {
        default = "tokyo-night-terminal-dark";
        description = "Name of the theme.";
        type = lib.types.nonEmptyStr;
      };

      palette = let
        baseOption = lib.mkOption {
          description = "One of the base16 colors.";
          type = lib.types.nonEmptyStr;
        };
      in {
        base00 = baseOption;
        base01 = baseOption;
        base02 = baseOption;
        base03 = baseOption;
        base04 = baseOption;
        base05 = baseOption;
        base06 = baseOption;
        base07 = baseOption;
        base08 = baseOption;
        base09 = baseOption;
        base0A = baseOption;
        base0B = baseOption;
        base0C = baseOption;
        base0D = baseOption;
        base0E = baseOption;
        base0F = baseOption;
      };
    };
  };

  config = let
    cfg = config.colors;
  in {
    colors.palette = (import (./base16 + "/${cfg.theme}.nix")).palette;
  };
}
