{
	description = "My system configuration";
	
	inputs = {
		# inputs cant use logic por isso nao da fazer let e in e por uma variavel para o channel
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
		
		home-manager.url = "github:nix-community/home-manager/release-24.11";

		# ???? idk
		# dwm-source.url = "github:xano-verse/dotfiles/tree/main/dwm/dwm/dwm-itself";
	};

	outputs = { nixpkgs, home-manager, ... }:
		let
			system = "x86_64-linux";
		in {
			nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
				# same as system = ${system};
				inherit system;
				modules = [
					./system/configuration.nix

					# Enable Home Manager as a NixOS module
					# aka integrar o home manager para que corra quando se faz nixos-rebuild switch
    					home-manager.nixosModules.home-manager
    					{
      						home-manager.useGlobalPkgs = true;
      						home-manager.useUserPackages = true;
      						home-manager.users.nixano = import ./home/home.nix;
    					}

				];
			};

			homeConfigurations.nixano = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.${system};
				modules = [
					./home/home.nix
				];
			};
		};
}
