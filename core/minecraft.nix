# systemctl status mc-cobblemon
{
  lib,
  pkgs,
  inputs,
  ...
}: let
  mcVersion = "1.21.1"; # Cobblemon supports 1.21.1
  fabricVersion = "0.17.0"; # Latest Fabric loader for 1.21.1
  cobblemonVersion = lib.replaceStrings ["."] ["_"] "fabric-${mcVersion}";
in {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers]; # Import nix-minecraft module
  nixpkgs.overlays = [inputs.nix-minecraft.overlay];

  services.minecraft-servers = {
    enable = true;
    eula = true; # Accept Minecraft EULA
    dataDir = "/var/lib/minecraft";
    servers.cobblemon = {
      enable = true;
      package = pkgs.fabricServers.${cobblemonVersion}.override {loaderVersion = fabricVersion;};
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
        white-list = false;
        whitelist = {
          needMoreInput = "9c86bb75-1ecc-484f-a008-7ce055b47208"; # https://mcuuid.net/ to get UUID for a username
          #player2 = "uuid";
        };
        server-name = "Megamon";
        enable-rcon = true;
        "rcon.password" = "P1kachu";
      };
      symlinks = {
        # get versionID from https://modrinth.com/mods
        # nix run github:Infinidoge/nix-minecraft#nix-modrinth-prefetch -- versionID
        mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            #-------------------BASE------------------------------>>
            FabricApi = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/19viawBV/fabric-api-0.116.4%2B1.21.1.jar";
              sha512 = "";
            };
            Cobblemon = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/MdwFAVRL/versions/v77SHSXW/Cobblemon-fabric-1.6.1%2B1.21.1.jar";
              sha512 = "";
            };
            #------------------FEATURES--------------------------->>
            EBE = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/OVuFYfre/versions/HBZAPs3u/enhancedblockentities-0.10.2%2B1.21.jar";
              sha512 = "";
            };
            Lithium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/MM5BBBOK/lithium-fabric-0.15.0%2Bmc1.21.1.jar";
              sha512 = "";
            };
            #------------------DEPS------------------------------->>
          }
        );
      };
      jvmOpts = "-Xms2G -Xmx4G"; # Allocate 2GB min, 4GB max RAM
    };
  };

  #networking.firewall.allowedTCPPorts = [25565]; # Using tailscale: turn off rcon if enabling
}
