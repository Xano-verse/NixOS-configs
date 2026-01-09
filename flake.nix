{
	description = "My system configuration";
	
	inputs = {
		# inputs cant use logic por isso nao da fazer let e in e por uma variavel para o channel
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		# nixpkgs.url = "path:/home/nixano/nixpkgs";
		
		home-manager.url = "github:nix-community/home-manager/release-25.11";

		# ???? idk
		# dwm-source.url = "github:xano-verse/dotfiles/tree/main/dwm/dwm/dwm-itself";
		
		niri.url = "github:sodiboo/niri-flake";

	};

	outputs = { nixpkgs, home-manager, niri, ... }:
		let
			system = "x86_64-linux";
		in {
			nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
				# same as doing system = ${system};
				inherit system;
				modules = [
					./system/configuration.nix

					# Enable Home Manager as a NixOS module
					# aka integrar o home manager para que corra quando se faz nixos-rebuild switch
    					home-manager.nixosModules.home-manager {
      						home-manager.useGlobalPkgs = true;
      						home-manager.useUserPackages = true;
      						home-manager.users.nixano = import ./home/home.nix;
    					}

					# Enable Niri Window Manager
					# the first time the system is built we should set enable to false to bring the binary to cache and only then rebuild with enable = true
					niri.nixosModules.niri {
						programs.niri.enable = true;

						# instead of the binary cache, we can choose to use the niri binary from nixpkgs, by declaring it in the configuration.nix side of things and declaring 
						# programs.niri.package = pckgs.niri;
					}

				];
			};

			homeConfigurations.nixano = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.${system};
				modules = [
					./home/home.nix

					niri.homeModules.niri {
						programs.niri.settings = {
							outputs."eDP-1".scale = 2.0;
						};
					}
				];
			};

			
		};
}
