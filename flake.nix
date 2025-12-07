{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
      ];
    };

    homeConfigurations = {
      nixos = home-manager.nixpkgs.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x84-64_linux";
	modules = [ ./home.nix];
      };
    };
  };
}
