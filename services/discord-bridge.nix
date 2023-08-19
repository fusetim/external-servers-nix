{ config, lib, pkgs, ... }:

let
  dataDir = "/var/lib/matrix-appservice-discord";
in
{
  services.matrix-appservice-discord = {
    enable = true;
    port = 9005;
    serviceDependencies = [ "conduit.service" ];
    environmentFile = "${dataDir}/secrets.env";
    settings = {
      bridge = {
        domain = "fusetim.tk";
        homeserverUrl = "https://matrix.fusetim.tk/";
        port = 9005;
        presenceInterval = 1000;
        disablePresence = false;
        disableTypingNotifications = false;
        disableDeletionForwarding = false;
        disablePortalBridging = true;
        enableSelfServiceBridging = false;
        disableReadReceipts = false;
        disableJoinLeaveNotifications = false;
        disableInviteNotifications = false;
        disableRoomTopicNotifications = false;
        determineCodeLanguage = false;
        invalidTokenMessage = "Your Discord bot token seems to be invalid, and the bridge cannot function. Please update it in your bridge settings and restart the bridge";
        adminMxid = "@fusetim:fusetim.tk";
      };
      auth = {
        # Token in environmentFile
        clientID = "";
        botToken = "";
        usePrivilegedIntents = false;
      };
      logging = {
        files = [
            { file = "${dataDir}/logs/debug.log"; disable = ["PresenceHandler"]; }
            { file = "${dataDir}/logs/warn.log"; level = "warn"; }
            { file = "${dataDir}/logs/botlogs.log"; level = "info"; enable = [ "DiscordBot" ];}
        ];
      };
      database = {
        filename = "${dataDir}/discord.db";
      };
      room = {
        defaultVisibility = "private";
      };
      channel = {
        namePattern = "[Discord] :guild #:name";
        deleteOptions = {
          disableMessaging = true;
          unsetRoomAlias = true;
          unlistFromDirectory = true;
          setInviteOnly = true;
          ghostsLeave = true;
        };
      };
      limits = {
        roomGhostJoinDelay = 6000;
        discordSendDelay = 1500;
      };
      ghosts = {
        nickPattern = ":nick";
        usernamePattern = ":username#:tag";
      };
      metrics = {
        enable = false;
        port = 9001;
        host = "127.0.0.1";
      };
    };
  };
}
