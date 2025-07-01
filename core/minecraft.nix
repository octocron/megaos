# systemctl status mc-cobblemon
{
  lib,
  pkgs,
  inputs,
  ...
}: let
  mcVersion = "1.21.1"; # Cobblemon supports 1.21.1
  fabricVersion = "0.17.0"; # Latest Fabric loader for 1.21.1
  serverVersion = lib.replaceStrings ["."] ["_"] "fabric-${mcVersion}";
in {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers]; # Import nix-minecraft module

  services.minecraft-servers = {
    enable = true;
    eula = true; # Accept Minecraft EULA
    declarative = true;
    servers.cobblemon = {
      enable = true;
      package = pkgs.minecraftServers.${serverVersion}.override {loaderVersion = fabricVersion;};
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
          megacron = "uuid"; # https://mcuuid.net/ to get UUID for a username
          player2 = "uuid";
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
            FabricApi = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/0.100.7+1.21.1/fabric-api-0.100.7+1.21.1.jar";
              sha512 = "<FABRIC_API_SHA512>"; # Replace with actual hash
            };
            Cobblemon = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/MdwFAVRL/versions/1.5.2+1.21/Cobblemon-fabric-1.5.2+1.21.jar";
              sha512 = "<COBBLEMON_SHA512>"; # Replace with actual hash
            };
            Sodium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/AANobbMI/versions/0.5.11+mc1.21/sodium-fabric-0.5.11+mc1.21.jar";
              sha512 = "<SODIUM_SHA512>";
            };
          }
        );
      };
      jvmOpts = "-Xms2G -Xmx4G"; # Allocate 2GB min, 4GB max RAM
    };
  };

  #networking.firewall.allowedTCPPorts = [25565]; # Using tailscale: turn off rcon if enabling
}
