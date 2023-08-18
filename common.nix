{ config, pkgs, ... }:

{
  imports = [ ./users/fusetim.nix ];

  system.stateVersion = "23.05";

  time.timeZone = "Europe/Paris";

  nixpkgs.config.allowUnfree = true;

  boot.tmp.cleanOnBoot = true;

  programs.fish.enable = true;

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;
  environment.systemPackages = with pkgs; [ nano wget git ];
}
