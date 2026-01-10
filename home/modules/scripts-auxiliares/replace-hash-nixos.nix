# made by me :)

{ pkgs, ... } :

pkgs.writeShellApplication {
    name = "replace-hash-nixos";
    runtimeInputs = with pkgs; [ coreutils ];
    text = ''
#!/bin/sh

# $1 is the marker and $2 the path to the file, example
# replace-hash-nixos zshrcSource ./zsh/zsh.nix

marker=$1
path=$2

# 1ST PART - EXTRACT URL

# Extract the url we want to fetch
# (get the line with the pkgs.fetchurl and return the 7th element)
url=$(awk "/$marker = pkgs.fetchurl {/{print}" "$path") 

echo "Extracted $url"

url=$(awk '{print $7}' <<< "$url")

echo "Shortened to $url"

# we need to do awk twice because we're providing $1 as argument so it messes up the syntax because initially it'd just be, for a specific case
# awk '/zshrcSource = pkgs.fetchurl {/{print $7}' zsh/zsh.nix 

# url vem entre aspas e com ponto e virgula no final
# Remove todas as aspas e depois o ponto e virgula
url=$(echo "$url" | sed "s/\"//g" | sed "s/;//g")

echo "Sanitized to $url"


# 2ND PART - GET HASH

# copies the raw file to the nix-store and returns the store path
# (sed is selecting only the 2nd line of the output, the one with the store path)
urlhash=$(nix-hash --type sha256 --base64 --flat <(curl -o - "$url"))

echo "Got hash $urlhash"


# 3RD PART - REPLACE HASH

# replaces the old hash with the current new hash
sed -i "/# marker for replace hash script: $marker/c\ \t\tsha256 = \"sha256-$urlhash\";\t# marker for replace hash script: $marker" "$path"

echo "Replaced the hash in \"$path\""
   '';
}


