{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
     
      home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
  
     nix-colors.url = "github:misterio77/nix-colors";
     
  
  };
  
  
   

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
         inputs.home-manager.nixosModules.default {
         home-manager.useGlobalPkgs = true;
         home-manager.useUserPackages = true;
         home-manager.users.itscool2b = import ./home.nix;
         
}
    inputs.stylix.nixosModules.stylix    

      ];
    };
  };
}
