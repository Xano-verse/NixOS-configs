{ pkgs, ... } :

let 
	# callPackage chama o ficheiro .nix que está a retornar uma derivation
	# depois, incluímos a derivation no home.packages para instalar o script user-wide como programa no PATH
	realiseSymlink = pkgs.callPackage ./realise-symlink.nix {};
	replaceHash = pkgs.callPackage ./replace-hash-nixos.nix {};

in
{

	# nao dar import dos ficheiros que retornam derivations -> que é suposto serem todos para ser consistente
	# todos os .nix scripts desta pasta devem retornar derivations e neste ficheiro é que são adicionados ao home.packages
	# e portanto não postos nos imports como costuma acontecer nos default.nix
	imports = [
		
		#./realise-symlink.nix

	];


	home.packages = [
		
		realiseSymlink
		replaceHash
	
	];



}
