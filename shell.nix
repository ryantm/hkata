{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, doctest, foldl, hpack, parsec, stdenv
      }:
      mkDerivation {
        pname = "kata";
        version = "0.0.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        libraryToolDepends = [ hpack ];
        executableHaskellDepends = [ base foldl parsec ];
        testHaskellDepends = [ base doctest foldl parsec pkgs.entr ];
        prePatch = "hpack";
        homepage = "https://github.com/ryantm/hkata#readme";
        license = stdenv.lib.licenses.cc0;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
