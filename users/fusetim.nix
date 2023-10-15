{ config, lib, pkgs, ... }:

{
  users.extraUsers.fusetim = {
    isNormalUser = true;
    home = "/home/fusetim";
    extraGroups = [ "wheel" ];
    shell = pkgs.unstable.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOT3nNgT0yHpzwQDkMhLKycRPM617v4CS4Fg2JMFRhqM openpgp:0xB2498BCA"
      "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAHlHDAqVEE9DUbn+/KfsEaXxijd/PpGbkB5FIx8MxXK+h+7NaQCv1nmD4OC81sb7Bz2Tue7kkCNF6lJbwLwU8M88QCjFXk8j8qp0ahw/KArJYEPf8L7UrGrSuLyaZlvXeIDfuePXx/JImLe3vrs1hl8wOX3PiMHWtGTBvD7JiKcpSGvqQ== (none)"
    ];
  };

  programs.fish.enable = true;

  home-manager.users.fusetim = {
    home.stateVersion = "23.05";
    home.packages = with pkgs.unstable;
      ([
        man-pages
        htop
        acpi
        psmisc
        pciutils
        wget
        valgrind
        cmatrix
        unrar
        unzip
        gnupg
        wget
      ]);

    home.keyboard = null; # Let system chose keyboard

    programs.fish = {
      enable = true;
      plugins = [{
        name = "theme-bobthefish";
        src = let
          bobthefish = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "theme-bobthefish";
            rev = "12b829e0bfa0b57a155058cdb59e203f9c1f5db4";
            sha256 = "00by33xa9rpxn1rxa10pvk0n7c8ylmlib550ygqkcxrzh05m72bw";
          };
        in pkgs.runCommand "theme-bobthefish" { } ''
          mkdir -p $out/functions
          cp -r ${bobthefish}/functions/*.fish $out/functions
          cp ${bobthefish}/*.fish $out/functions
        '';
      }];
    };

    programs.git = {
      enable = true;
      userName = "FuseTim";
      userEmail = "fusetim@gmx.com";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
  };

}
