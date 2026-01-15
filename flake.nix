{
  description = "Colors of my system";

  inputs = {
    base16.url = "github:SenchoPens/base16.nix";

    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
  };

  outputs = {...} @ inputs: {
    nixosModules = {
      default = import ./default.nix {inherit inputs;};
    };
  };
}
