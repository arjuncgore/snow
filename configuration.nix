{ config, pkgs, ... }:

{
    imports =
        [
            /etc/nixos/hardware-configuration.nix
            ./modules/vm.nix
            ./modules/display-manager.nix
            ./modules/guitar.nix
        ];

    #### System Settings
    ## Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    ## Hostname
    networking.hostName = "snow";

    ## Networking
    # networking.wireless.enable = true;
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    networking.networkmanager.enable = true;

    ## Set your time zone.
    time.timeZone = "America/New_York";

    ## Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    ## Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    ## User Account
    users.users."arjungore" = {
        isNormalUser = true;
        shell = pkgs.zsh;
        description = "Arjun Gore";
        extraGroups = [ "networkmanager" "wheel" "seat" "audio" ];
        packages = with pkgs; [];
    };

    ## Allow unfree packages
    nixpkgs.config.allowUnfree = true;


    #### System Packages `nix search ...`
    environment.systemPackages = with pkgs; [

        ## Terminal Utilities
        vim
        neovim
        tmux
        git
        tree
        stow
        zip
        unzip
        fastfetch
        zsh
        zsh-powerlevel10k
        yazi
        btop
        zoxide
        eza
        bat
        ripgrep
        fd
        playerctl
        libnotify
        fzf
        lazygit

        ## Desktop Environment
        wezterm
        swaylock-effects
        wofi
        mako
        swaybg
        swayidle
        i3status-rust
        thunar

        ## Dependencies
        (lib.hiPrio nettools)
        (lib.hiPrio coreutils)
        toybox
        nodejs
        bash
        wayland
        alsa-utils
        xdg-utils
        adwaita-icon-theme
        grim     
        wl-clipboard
        slurp
        wayfreeze
        swappy
        wireplumber
        nixd
        alejandra

        ## Applications
        discordo
        equibop
        spotify
        google-chrome
        vscode
        firefox
        swayimg
        vlc
        mpv
        chatterino7
        kdePackages.kdenlive
        (wrapOBS { plugins = with obs-studio-plugins; [ obs-pipewire-audio-capture ]; })

        ## Programming
        gcc
        rustc
        cargo
        rustfmt
        clippy
        rust-analyzer
        pkg-config
        openssl

        ## Gaming
        steam
        nestopia-ue
        osu-lazer-bin
    ];


    #### Other Settings

    ## Zsh Settings
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        promptInit = ''
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        '';
    };

    ## Security
    programs.nix-ld.enable = true;
    services.openssh.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];

    ## NixOS Version
    system.stateVersion = "26.05";

    ## Audio
    services.seatd.enable = true;
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        audio.enable = true;
        wireplumber.enable = true;
        alsa = {
            enable = true;
            support32Bit = true;
        };
        pulse.enable = true;
    };
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

    ## Fonts
    fonts.packages = with pkgs; [ nerd-fonts.meslo-lg ];

    ## Default Applications
    xdg.mime = {
        enable = true;
        defaultApplications = {
            "text/html" = "zen.desktop";
            "x-scheme-handler/http" = "zen.desktop";
            "x-scheme-handler/https" = "zen.desktop";
            "x-scheme-handler/chrome" = "zen.desktop";
            "application/xhtml+xml" = "zen.desktop";
            "image/jpeg" = "swayimg.desktop";
            "image/png" = "swayimg.desktop";
            "image/gif" = "swayimg.desktop";
            "image/webp" = "swayimg.desktop";
            "image/svg+xml" = "swayimg.desktop";
            "video/mp4" = "mpv.desktop";
            "video/x-matroska" = "mpv.desktop";
            "video/webm" = "mpv.desktop";
            "video/quicktime" = "mpv.desktop";
        };
    };

    ## Cursor
    environment.sessionVariables = {
        XCURSOR_THEME = "Adwaita";
        XCURSOR_SIZE = "24";
    };

    
    #### Mounted Arch
    fileSystems."/mnt/arch" = {
        device = "/dev/disk/by-uuid/e35e8c96-ad97-415f-afc8-a5bff71a2341";
        fsType = "ext4";
        options = [ "nofail" ];
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
