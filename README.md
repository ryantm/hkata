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
[entr](http://eradman.com/entrproject/) can be installed with `brew install
entr` for you Mac kiddos.
