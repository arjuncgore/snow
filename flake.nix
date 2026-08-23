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

    outputs = { self, nixpkgs, jay, zen-browser, ... }@inputs: {
        nixosConfigurations.snow = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
                ./configuration.nix
                ./modules/mcsr.nix
                jay.nixosModules.default
                {
                    programs.jay.enable = true;
                    environment.systemPackages = [
                        zen-browser.packages.x86_64-linux.default
                    ];
                }
            ];
        };
    };
}
