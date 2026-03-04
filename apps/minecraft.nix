# systemctl status mc-cobblemon
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.services.minecraft;
  mcVersion = "1.21.1"; # Minecraft Version (Game Version)
  fabricVersion = "0.16.4"; # Latest Fabric loader for mcVersion
  cobblemonVersion = lib.replaceStrings [ "." ] [ "_" ] "fabric-${mcVersion}";
in
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ]; # Import nix-minecraft module
  options.services.minecraft.enable = mkEnableOption "enable minecraft";

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

    services.minecraft-servers = {
      enable = true;
      eula = true; # Accept Minecraft EULA
      dataDir = "/var/lib/minecraft";
      servers = {
        cobblemon = {
          enable = true;
          package = pkgs.fabricServers.${cobblemonVersion}.override { loaderVersion = fabricVersion; };
          whitelist = {
            needMoreInput = "9c86bb75-1ecc-484f-a008-7ce055b47208"; # https://mcuuid.net/ to get UUID for a username
            #player2 = "uuid";
          };
          serverProperties = {
            server-port = 25565;
            difficulty = "easy"; # peaceful, easy, normal, hard
            gamemode = "survival"; # adventure, creative, survival, spectator
            generate-structures = true;
            motd = "§3♥NixOS♥ §4Cobblemon §6Server";
            max-players = 10;
            online-mode = true; # false = cracked server, meaning players can join without authentication, always keep true!!
            player-idle-timeout = 0; # idle indefinitely
            level-seed = ""; # Optional: Set a world seed, default is blank
            level-type = "amplified"; # normal, flat, large_biomes, amplified, single_biome_surface
            white-list = true;
            server-name = "Megamon";
            enable-rcon = true;
            "rcon.password" = "P1kachu";
          };
          symlinks = {
            # get versionID from https://modrinth.com/mods looks like: 19viaBAW
            # nix run github:Infinidoge/nix-minecraft#nix-modrinth-prefetch -- versionID
            mods = pkgs.linkFarmFromDrvs "mods" (
              builtins.attrValues {
                #-------------------BASE------------------------------>>
                FabricApi = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/19viawBV/fabric-api-0.116.4%2B1.21.1.jar";
                  sha512 = "95060def77b54ba6c6eb5af45b478ec6926f33f145d8f3933cd90cb2b6ab6913459d3d0afa3afcb01fca07d714628414a41ee8b6845261e88d92b83bfc668ad8";
                };
                Cobblemon = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/MdwFAVRL/versions/v77SHSXW/Cobblemon-fabric-1.6.1%2B1.21.1.jar";
                  sha512 = "b7082befee07efd3e0c5857807f739082df5994ec0e7fe3217ce6cdaec7d2ca47ed51bd129096fd4eca8cbcf7de415d14602868a3357980ff88e55b3148dc7f4";
                };
                #------------------FEATURES--------------------------->>
                EBE = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/OVuFYfre/versions/HBZAPs3u/enhancedblockentities-0.10.2%2B1.21.jar";
                  sha512 = "60e01db603fcf1392c0cd5c3ce742e568f7d445d83fe60828b21f546e7d29fb6947231f22d28e29b07f4bdcb767b6dc2a2398b4decea665ecba1166690a44d49";
                };
                Lithium = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/MM5BBBOK/lithium-fabric-0.15.0%2Bmc1.21.1.jar";
                  sha512 = "fd3215501ebe8f6590cdf1ccc58182873cad8d74ebc4b0b3a2f5724748b9cb04c2b967503c072311dfbca9ba856195dc4662f3395a071b294fa0acfdd2a86bf6";
                };
                #------------------DEPS------------------------------->>
              }
            );
          };
        };
        # NOTE: Future AI World!
        clankaVille = { };
        jvmOpts = "-Xms2G -Xmx4G"; # Allocate 2GB min, 4GB max RAM
      };
    };

    #networking.firewall.allowedTCPPorts = [25565]; # Using tailscale: turn off rcon if enabling
  };
}
