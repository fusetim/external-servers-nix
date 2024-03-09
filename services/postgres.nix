{ config, lib, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    ensureDatabases = [ "cours" "mautrix_fb" "ppii1" "ppii1-fusetim" "transcodeck"];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      #type database    DBUser           IPAddr    IPMask AuthMethod    AuthOptions
      host  all         fusetim_cours    0.0.0.0   0      scram-sha-256
      host  mautrix_fb  mautrix_fb       127.0.0.1 32     trust
      host  ppii1       ppii1            0.0.0.0   0      scram-sha-256
      host  ppii1-fusetim ppii1          0.0.0.0   0      scram-sha-256
      host  transcodeck transcodeck      0.0.0.0   0      scram-sha-256
#      host  all       fusetim-cours   ::      0      scram-sha-256
    '';
    # You MUST run these commands in psql (using sudo -u postgres psql) on install:
    # CREATE DATABASE cours;
    # CREATE USER fusetim-cours WITH ENCRYPTED PASSWORD 'yourpass';
    # GRANT ALL PRIVILEGES ON DATABASE cours TO fusetim-cours;
  };
}
