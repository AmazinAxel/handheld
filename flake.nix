{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations."alechandheld" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [ ./main.nix ];
    };
  };
}
