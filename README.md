$ curl https://nixos.org/nix/install | sh

$ nix-shell -p entr -p "haskellPackages.ghcWithPackages (pkgs: [pkgs.mtl])"

$ echo Kata.hs | entr doctest Kata.hs
