{ pkgs, ... }:

{
	# Manter ordem alfabetica
	home.packages = with pkgs; [
		bottles

		cava		# Audio Visualizer for Alsa		

		discord
		discordo	# terminal-based discord 

		hyfetch

		ipfetch

		kdePackages.yakuake

		librewolf

		oh-my-zsh

		pywal		# generate color palettes according to wallpaper

		waybar

		yt-dlp		

		zsh
	];
}
