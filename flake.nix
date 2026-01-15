{
  description = "Colors of my system";

  inputs = {};

  outputs = {...}: {
    nixosModules = {
      default = import ./default.nix;
    };
  };
}
