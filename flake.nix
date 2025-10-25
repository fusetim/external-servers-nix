{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  inputs.nixpkgs_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

  inputs.home-manager.url = "github:nix-community/home-manager/release-24.11";
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
      legacy-module = { config, ... }: {
        nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];
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
          legacy-module
          unstable-module
          home-manager.nixosModules.home-manager
        ];
      };
    };
}
