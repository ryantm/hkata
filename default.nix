{ returnShellEnv ? false } :

let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {config = { allowBroken = true; }; };

  # gitignore = import sources.gitignore { inherit (pkgs) lib; };
  # inherit (gitignore) gitignoreSource;

  compiler = pkgs.haskell.packages.ghc921;
  inherit (pkgs.haskell.lib) dontCheck doJailbreak overrideCabal;

  pkg = compiler.developPackage {
    name = "hkata";
    root = ./.;
    overrides = self: super: { bsb-http-chunked = dontCheck super.bsb-http-chunked; };
    source-overrides = { };
    inherit returnShellEnv;
  };

in pkg.overrideAttrs (attrs: {
  propagatedBuildInputs = with pkgs; [
    cabal-install
    entr
    ghcid
    inotify-tools
  ];
})
