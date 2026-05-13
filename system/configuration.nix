# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./modules/hardware-configuration.nix
      ./modules/packages.nix
      ./modules/packages/default.nix
    ];


  # fileSystems."/boot" options are in modules/hardware-configuration.nix


  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  #boot.tmp.useTmpfs = false;

  boot.loader = {
        efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot"; # ← use the same mount point here.
        };
        grub = {
            enable = true;
            efiSupport = true;
            #efiInstallAsRemovable = true;
            device = "nodev";		# GRUB needs to have nodev
	    useOSProber = true;
	    default = "saved";	# default boot entry -> saved means it will be the last booted entry
            
	    theme = 
	      let
	        yorhaTheme = pkgs.fetchFromGitHub {
		  owner = "OliveThePuffin";
	 	  repo = "yorha-grub-theme";	
		  # Hash of the specific commit (for stability)
		  rev = "4d9cd37baf56c4f5510cc4ff61be278f11077c81";
		  sha256 = "sha256-XVzYDwJM7Q9DvdF4ZOqayjiYpasUeMhAWWcXtnhJ0WQ=";
		};
	      in
		"${yorhaTheme}/yorha-1920x1080";
        };
    };

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable zsh system-wide (it's recommended even if it's already enabled in the home manager config)
  programs.zsh.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  #services.xserver.windowManager."2bwm".enable = true;
  #services.xserver.windowManager.sxwm.enable = true;

  # Enable my custom dwm and source
  /*services.xserver.windowManager.dwm.enable = true;

  services.xserver.windowManager.dwm.package =
    let
      my-dwm = pkgs.fetchFromGitHub {
        owner = "Xano-verse";
        repo = "dotfiles";
        rev = "c8a1a88d91354f2a7daa2c17f0f9e68f97dc7e2c";
	sha256 = "sha256-shcWBoTpH0oaCO9B8BLM/0/yUTbE0QBElzyudW+CkVM=";
      };
    in
      pkgs.dwm.overrideAttrs {
	src = "${my-dwm}/dwm/dwm/dwm-itself"; 
	# dontUnpack = true;
      };
*/

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pt";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pt-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable support for Bluetooth
  hardware.bluetooth.enable = true;
  # Powers up the default Bluetooth controller on boot
  hardware.bluetooth.powerOnBoot = true;
  # GUI for bluetooth device management
  services.blueman.enable = true;

  # Enable sound with pipewire.
  #hardware.pulseaudio.enable = false;	# Old option, deprecated
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Set zsh as the default shell for all users
  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xanix = {
    isNormalUser = true;
    description = "Xanverse";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox. -> done in modules/packages.nix and configured in modules/packages/firefox.nix
  #programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Enable docker daemon
  virtualisation.docker.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  #];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;



  # Enable xdg desktop integration
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };



  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?





}
