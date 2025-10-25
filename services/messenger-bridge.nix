{ config, lib, pkgs, ... }:

let
  dataDir = "/var/lib/mautrix-facebook/";
in
{
  services.mautrix-meta = {
    # Postgresql will not be automatically configured.
    # On new install, you will need to :
    # run these commands in psql (using sudo -u postgres psql) on install:
    # CREATE DATABASE mautrix_meta;
    # CREATE USER mautrix_meta;
    # GRANT ALL PRIVILEGES ON DATABASE mautrix_meta TO mautrix_meta;
    instances = {
      messenger = {
        enable = true;
        environmentFile = "${dataDir}/secret.env";
        settings = {
          network = {
            mode = "messenger";
          };
          appservice = {
            address = "http://localhost:29319";
            public_address = "https://matrix.fusetim.tk/";
            id = "facebookbot";
            bot = { username = "facebookbot"; };
            hostname = "localhost";
            port = 29319;
          };
          database = {
            type = "postgres";
            uri = "postgresql://mautrix_meta@127.0.0.1/mautrix_meta?sslmode=disable";
          };
          encryption = {
            allow = true;
            default = true;
            verification_levels = {
              receive = "cross-signed-tofu";
              send = "cross-signed-tofu";
              share = "cross-signed-tofu";
            };
          };
          bridge = {
            command_prefix = "!fb";
            relay = {
                enabled = true;
            };
            username_template = "facebook_{userid}";
            permissions = {
              "@fusetim:fusetim.tk" = "admin";
              "fusetim.tk" = "relay";
              "*" = "relay";
            };
          };
          homeserver = {
            address = "https://matrix.fusetim.tk/";
            domain = "fusetim.tk";
            software = "standard";
          };
          logging = {
            formatters = {
              journal_fmt = {
                format = "%(name)s: %(message)s";
              };
            };
            handlers = {
              journal = {
                SYSLOG_IDENTIFIER = "mautrix-facebook";
                class = "systemd.journal.JournalHandler";
                formatter = "journal_fmt";
              };
            };
            root = {
              handlers = [
                "journal"
              ];
              level = "INFO";
            };
            version = 1;
          };
          metrics = {
            enabled = false;
          };
        };
      };
    };
  };
}
