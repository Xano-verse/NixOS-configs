{ pkgs, ... }:

{
	# Manter ordem alfabetica
	home.packages = with pkgs; [
		bottles

		cava		# Audio Visualizer for Alsa		

#		discord
#		discordo	# terminal-based discord 

		hyfetch

		ipfetch

		kdePackages.yakuake

		librewolf

		obs-studio
		oh-my-zsh

		pywal		# generate color palettes according to wallpaper

		vscode

		waybar

		yt-dlp		

		zsh
	];
}
