{ pkgs, ... }:

{
	imports = [
		# auxiliary scripts in the nix language -> theyll be installed as user-wide programs
		# (if they are exported into home.packages like the realise-symlink script)
		./modules/scripts-auxiliares/default.nix

		./modules/packages.nix
		./modules/packages/default.nix
	];

	home.username = "xanix";
	home.homeDirectory = "/home/xanix";
	home.stateVersion = "25.11";

	# Let Home Manager install and manage itself.
  	programs.home-manager.enable = true;
}
