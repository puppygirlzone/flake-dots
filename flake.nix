{

  description = "My first flake";


  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ...} @ inputs:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
	config.allowUnfree = true;
	system = "x86_64-linux";
    };
  in {
    nixosConfigurations = {
      jibriel = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
    homeConfigurations = {
      ahlo = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
  };

}
