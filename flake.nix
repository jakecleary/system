{
  description = "System flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
  }: 
  let
    bio = import ./bio.nix;
    nixpkgsConfig = {
      allowUnfree = true;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mini
    darwinConfigurations."mini" = nix-darwin.lib.darwinSystem {
      
      system = "aarch64-darwin";
      
      modules = 
      [ 
        {
          nixpkgs.config = nixpkgsConfig;
        }
        
        { _module.args = { inherit nixpkgsConfig; }; }
        
        ./configuration.nix

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = bio.system.username;
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
          home-manager.users.${bio.system.username} = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit nix-colors nixpkgs nixpkgs-unstable nixpkgsConfig; };
        }
      ];
      inputs = { inherit nix-darwin nixpkgs nixpkgs-unstable; };
    };
  };
}
