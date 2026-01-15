{
  description = "Colors of my system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    base16.url = "github:SenchoPens/base16.nix";

    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
  };

  # To actually use the colors use:
  # config.scheme.base0${"0"-"F"}

  outputs = {...} @ inputs: {
    nixosModules.default = {
      lib,
      config,
      ...
    }: {
      imports = [
        inputs.base16.nixosModule
      ];

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

            default = [];
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
    };
  };
}
