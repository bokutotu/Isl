{
  description = "Haskell + ISL (FFI) demo — isl is built from upstream Git HEAD";

  inputs = {
    nixpkgs.url       = "github:NixOS/nixpkgs/a295a09efb6ea441df2244727f44cb6434d33aaa";

    isl-src.url       = "git+https://repo.or.cz/isl.git?submodules=1";
    isl-src.flake     = false;

    flake-utils.url   = "github:numtide/flake-utils";
  };

   outputs = { self, nixpkgs, isl-src, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        islOverlay = (final: prev: {
          isl = prev.stdenv.mkDerivation rec {
            pname   = "isl";
            version = "git-${builtins.substring 0 7 isl-src.rev}";

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
              description = "Integer Set Library (built from upstream git HEAD)";
              homepage    = "https://repo.or.cz/isl.git";
            };
          };
        });

        pkgs = import nixpkgs {
          inherit system;
          overlays = [ islOverlay ];
        };

        ghcVersion      = "ghc910";
        haskellPackages = pkgs.haskell.packages.${ghcVersion};

        projectNativeDeps = with pkgs; [
          pkg-config
          isl
        ];

        projectPackage =
          haskellPackages.callCabal2nix "Isl" ./. { };

      in
      {
        packages.default = projectPackage;

        devShells.default = haskellPackages.shellFor {
          packages = p: [ projectPackage ];

          buildInputs =
            projectNativeDeps
            ++ (with haskellPackages; [
              cabal-install
              haskell-language-server
            ])
            ++ (with pkgs; [ git ]);

          shellHook = ''
            echo "🕊  Dev shell with upstream isl ready."
          '';
        };
      });
}

