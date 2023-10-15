{ pkgs }:
let
  mcVersion = "1.19.2";
  buildNum = "237";
  jar = pkgs.fetchurl {
    url = "https://papermc.io/api/v2/projects/paper/versions/${mcVersion}/builds/${buildNum}/downloads/paper-${mcVersion}-${buildNum}.jar";
    sha256 = "sha256:09gb70rrv18hbrbhyw0mb92xspia1c9g6lpvqj88j65xckzgl3bl";
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
