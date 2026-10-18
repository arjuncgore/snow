{ config, pkgs, inputs, ... }:

let
    mcsrPkgs = inputs.mcsr-nixos.packages.x86_64-linux;

    waywall = pkgs.waywall.overrideAttrs {
        version = "unstable";
        src = inputs.waywall;
        # src = pkgs.fetchFromGitHub {
        #     owner = "tesselslate";
        #     repo = "waywall";
        #     rev = "3e144aa9fce0724758ba33b14b82c6bba9255160";
        #     hash = "";
        # };
    };


    ## Helper for tmpfs
    mkInstance = name: {
        saves = ".local/share/PrismLauncher/instances/${name}/minecraft/saves";
        size = "1G";
        tmpfs = true;
        user = "arjungore";
        worlds = [
            "mcsr/worlds/ZZ_Bastion"
            "mcsr/worlds/ZZ_Blaze"
            "mcsr/worlds/ZZ_Crafting"
            "mcsr/worlds/ZZ_Portal"
            "mcsr/worlds/ZZ_Preemptive"
            "mcsr/worlds/ZZ_Zero"
            "mcsr/worlds/ZZ_SearchCrafting"
            "mcsr/worlds/ZZ_MCSR"
        ];
    };

in 
    {
    imports = [
        inputs.mcsr-nixos-jude.nixosModules.tmpfs-symlink
    ];

    #### System Packages
    environment.systemPackages = [
        (pkgs.prismlauncher.override {
            jdks = [ mcsrPkgs.graalvm-21 ];
            additionalLibs = [ 
                pkgs.libXtst
                pkgs.libXext
                pkgs.libX11
                pkgs.libxkbcommon
                pkgs.libxcb
                pkgs.libxt
                pkgs.libxinerama
                pkgs.jemalloc
            ];
        })
        waywall

        pkgs.jemalloc
        pkgs.openjdk21

        inputs.ninjabrain-bot-xwayland.packages.${pkgs.stdenv.hostPlatform.system}.default

        mcsrPkgs.ninjabrain-bot
        mcsrPkgs.paceman-tracker
        mcsrPkgs.obs-cli
    ];

    #### TMPFS
    services.tmpfs-symlink = {
        enable = true;
        instances = map mkInstance [ "RSG" "Icarus" "Ranked" "SSG_Vine_Seed" ];
    };

    #### Debounce Override
    environment.etc."libinput/local-overrides.quirks".text = ''
    [Never Debounce]
    MatchUdevType=mouse
    ModelBouncingKeys=1
    '';

}
