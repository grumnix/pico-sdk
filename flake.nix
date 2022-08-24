{
  description = "A 2D platform game featuring Tux the penguin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          default = pico-sdk;

          pico-sdk = (pkgs.pico-sdk.overrideAttrs (o:
            rec {
              pname = "pico-sdk";
              version = "1.4.0";
              src = pkgs.fetchFromGitHub {
                fetchSubmodules = true;
                owner = "raspberrypi";
                repo = pname;
                rev = version;
                sha256 = "sha256:1wihm752wm3mnnrqnr7vjvrlzrhpd418jgf9i5bfajri45qrl6vs";
              };
              fixupPhase = ''
                # do nothing
              '';
            }
          ));
        };
      }
    );
}
