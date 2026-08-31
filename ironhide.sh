#! /bin/bash
set -euo pipefail

read -r -p "This will erase nvme0, nvme1, and nvme2. Continue? [y/N] " answer
[[ "$answer" == [yY] ]] || exit 1

sudo nix \
  --extra-experimental-features "nix-command flakes" \
  run github:nix-community/disko/latest#disko-install -- \
  --flake ".#ironhide" \
  --disk nvme0 /dev/disk/by-id/nvme-Samsung_SSD_9100_PRO_2TB_S7YCNJ0L202954P \
  --disk nvme1 /dev/disk/by-id/nvme-Samsung_SSD_9100_PRO_2TB_S7YCNJ0L202994E \
  --disk nvme2 /dev/disk/by-id/nvme-Samsung_SSD_9100_PRO_2TB_S7YCNJ0L203102B

