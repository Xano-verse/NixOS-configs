# NixOS-configs

### system - system-wide configuration and packages
### home - home-manager for user-wide configuration


---
### scripts-auxiliares
all files return derivations so they can be called using callPackage anywhere in the config

in the default.nix of this directory, all derivations from the scripts are added home.packages so they're also installed user-wide in the PATH

#### realise-symlinks.nix
Has a script that turns a symlink to an actual file. This is useful because the files that home-manager generates are only symbolic links to the nix store and thus can't be changed, they're readonly, but it's often useful to do small changes to dotfiles for testing before rebuilding the whole system. 

For example,
```
realize-symlinks .zshrc
```
will make .zshrc an actual file and possible to edit it. However, before rebuilding the NixOS system again (regardless if we changed the remote .zshrc source), delete the changed .zshrc locally so that home-manager can put its .zshrc there again


#### replace-hash-nixos.nix
Has a script to update the hash of a fetchurl. First, extracts the URL from the .nix file by locating the desired line through the 'marker', then computes the hash and finally replaces the old hash with the new hash in the same .nix file (also by finding the line through the 'marker').
```
replace-hash-nixos <marker> <path to .nix file>
```
The marker will be the name of the fetchurl variable in the file. Also, in the hash line there is the specific text "# marker for replace hash script: marker"

An example:
```
zshrcSource = pkgs.fetchurl { url = "https://raw.githubusercontent.com/Xano-verse/dotfiles/refs/heads/main/zsh/zshrc-nixos.txt";

                sha256 = "sha256-2G2sVUw1yrbyc4t59Eiu7Mfk6LVX701JsKeviBu7HQ0="; # marker for replace hash script: zshrcSource
        };
```
So we run,
```
replace-hash-nixos zshrcSource /etc/nixos/home/modules/packages/zsh/zsh.nix
```
(we can also use a relative path obviously)


### So basically: you want to edit .zshrc? (for example)
1. do `$ realise-symlinks .zshrc`
2. edit it how you want and you can test if it's working like you want it to
3. when it's ready, put it into the remote dotfiles repo
4. remove the `.zshrc` in the original location and then rebuild the system

-> To rebuild the system you will need to update the hash in the zsh.nix file since the remote file was changed. For that just do `$ replace-hash-nixos zshrcSource zsh.nix` in the `/etc/nixos/home/modules/packages` direcotry
This is only if you actually changed the remote file, after testing you can just not care about what you tested. In that case just remove the .zshrc and rebuild the system



---

### Package configurations
If nix has features to define our configs through the nix language in a way we like, we can do that

But we can also use home-manager to pull a config file (from github for example) and specifically put it in place (like move it to ~/.config/ for example)

vim config is done system-wide wht nix language while zsh config is done with with home manager, for example


### Done in Nix System-Wide
vim

### Done with Home-Manager:
git (even though installed system-wide)
zsh


