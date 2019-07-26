Install Nix:

```
curl https://nixos.org/nix/install | sh
```

Enter a shell with dependencies:

```
nix-shell -p entr -p "haskellPackages.ghcWithPackages (pkgs: [pkgs.mtl])"
```

Keep running tests every time file changed:

```
echo Kata.hs | entr doctest Kata.hs
```
