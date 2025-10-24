{ config, pkgs, ... }:

{
  # Set the state version to the version of Home Manager you first installed.
  # This helps prevent breaking changes when upgrading Home Manager.
  home.stateVersion = "25.05"; # Replace with your actual state version

  # Define your username
  home.username = "phobus"; # Replace with your actual username
  home.homeDirectory = "/home/${config.home.username}";

  imports = [
     ./waybar/waybar.nix
     ./niri/niri.nix
     ./wofi.nix
     ./tmux.nix
     ./ghostty/ghostty.nix
     ./fish.nix
     ./starship.nix
  ];

  # Enable Home Manager to manage itself (recommended for standalone installations)
  programs.home-manager.enable = true;

  # Define packages to install in your user environment
  home.packages = with pkgs; [
    fastfetch
    btop 
    starship
    swaynotificationcenter
    swaylock
    swww
    vim
    htop
    fish 
    git
  ];

  # Configure Git
  programs.git = {
    enable = true;
    userName = "Phil Wu";
    userEmail = "phil@runty.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Configure Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nerdtree
      vim-airline
      gruvbox
    ];
    extraConfig = ''
      set number
      set relativenumber
      syntax enable
    '';
  };

  # Link dotfiles or other files from the Nix store to your home directory
  #home.file = {
  #  ".config/nvim/init.vim".source = ./nvim/init.vim; # Example: Link a custom Neovim config
  #  ".bashrc".text = ''
      # Custom bashrc content
 #     export PATH="$HOME/.local/bin:$PATH"
 #   '';
 # };

  # Define environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "google-chrome-stable";
  };

  #services.swww.enable = true;
  #services.swaync.enable = true;
}
