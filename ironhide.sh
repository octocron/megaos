#! /bin/bash

sudo disko-install --extra-experimental-features 'flakes' --extra-experimental-features 'nix-command' --flake .#ironhide --disk nvme0 /dev/disk/by-id/nvme-Samsung_SSD_9100_PRO_2TB_S7YCNJ0L202954P --disk nvme1 /dev/disk/by-id/nvme-Samsung_SSD_9100_PRO_2TB_S7YCNJ0L202994E --disk nvme2 /dev/disk/by-id/nvme-Samsung_SSD_9100_PRO_2TB_S7YCNJ0L203102B

