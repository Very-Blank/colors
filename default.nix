{
  lib,
  config,
  ...
}: {
  options = {
    colors = {
      name = lib.mkOption {
        default = "tokyodark";
        description = "One of the base16 colors.";
        type = lib.types.nonEmptyStr;
      };

      theme = let
        baseOption = default:
          lib.mkOption {
            default = default;
            description = "One of the base16 colors.";
            type = lib.types.nonEmptyStr;
          };
      in {
        base00 = baseOption "16161E";
        base01 = baseOption "1A1B26";
        base02 = baseOption "2F3549";
        base03 = baseOption "444B6A";
        base04 = baseOption "787C99";
        base05 = baseOption "787C99";
        base06 = baseOption "CBCCD1";
        base07 = baseOption "D5D6DB";
        base08 = baseOption "F7768E";
        base09 = baseOption "FF9E64";
        base0A = baseOption "E0AF68";
        base0B = baseOption "41A6B5";
        base0C = baseOption "7DCFFF";
        base0D = baseOption "7AA2F7";
        base0E = baseOption "BB9AF7";
        base0F = baseOption "D18616";
      };

      overrides = lib.mkOption {
        default = [];
        description = "Overrides for the base16 colors";
        type = lib.types.listOf (
          lib.types.submodule {
            options = {
              color = lib.mkOption {
                type = lib.types.str;
                description = "The name of the color.";
                example = "base00";
              };

              value = lib.mkOption {
                type = lib.types.str;
                description = "Hex value of the color.";
              };
            };
          }
        );
      };
    };
  };

  config = let
    cfg = config.colors;
  in {
    colors.theme = (import ./base16 ++ "/${cfg.name}").palette;
  };
  # lib.mkIf ((builtins.length cfg.overrides) != 0) {
  #   colors.theme =
  #     lib.mkMerge
  #     (map
  #       (option: {"${option.color}" = option.value;})
  #       cfg.overrides);
  # };
}
