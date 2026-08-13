{
    description = "Jay WM Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        jay = {
            url = "github:mahkoh/jay";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        zen-browser = {
            url = "github:youwen5/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        mcsr-nixos = {
            url = "https://git.uku3lig.net/uku/mcsr-nixos/archive/main.tar.gz";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };

    outputs = { self, nixpkgs, jay, zen-browser, mcsr-nixos, ... }: {
        nixosConfigurations.snow = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
                jay.nixosModules.default
                mcsr-nixos.nixosModules.waywall
                ({ pkgs, ... }:
                    let
                        mcsrPkgs = mcsr-nixos.packages.x86_64-linux;
                    in {
                        programs.jay.enable = true;
                        environment.systemPackages = [
                            zen-browser.packages.x86_64-linux.default
                            mcsrPkgs.ninjabrain-bot
                            (pkgs.prismlauncher.override {
                                jdks = [ mcsrPkgs.graalvm-21 ];
                            })
                        ];
                    })
            ];
        };
    };
}
