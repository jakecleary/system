{
  description = "System flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    home-manager,
    home-manager-unstable,
    homebrew-bundle,
    homebrew-cask, 
    homebrew-core, 
    nix-colors,
    nix-darwin, 
    nix-homebrew, 
    nixpkgs, 
    nixpkgs-unstable,
    self,
    ...
  }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mini
    darwinConfigurations."mini" = nix-darwin.lib.darwinSystem {
      
      system = "aarch64-darwin";
      
      modules = 
      [ 
        ./configuration.nix

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "jake";
            enableRosetta = true;
            mutableTaps = false;
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };
          };
        }

        # `home-manager` config
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jake = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit nix-colors nixpkgs nixpkgs-unstable; };
        }
      ];
      inputs = { inherit nix-darwin nixpkgs nixpkgs-unstable; };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mini".pkgs;
  };
}
