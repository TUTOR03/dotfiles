{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
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
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , rust-overlay
    , vscode-extensions
    , ...
    }@inputs:
    let
      system = "x86_64-linux";

      # Создаем pkgs-unstable для выборочного использования пакетов из нестабильной ветки
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      # Определяем собственный набор пакетов, основанный на стабильной ветке
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;

        overlays = [
          rust-overlay.overlays.default
          vscode-extensions.overlays.default
          (final: prev: {
            openvpn = prev.openvpn.override {
              pkcs11Support = true;
              pkcs11helper = prev.pkcs11helper;
            };
            zed-editor = pkgs-unstable.zed-editor;
            vscode = pkgs-unstable.vscode;
          })
        ];
      };
    in
    {
      # Конфигурации для хостов NixOS
      nixosConfigurations = {
        msi-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgs; };
          modules = [
            ./hosts/msi-laptop/configuration.nix
            ./nixos-modules
          ];
        };

        astukalov-thinkpad = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgs; };
          modules = [
            ./hosts/astukalov-thinkpad/configuration.nix
            ./nixos-modules
          ];
        };
      };

      # Конфигурации для пользователей Home Manager
      homeConfigurations = {
        "sdev@msi-laptop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/msi-laptop/home.nix
            ./home-modules
          ];
        };

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
