{
  description = "Literal Garbage.";

  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    rust-overlay,
    sops-nix,
    auto-cpufreq,
    ...
  } @ inputs: let
    overlays = {pkgs, ...}: {
      nixpkgs.overlays = with inputs; [
        rust-overlay.overlays.default
      ];
    };

    config = {
      allowBroken = true;
      allowUnfree = true;
      tarball-ttl = 0;
    };
    system = "x86_64-linux";
  in {
    nixosConfigurations.selene = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        {
          environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
          nix.nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
          nix.registry.nixpkgs.flake = nixpkgs;
        }
        ./hosts/selene
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
        overlays
        sops-nix.nixosModules.sops
        auto-cpufreq.nixosModules.default
      ];
      specialArgs = {inherit system inputs;};
    };
  };
}
