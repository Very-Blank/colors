{
  description = "Colors of my system flake";

  inputs = {
    base16.url = "github:SenchoPens/base16.nix";

    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
  };

  # To actually use the colors use:
  # config.scheme.base0${"0"-"F"}

  outputs = {...} @ inputs: {
    nixosModules = {
      default = import ./default.nix;
      specialArgs = {inherit inputs;};
      DFDF = {inherit inputs;};
    };
  };
}
