{ config, lib, pkgs, ... }:

let
  dataDir = "/var/lib/mautrix-facebook/";
in
{
  services.mautrix-facebook = {
    enable = true;
    # Postgresql will not be automatically configured.
    # On new install, you will need to :
    # run these commands in psql (using sudo -u postgres psql) on install:
    # CREATE DATABASE mautrix_fb;
    # CREATE USER mautrix_fb;
    # GRANT ALL PRIVILEGES ON DATABASE mautrix_fb TO mautrix_fb;
    configurePostgresql = false;
    environmentFile = "${dataDir}/secret.env";
    settings = {
      appservice = {
        address = "http://localhost:29319";
        bot_username = "facebookbot";
        database = "postgresql://mautrix_fb@127.0.0.1/mautrix_fb";
        hostname = "localhost";
        port = 29319;
      };
      bridge = {
        command_prefix = "!fb";
        encryption = {
          allow = true;
          default = true;
          verification_levels = {
            receive = "cross-signed-tofu";
            send = "cross-signed-tofu";
            share = "cross-signed-tofu";
          };
        };
        username_template = "facebook_{userid}";
        permissions = {
          "@fusetim:matrix.fusetim.tk" = "admin";
          "matrix.fusetim.tk" = "relay";
          "*" = "relay";
        };
      };
      homeserver = {
        address = "https://matrix.fusetim.tk/";
        domain = "matrix.fusetim.tk";
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
      manhole = {
        enabled = false;
      };
      metrics = {
        enabled = false;
      };
    };
  };
}
