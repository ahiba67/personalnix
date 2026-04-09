{
  description = "A basic flake for a development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    homeConfigurations."ahiba" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [{
        home.username = "ahiba";
        home.homeDirectory = "/home/ahiba";
        home.stateVersion = "24.11";

        home.packages = with pkgs; [
          neovim
          git
          nodejs
        ];
      }];
    };
  };
}