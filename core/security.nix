{ username, ... }:
{
  #-----------------------SECURITY-----------------------#
  security = {
    rtkit.enable = true;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "${username}" ];
          keepEnv = true;
          noPass = false;
        }
        {
          groups = [ "wheel" ];
          noPass = false; # Allows passwordless execution
        }
      ];
    };

    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if ( subject.isInGroup("users") && (
           action.id == "org.freedesktop.login1.reboot" ||
           action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
           action.id == "org.freedesktop.login1.power-off" ||
           action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          ))
          { return polkit.Result.YES; }
        })
      '';
    };
    pam.services.swaylock = {
      text = ''auth include login '';
    };
    sudo.extraConfig = ''
      Defaults      timestamp_timeout=1800
    '';
  };
}
