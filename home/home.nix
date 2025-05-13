{ pkgs, ... }:

{
	imports = [
		./modules/packages.nix
		./modules/packages/default.nix
	];

	home.username = "nixano";
	home.homeDirectory = "/home/nixano";
	home.stateVersion = "24.11";

	# Let Home Manager install and manage itself.
  	programs.home-manager.enable = true;
}
