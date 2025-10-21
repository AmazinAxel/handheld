{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-generators, ... }: {
    packages.aarch64-linux = {
      alechandheld = nixos-generators.nixosGenerate {
        system = "aarch64-linux";
        modules = [ ./main.nix ];
        format = "sd-aarch64";
      };
    };
  };
}
