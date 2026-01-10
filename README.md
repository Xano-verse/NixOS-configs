# NixOS-configs

#### system - system-wide configuration and packages
#### home - home-manager for user-wide configuration


### scripts-auxiliares
all files return derivations so they can be called using callPackage anywhere in the config

in the default.nix of this directory, all derivations from the scripts are added home.packages so they're also installed user-wide in the PATH

realise-symlinks.nix -> has a script that turns a symlink to an actual file. This is useful because the files that home-manager generates are only symbolic links to the nix store and thus can't be changed, they're readonly, but it's often useful to do small changes to dotfiles for testing before rebuilding the whole system. 

For example,
```
realize-symlinks .zshrc
```
will make .zshrc an actual file and possible to edit it. However, before rebuilding the NixOS system again (regardless if we changed the remote .zshrc source), delete the changed .zshrc locally so that home-manager can put its .zshrc there again


replace-hash-nixos.nix -> has a script to update the hash of a fetchurl. First, extracts the URL from the .nix file by locating the desired line through the 'marker', then computes the hash and finally replaces the old hash with the new hash in the same .nix file (also by finding the line through the 'marker').
```
replace-hash-nixos <marker> <path to .nix file>
```
The marker will be the name of the fetchurl variable in the file. Also, in the hash line there is the specific text "# marker for replace hash script: marker"

An example:
```
zshrcSource = pkgs.fetchurl { url = "https://raw.githubusercontent.com/Xano-verse/dotfiles/refs/heads/main/zsh/zshrc-nixos.txt";

                #sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
                sha256 = "sha256-2G2sVUw1yrbyc4t59Eiu7Mfk6LVX701JsKeviBu7HQ0="; # marker for replace hash script: zshrcSource
        };
```
So we run,
```
replace-hash-nixos zshrcSource /etc/nixos/home/modules/packages/zsh/zsh.nix
```
(we can also use a relative path obviously)


