{ config, pkgs, ... }:
let
  guitarix-pw = pkgs.symlinkJoin {
    name = "guitarix-pw";
    paths = [ pkgs.guitarix ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/guitarix \
        --prefix LD_LIBRARY_PATH : "${pkgs.pipewire.jack}/lib"
    '';
  };
in {
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  security.rtkit.enable = true;

  security.pam.loginLimits = [
    { domain = "@audio"; type = "-"; item = "memlock"; value = "unlimited"; }
    { domain = "@audio"; type = "-"; item = "rtprio"; value = "99"; }
  ];

  users.users.arjungore.extraGroups = [ "audio" ];

  environment.systemPackages = with pkgs; [
    guitarix-pw
    guitarix    # keep the original too if you want, though guitarix-pw is what you'll actually run
    qjackctl
  ];
}
