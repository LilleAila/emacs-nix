{
  description = "Development environments for various languages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-colors.url = "github:Misterio77/nix-colors";

    # Using the emacs version from nixpkgs is good enough, i don't see a difference
    # emacs-overlay = {
    #   url = "github:nix-community/emacs-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;
      systems = lib.systems.flakeExposed;
      pkgsFor = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
          # overlays = [ inputs.emacs-overlay.overlays.default ];
        }
      );
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    in
    {
      packages = forEachSystem (pkgs: rec {
        default = emacs;
        emacs = pkgs.callPackage ./package.nix {
          colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
        };
      });
      devShells = forEachSystem (pkgs: {
        default = pkgs.callPackage ./shell.nix { };
      });
    };
}
