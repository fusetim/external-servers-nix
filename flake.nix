{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  inputs.nixpkgs_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

  inputs.home-manager.url = "github:nix-community/home-manager/release-24.05";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    { self, nixpkgs, nixpkgs_unstable, home-manager, ...}:
    let
      unstable-module = { config, ... }: {
        nixpkgs.overlays = [
          (final: prev: {
            unstable = import nixpkgs_unstable {
              config = config.nixpkgs.config;
              system = config.nixpkgs.localSystem.system;
              overlays = [];
            };
          })
        ];
      };
    in {
      nixosConfigurations.oidipous = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
              
        specialArgs = { inherit nixpkgs_unstable; };
        modules = [
          (_args: {
            system.configurationRevision =
              nixpkgs.lib.mkIf (self ? rev) self.rev;
          })
          (import ./machines/oidipous.nix)
          unstable-module
          home-manager.nixosModules.home-manager
        ];
      };
    };
}
