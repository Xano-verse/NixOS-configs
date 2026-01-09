{ config, pkgs, ... }:

{
	# Base system utilities only
	# Manter por ordem alfabetica
	environment.systemPackages = with pkgs; [
		#_2bwm
	
		alsa-utils	# sound utils like alsamixer

		btop

		dysk

		#feh		# wallpaper setter (probably only works for X11)
		fzf

		git
		grub2

		libgcc		# gcc and g++ and others

		mpv

		neofetch
		networkmanager	# has nmcli etc
		#niri		# niri window manager is added as a flake in flake.nix
		nix-prefetch-git
		nmap

		os-prober

		picom
		python313

		rar
		rofi
		rustc

		sc-im
		st
		swaybg		# wallpaper setter for wayland
		#sxwm

		texliveFull
		tree

		unrar
		unzip

		vim

		#waypaper	# wallpaper setter for wayland

		xclip

		zathura
		zip
	];
}
