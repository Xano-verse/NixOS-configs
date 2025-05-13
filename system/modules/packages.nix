{ config, pkgs, ... }:

{
	# Manter por ordem alfabetica
	environment.systemPackages = with pkgs; [
		btop
		dysk
		fzf
		git
		grub2
		mpv
		neofetch
		os-prober
		python313
		rustc
		tree
		unzip
		vim
		zathura
		zip
	];
}
