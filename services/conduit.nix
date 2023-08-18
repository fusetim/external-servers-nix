{ config, lib, pkgs, ... }:

{
  services.matrix-conduit = {
    enable = true;
    package = pkgs.unstable.matrix-conduit;
    settings.global = {
      port = 6167;
      server_name = "fusetim.tk";
      database_backend = "rocksdb";
      allow_registration = false;
    };
  };
}
