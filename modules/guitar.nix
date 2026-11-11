{ config, pkgs, ... }:
let
    guitarix-pw = pkgs.symlinkJoin {
        name = "guitarix-pw";
        paths = [ pkgs.guitarix ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
            wrapProgram $out/bin/guitarix \
            --prefix LD_LIBRARY_PATH : "${config.services.pipewire.package.jack}/lib"
            '';
    };
in {
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        jack.enable = true;
        pulse.enable = true;

        extraConfig.pipewire."91-guitar-mic-mix" = {
            "context.objects" = [
                {
                    factory = "adapter";
                    args = {
                        "factory.name"     = "support.null-audio-sink";
                        "node.name"        = "guitar_mic_mix";
                        "node.description" = "Guitar + Mic";
                        "media.class"      = "Audio/Source/Virtual";
                        "audio.position"   = [ "FL" "FR" ];
                    };
                }
            ];
        };
    };

    security.rtkit.enable = true;

    security.pam.loginLimits = [
        { domain = "@audio"; type = "-"; item = "memlock"; value = "unlimited"; }
        { domain = "@audio"; type = "-"; item = "rtprio"; value = "99"; }
    ];

    users.users.arjungore.extraGroups = [ "audio" ];

    environment.systemPackages = [
        guitarix-pw
        pkgs.qpwgraph
    ];
}
