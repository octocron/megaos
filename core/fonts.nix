{ pkgs, ... }:
{
  #------------------FONTS-SYSTEM-WIDE------------------#
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "Noto Sans"
          "IPAGothic"
        ];
        serif = [
          "Noto Serif"
          "IPAMincho"
        ];
        monospace = [
          "Maple Mono"
          "Noto Sans Mono"
          "IPAGothic"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    packages = with pkgs; [
      ipafont
      maple-mono.opentype
      nerd-fonts.noto
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      nerd-fonts.ubuntu
    ];
  };
}
