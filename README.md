Install Nix:

```
curl https://nixos.org/nix/install | sh
```

Enter a shell with dependencies:

```
nix-shell
```

Keep running tests every time file changed:

```
echo Kata.hs | entr doctest --verbose Kata.hs
```

Updating the Cabal file when adding new dependencies or options:

```bash
nix run nixpkgs.haskellPackages.hpack -c hpack
```
