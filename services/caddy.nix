{ config, lib, pkgs, ... }:

let
  Caddyfile = pkgs.writeTextDir "Caddyfile" ''
    matrix.fusetim.tk {
      log
      encode gzip zstd
      tls fusetim.log@gmx.com
      handle / {
          respond "Hello world!" 200
      }
      reverse_proxy /_matrix/* [::1]:6167
    }
  '';
in
  {
    services.caddy = {
      enable = true;
      configFile = "${Caddyfile}/Caddyfile";
    };
  }
