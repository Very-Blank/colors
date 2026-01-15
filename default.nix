{inputs}: {
  lib,
  config,
  ...
}: {
  imports = [inputs.base16.nixosModule];

  options = {
    colors = {
      theme = lib.mkOption {
        default = "tokyo-night-terminal-dark";
        description = "The base 16 seceme used for theming.";
        type = lib.types.enum [
          "catppuccin-mocha"
          "chinoiserie-midnight"
          "atelier-plateau"
          "tokyo-night-terminal-dark"
        ];
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
    isOverridesZero = builtins.length cfg.overrides == 0;
  in
    lib.mkMerge [
      (lib.mkIf isOverridesZero {scheme = "${inputs.tt-schemes}/base16/${cfg.theme}.yaml";})
      (lib.mkIf (!isOverridesZero) {
        scheme = (
          (config.lib.base16.mkSchemeAttrs "${inputs.tt-schemes}/base16/${cfg.theme}.yaml").override (
            lib.attrsets.genAttrs' cfg.overrides (
              option: lib.attrsets.nameValuePair (option.color) (option.value)
            )
          )
        );
      })
    ];
}
