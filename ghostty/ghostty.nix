{ config, pkgs, ... }:

{
	xdg.configFile."ghostty/config".source = ./config;
}
