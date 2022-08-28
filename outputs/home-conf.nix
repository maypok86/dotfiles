{ inputs, system, ... }:

with inputs;

let
  fishOverlay = f: p: {
    inherit fish-bobthefish-theme fish-keytool-completions;
  };

  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = true;

    overlays = [
      fishOverlay
      nurpkgs.overlay
      neovim-flake.overlays.default
      (f: p: { tex2nix = tex2nix.defaultPackage.${system}; })
      ((import ../home/overlays/md-toc) { inherit (inputs) gh-md-toc; })
      # (import ../home/overlays/protonvpn-gui)
      (import ../home/overlays/ranger)
    ];
  };

  nur = import nurpkgs {
    inherit pkgs;
    nurpkgs = pkgs;
  };

  imports = [
    neovim-flake.nixosModules.hm
    ../home/home.nix
  ];

  mkHome = { }: (
    home-manager.lib.homeManagerConfiguration rec {
      inherit pkgs;

      extraSpecialArgs = {
        addons = nur.repos.rycee.firefox-addons;
      };

      modules = [{ inherit imports; }];
    }
  );
in
{
  maypok-home = mkHome { };
}
