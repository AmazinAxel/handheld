{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: {
      apps.devshell = self.outputs.devShell.${system}.flakeApp;
      formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      packages.nixosConfigurations = let inherit (nixpkgs.lib) nixosSystem; in {
        alechandheld = nixosSystem {
          system = "aarch64-linux";
          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix"
            ./main.nix
          ];
        };
      };
    });
}
