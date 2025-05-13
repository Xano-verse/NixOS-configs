{ pkgs, ... }:

{
	# Manter ordem alfabetica
	home.packages = with pkgs; [
		hyfetch
		ipfetch
		librewolf
		oh-my-zsh
		yakuake
		zsh
	];
}
