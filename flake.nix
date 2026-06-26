{
  description = "AstroImageJ packaged for Nix";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in
  {
    packages = forAllSystems (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        astroimagej = pkgs.callPackage ./astroimagej { };
        default = self.packages.${system}.astroimagej;
      }
    );

    apps = forAllSystems (system: {
      astroimagej = {
        type = "app";
        program = "${self.packages.${system}.astroimagej}/bin/astroimagej";
      };
      default = self.apps.${system}.astroimagej;
    });
  };
}
