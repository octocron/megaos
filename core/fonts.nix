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
      font-awesome
      maple-mono.opentype
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      nerd-fonts.noto
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
  };
}
