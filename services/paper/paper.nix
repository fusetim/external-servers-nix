{ pkgs }:
let
  mcVersion = "1.19.2";
  buildNum = "237";
  jar = pkgs.fetchurl {
    url = "https://fill-data.papermc.io/v1/objects/42c864b203ac6349e22305c13ec3ad3f9831067513c1fdc32a13bdf85f34c794/paper-1.19.2-237-mojang.jar";
    sha256 = "sha256:42c864b203ac6349e22305c13ec3ad3f9831067513c1fdc32a13bdf85f34c794";
    curlOptsList = [
      "--user-agent" "fusetim/external-servers-nix/1.0.0 (https://github.com/fusetim/external-servers-nix)"
    ]
  };
in pkgs.stdenv.mkDerivation {
  pname = "papermc";
  version = "${mcVersion}r${buildNum}";

  preferLocalBuild = true;

  dontUnpack = true;
  dontConfigure = true;

  buildPhase = ''
    cat > minecraft-server << EOF
    #!${pkgs.bash}/bin/sh
    exec ${pkgs.openjdk17}/bin/java \$@ -jar $out/share/papermc/papermc.jar nogui
  '';

  installPhase = ''
    install -Dm444 ${jar} $out/share/papermc/papermc.jar
    install -Dm555 -t $out/bin minecraft-server
  '';

  meta = {
    description = "High-performance Minecraft Server";
    homepage    = "https://papermc.io/";
    license     = pkgs.lib.licenses.gpl3Only;
    platforms   = pkgs.lib.platforms.unix;
    maintainers = with pkgs.lib.maintainers; [ aaronjanse neonfuz ];
  };
}
