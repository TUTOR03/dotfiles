{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      rust-overlay,
      vscode-extensions,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ 
          rust-overlay.overlays.default
          vscode-extensions.overlays.default
          (final: prev: {
            hyprland = inputs.hyprland.packages.${system}.hyprland;
          })
        ];
      };
    in
    {
      nixosConfigurations = {
        # Конфигурация для хоста msi-laptop
        msi-laptop = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit pkgs;
          };

          modules = [
            ./hosts/msi-laptop/configuration.nix
            ./nixos-modules
          ];
        };

        # Конфигурация для хоста astukalov-thinkpad
        msi-laptop = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit pkgs;
          };

          modules = [
            ./hosts/astukalov-thinkpad/configuration.nix
            ./nixos-modules
          ];
        };
      };

      homeConfigurations = {
        # Конфигурация HomeManager для пользователя sdev на хосте msi-laptop
        "sdev@msi-laptop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./hosts/msi-laptop/home.nix
            ./home-modules
          ];
        };

        # Конфигурация HomeManager для пользователя astukalov на хосте astukalov-thinkpad
        "astukalov@astukalov-thinkpad" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./hosts/astukalov-thinkpad/home.nix
            ./home-modules
          ];
        };
      };
    };
}