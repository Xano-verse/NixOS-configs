{ pkgs, lib, ... } :

{
programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "Alexandre Delgado";
        email = "alexandre.delgado@tecnico.ulisboa.pt";
      };
      core.editor = "vim";
      init.defaultBranch = "main";
    };
  };
}
