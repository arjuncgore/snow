{ config, pkgs, ... }:

let
  thundermanFont = pkgs.stdenvNoCC.mkDerivation {
    name = "thunderman-font";
    src = ../assets/fonts;
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp $src/Thunderman.ttf $out/share/fonts/truetype/
    '';
  };

  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "jake_the_dog";
    themeConfig = {
      Font = "Thunderman"; # must match the font's actual internal family name
    };
  };
in
{
  fonts.packages = [ sddm-astronaut thundermanFont ];
  environment.systemPackages = [ sddm-astronaut ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [ kdePackages.qtmultimedia ];
    theme = "sddm-astronaut-theme";
  };
}
