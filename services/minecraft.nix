{ config, lib, pkgs, ... }:

{

  services.minecraft-server = {
    package = import ./paper/paper.nix { inherit pkgs; };
    enable = true;
    jvmOpts = "-Xmx2048M -Xms2048M";
    eula = true; #required
    declarative = true;
    openFirewall = true;
    whitelist = {
        sookie135 = "6fe5e6f6-e6ae-41cd-896d-7cd5cd59cfde";
        e1078 = "4bc00a97-b4b9-4144-9fd7-df3615b494db";
        MasterMisterL = "54d080a9-fd68-4f30-810b-4079ddc216ad";
        andreslucero = "dfb13ebd-ecb4-4c84-88db-c938dad9e9c1";
        joker941 = "40c6c59a-5bb3-453c-bfd3-f7f5b08fcb30";
        JeanPaul86 = "678f84bb-62fe-4e1d-8fb3-956bf1ee3779";
        iliane__ = "9f52d7bc-b409-4d6c-922f-0364f7271e75";
        Axlek = "c43d4f4e-18ff-47e5-8c8b-0a9666bb8d9e";
        Omega98012 = "1f3823ee-7c52-4bef-a1be-8b5daefc9f03";
        kultrivs = "9d1e84a1-5575-3541-9e5a-38626e393ad5"; #CRACK
        __Adem__ = "8e19c60d-09fe-4abd-9456-3f7a5ab80b4c";
        Asaerd = "e84fb38a-0dd5-4527-98d4-4f159ea47035";
        Jules0806 = "be087d7c-52bf-4f01-b443-e1b82fb80a9d";
        Santeh = "ab4fb449-e210-4c42-94c8-25384ac904e3";
        Skan234401 = "18429015-d3d7-4c4a-aeb3-a6341a1fd65d";
        Tim54000 = "6698b4e2-8c35-4d60-b690-7b3602fa0691";
#        Tim54000 = "e0406519-da28-3e53-be53-02e498582680";
        Swargus = "864b6405-acd7-408a-a2d7-e2feb5f9fc8f";
        Citsuna = "a73756f1-ae23-4cd9-a0fa-bb236f3b4c4c";
        MrAgentLew = "e1ffca17-1778-4a12-9427-12cd05737cea";
        ParPitieUlm = "39e593de-cd3c-484d-b5a6-3285ee20412d";
        #SUPS
        Akashi42 = "d139d891-2f73-4daa-976e-b4d66d82e204";
        Rusgu = "88f936a0-f928-44d6-afd5-6d0850337b37";
        cocci01 = "8543d1ab-9f2b-4081-91da-2398448b46ea";
        Azkatar = "da061f6c-bf9a-4303-9095-56c0992ea134";
        Spatia = "7db15842-38f1-45f4-a42e-e663c4ccae4d";
        caburp = "382079c8-0cff-4f86-9b09-1cc8216054bc";
    };
    # see here for more info: https://minecraft.gamepedia.com/Server.properties#server.properties
    serverProperties = {
      server-port = 25565;
      gamemode = "survival";
      motd = "\\u00a71\\u00a7k\\u2261\\u00a72\\u00a7k\\u2261\\u00a73\\u00a7k\\u2261\\u00a74\\u00a7k\\u2261\\u00a75\\u00a7k\\u2261\\u00a76\\u00a7k\\u2261\\u00a77\\u00a7k\\u2261\\u00a7c\\u00a7k\\u2261\\u00a76\\u00a7l MPI\\u00a76 Saint-Louis \\u00a71\\u00a7k\\u2261\\u00a72\\u00a7k\\u2261\\u00a73\\u00a7k\\u2261\\u00a74\\u00a7k\\u2261\\u00a75\\u00a7k\\u2261\\u00a76\\u00a7k\\u2261\\u00a77\\u00a7k\\u2261\\u00a7c\\u00a7k\\u2261\\u00a76\\u00a7l\\u00a7r\\n\\u00a7bPropuls\\u00e9 par \\u00a7b\\u00a7o\\u00a7nPaperMC 1.19.2\\u00a7b & \\u00a7b\\u00a7o\\u00a7nNixOS";
      max-players = 48;
      enable-query = true;
      enable-rcon = true;
      server-ip="0.0.0.0";
      white-list = true;
      online-mode = false;
      # This password can be used to administer your minecraft server.
      # Exact details as to how will be explained later. If you want
      # you can replace this with another password.
      "rcon.password" = "VousMeSuivez?2021";
      spawn-protection = -1;
      level-seed = "10292992";
    };
  };

}
