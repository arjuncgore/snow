# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		/etc/nixos/hardware-configuration.nix
		];

# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "snow"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
		networking.networkmanager.enable = true;

# Set your time zone.
	time.timeZone = "America/New_York";

# Select internationalisation properties.
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

# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users."arjungore" = {
		isNormalUser = true;
		shell = pkgs.zsh;
		description = "Arjun Gore";
		extraGroups = [ "networkmanager" "wheel" "seat" "audio" ];
		packages = with pkgs; [];
	};

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
			neovim
			tmux
			git
			tree
			stow
			wezterm
			zip
			unzip
			fastfetch
			swaylock
			wofi
			zsh
			zsh-powerlevel10k
			mako
			yazi
			btop
			wayland
			swaybg
			swayidle
			i3status-rust
			adwaita-icon-theme
			alsa-utils
			xdg-utils

			grim     
			wl-clipboard
			slurp
			wayfreeze
			swappy

			zoxide
			eza
			bat

			(lib.hiPrio nettools)
			toybox
			nodejs

			discordo
			spotify

			waywall    

			google-chrome
			thunar
			vscode
			equibop
			firefox

			playerctl
			wireplumber

			gcc

			rustc
			cargo
			rustfmt
			clippy
			rust-analyzer
			pkg-config
			openssl

			nixd
			alejandra

			swayimg
			vlc
			mpv


# wget
			];

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
		promptInit = ''
			source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
			'';
	};


# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
	services.openssh.enable = true;

# Open ports in the firewall.
	networking.firewall.allowedTCPPorts = [ 22 ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "26.05"; # Did you read the comment?

		services.seatd.enable = true;
# services.flatpak.enable = true;
	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
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

	fonts.packages = with pkgs; [
		nerd-fonts.meslo-lg
	];

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

	environment.sessionVariables = {
		XCURSOR_THEME = "Adwaita";
		XCURSOR_SIZE = "24";
	};

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
