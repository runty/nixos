# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/x1/13th-gen>
      ./hardware-configuration.nix
    ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader.limine.enable = true;
  boot.loader.limine.maxGenerations = 5;
  boot.loader.limine.style.backdrop = "000000";
#  boot.loader.limine.style.wallpapers = [ (builtins.toString ./yo.jpg) ];
  boot.loader.limine.style.interface.helpHidden = true;
  boot.loader.limine.style.graphicalTerminal.margin = 0;
  boot.loader.limine.style.wallpaperStyle = "centered";


  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.plymouth.enable = true;

  networking.hostName = "nixy"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  xdg.portal.wlr.enable = true;
  fonts = {
      fontconfig.enable = true;
      packages = with pkgs; [
          nerd-fonts.jetbrains-mono
      ];
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
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

  services.openssh = {
      enable = true;
      ports = [22];
      settings = {
         PasswordAuthentication = true;
         UseDns = true;
         X11Forwarding = false;
         PermitRootLogin = "prohibit-password";
      };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.phobus = {
    isNormalUser = true;
    description = "Phil Wu";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  programs.firefox.enable = true;
  programs.niri.enable = true;
  programs.fish.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
     enable = true;
     polkitPolicyOwners = [ "phobus" ]; 
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    stow
    gh
    google-chrome
    _1password-gui
    _1password-cli
    bat
    btop
    lazygit 
    waybar  
    imagemagick
    easyeffects
    fuzzel
    yazi
    mako
    fastfetch   
    brightnessctl
    kanshi
    pwvucontrol
    blueberry
    impala
    eza
    fzf
    unzip
    ripgrep
    nautilus
    iperf3
    adwaita-fonts
    adwaita-icon-theme
    plex-desktop
    discord
    killall
    xwayland-satellite
    sway-audio-idle-inhibit
    swayidle
    swaylock
    swaybg
    uwsm
    corefonts
  ];

  networking.extraHosts =
    ''
192.168.22.23   ziggy
192.168.22.125  pikvm
192.168.22.41   zero
192.168.50.193  koge
192.168.22.149  homeassistant
192.168.50.49   hkkvm
192.168.22.202  chopper
192.168.22.176  starbuck
192.168.22.222  waystar
192.168.22.235  jelly
192.168.22.159  turing
192.168.22.123  pikvm4
192.168.22.55	beef
192.168.22.219	tex
192.168.22.37	homey
192.168.22.138	plex
192.168.22.101  rk1
192.168.22.200  rk2
192.168.22.157  rk4
192.168.22.167  rk3
192.168.22.130  turingpi
192.168.22.169	inky
192.168.50.41	shecky
192.168.22.29	jinx
192.168.22.70	heimer
192.168.22.73	milo
192.168.22.29 	kier
192.168.22.29	prime
192.168.22.66	nuc11
192.168.22.106	pdp
192.168.22.20	sunny
192.168.22.102	shrimp
192.168.22.39	studio
    '';

programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};
programs.xwayland.enable = true;
programs.neovim = {
    enable = true;
    defaultEditor = true;
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
  # services.openssh.enable = true;

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
  system.stateVersion = "25.05"; # Did you read the comment?

}
