{ pkgs, config, ... }: {

  imports = [
    ../hardware/oracle-ampere.nix
    ../common.nix
    ../services/minecraft.nix
    ../services/caddy.nix
    ../services/conduit.nix
    ../services/postgres.nix
    ../services/discord-bridge.nix
    ../services/messenger-bridge.nix
  ];
  
  # Hostname
  networking.hostName = "oidipous";

  environment.systemPackages = with pkgs; [
    dconf
    gcc
  ];
  
  # HomeManager
  home-manager.useGlobalPkgs = true;


  # Networking
  ## Open ports in the firewall.
  networking = {
    firewall.allowPing = true;
    firewall.allowedTCPPortRanges = [
      { from = 22; to = 22; } # OpenSSH
      { from = 80; to = 80; } # Caddy
      { from = 443; to = 443; } # Caddy
      { from = 25565; to = 25565; } # Minecraft
      { from = 25575; to = 25575; } # Minecraft RCON
      { from = 5432;  to = 5432;  } # Postgres
    ];
    firewall.allowedUDPPortRanges = [ 
      { from = 22; to = 22; } # OpenSSH
      { from = 80; to = 80; } # Caddy
      { from = 443; to = 443; } # Caddy
      { from = 25565; to = 25565; } # Minecraft
      { from = 25575; to = 25575; } # Minecraft RCON
      { from = 5432;  to = 5432;  } # Postgres
    ];
    defaultGateway = "10.0.0.1";
    defaultGateway6 = "";

    interfaces = {
      enp0s3 = {
        ipv4.addresses = [
          { address="10.0.0.87"; prefixLength=24; }
        ];

        ipv6.addresses = [
          { address="2603:c022:0:3aa::cafe"; prefixLength=56; }
        ];
      };
    };
  };

  # OpenSSH
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
    settings.PasswordAuthentication = false;
  };

  # Flakes
  nix.package = pkgs.nixUnstable;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
