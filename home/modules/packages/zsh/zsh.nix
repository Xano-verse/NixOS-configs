{ pkgs, ... } :


let 
	classyTouchSource = pkgs.fetchurl {
		# E preciso usar o url do ficheiro RAW, nao apenas o link para a pagina html do github desse ficheiro
		url = "https://raw.githubusercontent.com/yarisgutierrez/classyTouch_oh-my-zsh/refs/heads/master/classyTouch.zsh-theme";
		# Dummy hash to get the expected hash in the error message (under "got:")
		# sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
		sha256 = "sha256-6V15uzUcCH93IcIq3f3yNvIFO0tNBfn/V2QQ5LmOfDw=";
	};

in
{

	programs.zsh = {
		enable = true;
  		#enableCompletions = true;
  		#autosuggestions.enable = true;
  		syntaxHighlighting.enable = true;

  		shellAliases = {
    			ll = "ls -l";
    			update = "sudo nixos-rebuild switch";
  		};
  		history.size = 10000;
	
		oh-my-zsh = {
    			enable = true;
    			plugins = [ "git" ];
			custom = "/home/nixano/.oh-my-zsh/custom/";
			# Vai procurar na pasta themes pelo specified theme
			theme = "classyTouch";
  		};

	};


	# Vai buscar o ficheiro do theme e poe no em ~/.oh-my-zsh/custom/themes/
	home.file.".oh-my-zsh/custom/themes/classyTouch.zsh-theme".source = classyTouchSource;



}
