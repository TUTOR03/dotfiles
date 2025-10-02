{
  description = "Modular NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    { nixpkgs
    , nixpkgs-unstable
    , home-manager
    , nur
    , rust-overlay
    , vscode-extensions
    , disko
    , sops-nix
    , plasma-manager
    , ...
    }:

    let
      overlays = [
        nur.overlays.default
        rust-overlay.overlays.default
        vscode-extensions.overlays.default
      ];

      mkHostWithUser = { system, hostName, userName, userEmail, stateVersion, extraHostModules ? [ ], extraHomeModules ? [ ] }:
        let
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };

          pkgs = import nixpkgs {
            inherit system;
            overlays = overlays ++ [
              (final: prev: {
                unstable = pkgs-unstable;
              })
            ];
            config.allowUnfree = true;
          };
        in
        {
          inherit hostName userName;

          host = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              {
                nixpkgs.pkgs = pkgs;
              }
              ./base/host
              ./hosts/${hostName}
            ] ++ extraHostModules;

            specialArgs = { inherit hostName userName userEmail stateVersion; };
          };

          home = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            username = userName;
            homeDirectory = "/home/${userName}";

            modules = [
              ./base/home
              ./hosts/${hostName}/home
            ] ++ extraHomeModules;

            extraSpecialArgs = { inherit hostName userName userEmail stateVersion; };
          };
        };

      configs = [
        {
          system = "x86_64-linux";
          hostName = "sdev-pc";
          userName = "sdev";
          userEmail = "stukalov.dev@gmail.com";
          stateVersion = "25.05";
          extraHostModules = [
            disko.nixosModules.disko
            ./hosts/sdev-pc/disko.nix
          ];
        }
        {
          system = "x86_64-linux";
          hostName = "msi-laptop";
          userName = "sdev";
          userEmail = "stukalov.dev@gmail.com";
          stateVersion = "25.05";
          extraHostModules = [
            disko.nixosModules.disko
            ./hosts/msi-laptop/disko.nix
          ];
        }
      ];

      generatedConfigs = map mkHostWithUser configs;
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        map (cfg: { name = cfg.hostName; value = cfg.host; }) generatedConfigs
      );

      homeConfigurations = builtins.listToAttrs (
        map (cfg: { name = "${cfg.userName}@${cfg.hostName}"; value = cfg.home; }) generatedConfigs
      );
    };
}
