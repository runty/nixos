{ config, pkgs, lib, ... }:

{

  home.file.".config/waybar/config".source = ./waybar.conf;
  home.file.".config/waybar/waybar.css".source = ./waybar.css;
  home.file.".config/waybar/style.css".source = ./style.css;

  # Optional: you can keep this if you want Nix to enable waybar
}
