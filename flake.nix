{
  description = "ISL Bindings for Haskell";

  inputs = {
    haskellNix.url    = "github:input-output-hk/haskell.nix";
    nixpkgs.follows   = "haskellNix/nixpkgs-unstable";
    isl-src = {
      url = "git+https://repo.or.cz/isl.git?ref=refs/tags/isl-0.27&submodules=1";
      flake = false;
    };
    flake-utils.url   = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, haskellNix, isl-src, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        islOverlay = (final: prev: {
          isl = prev.stdenv.mkDerivation rec {
            pname   = "isl";
            version = "0.27";

            src = isl-src;

            nativeBuildInputs = with prev; [
              autoreconfHook
              pkg-config
            ];

            buildInputs = [ prev.gmp ];

            configureFlags = [
              "--with-gmp-prefix=${prev.gmp}"
              "--disable-static"
              "--enable-shared"
            ];

            doCheck = false;

            meta = prev.isl.meta // {
              description = "Integer Set Library (version 0.27)";
              homepage    = "https://repo.or.cz/isl.git";
            };
          };
        });

        pkgs = import nixpkgs {
          inherit system;
          overlays = [ haskellNix.overlay islOverlay ];
          inherit (haskellNix) config;
        };

        project = pkgs.haskell-nix.project' {
          src = ./.;
          compiler-nix-name = "ghc9101";
          shell = {
            tools = {
              cabal = {};
              haskell-language-server = {};
              hlint = {};
              ormolu = {};
            };
            buildInputs = with pkgs; [
              pkg-config
              isl
              gmp
            ];
          };
        };

      in {
        packages.default = project.flake.packages."Isl:lib:Isl" or null;

        devShells.default = project.shell;
      });
}

