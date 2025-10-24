{ config, pkgs, ... }:

{
    xdg.configFile."mpv/mpv.conf".source = ./mpv.conf;
    xdg.configFile."mpv/input.conf".source = ./input.conf;
    xdg.configFile."mpv/scripts/delete_current_file.lua".source = ./delete_current_file.lua;
}
