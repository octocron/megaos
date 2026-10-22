{
  lib,
  username,
  ...
}:
{
  #-----------------NIX-OPTIMIZATIONS------------------#
  nix = {
    nrBuildUsers = 64;
    settings = {
      cores = 2; # 0 means all available cores
      warn-dirty = false;
      auto-optimise-store = true;
      download-buffer-size = 240 * 1024 * 1024;
      min-free = 10 * 1024 * 1024;
      max-free = 200 * 1024 * 1024;
      max-jobs = 4; # "auto" means all, 0 means use remote specified in builders
      trusted-users = [
        "root"
        "@wheel"
      ];
      allowed-users = [
        "root"
        "${username}"
        "@wheel"
      ];
      experimental-features = [
        "flakes"
        "nix-command"
      ];

      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  # Allow unfree packages
  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        # For when dangon devs use EOL dependencies, grrrr..
      ];
    };

    overlays = [
      (final: prev: {
        # gearlever: fix makeCWrapper argument splitting + gapps expansion
        gearlever = prev.gearlever.overrideAttrs (old: {
          makeWrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            (prev.lib.makeBinPath [
              prev.file
              prev.p7zip
              prev.which
              prev.appimage-run
              prev.desktop-file-utils
              prev.gtk4
              prev.binutils
              prev.libnotify
              prev.dwarfs
              prev.squashfsTools
            ])
          ];
          preFixup = (old.preFixup or "") + ''
            makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
          '';
        });

        # udiskie: skip flaky keyutils test under Python 3.14
        udiskie = prev.udiskie.overrideAttrs (old: {
          doCheck = false;
        });

        # linuxPackages_zen: fix out-of-tree modules for current aggregateModules
        linuxPackages_zen = prev.linuxPackages_zen.extend (
          kfinal: kprev: {
            # v4l2loopback: drop depmod metadata so it does not collide with the kernel modules package
            v4l2loopback = kprev.v4l2loopback.overrideAttrs (old: {
              installFlags = prev.lib.filter (f: f != "DEPMOD=true") (old.installFlags or [ ]);
              postInstall = (old.postInstall or "") + ''
                rm -f $out/lib/modules/*/modules.alias \
                      $out/lib/modules/*/modules.alias.bin \
                      $out/lib/modules/*/modules.builtin \
                      $out/lib/modules/*/modules.builtin.bin \
                      $out/lib/modules/*/modules.builtin.alias.bin \
                      $out/lib/modules/*/modules.builtin.modinfo \
                      $out/lib/modules/*/modules.dep \
                      $out/lib/modules/*/modules.dep.bin \
                      $out/lib/modules/*/modules.devname \
                      $out/lib/modules/*/modules.softdep \
                      $out/lib/modules/*/modules.symbols \
                      $out/lib/modules/*/modules.symbols.bin
              '';
            });

            # openrazer: use modules_install so .ko.cer files are generated
            openrazer = kprev.openrazer.overrideAttrs (old: {
              makeFlags = (old.makeFlags or [ ]) ++ [
                "INSTALL_MOD_PATH=${placeholder "out"}"
                "INSTALL_MOD_DIR=kernel/drivers/hid"
                "INSTALL_MOD_STRIP=1"
                "DEPMOD=true"
              ];
              installTargets = [ "modules_install" ];
              installFlags = [
                "-C"
                "${kprev.kernel.dev}/lib/modules/${kprev.kernel.modDirVersion}/build"
                "M=$(PWD)/driver"
              ];
              installPhase = null;
            });
          }
        );
      })
    ];
  };
}
