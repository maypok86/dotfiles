{ inputs, system, ... }:

let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
in
{
  huawei-amd = nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/huawei-amd/hardware-configuration.nix
      ../system/configuration.nix
    ];
  };
}
