{ config, pkgs, ... }:

{
	# Base system utilities only
	# Manter por ordem alfabetica
	environment.systemPackages = with pkgs; [
		#_2bwm
	
		alacritty
		alsa-utils	# sound utils like alsamixer

        bat         # clone of cat, used in my preview of files in fzf (checkout .zshrc)
		brightnessctl
		btop

        docker
		dysk

		fastfetch
		#feh		# wallpaper setter (probably only works for X11)
		fftw		# for waybar's cava module
		flameshot
		fzf

		gcc15
		git
		gnumake		# make utility for compilation 
		grub2

		iniparser	# for waybar's cava module

		libepoxy	# for waybar's cava module
		libgcc		# gcc and g++ and others

		mpv

		neofetch
		nerd-fonts.symbols-only
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
		wget
		wl-clipboard

		xclip

		zathura
		zip
	];
}
