{ pkgs, ... } :


let 
	dwm-autostart-script = pkgs.fetchurl {
		# E preciso usar o url do ficheiro RAW, nao apenas o link para a pagina html do github desse ficheiro
		url = "https://raw.githubusercontent.com/Xano-verse/dotfiles/refs/heads/main/dwm/dwm/dotdwm/autostart.sh";
		# Dummy hash to get the expected hash in the error message (under "got:")
		# sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
		sha256 = "sha256-jpj0Gc8XZN9RvGWaSBIEzXWguv+X2SyLcnuewEjAMGE=";
	};

in
{
	# Vai buscar o ficheiro do theme e poe no em ~/.oh-my-zsh/custom/themes/
	home.file.".dwm/autostart.sh".source = dwm-autostart-script; 



}
