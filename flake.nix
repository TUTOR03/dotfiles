{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";
    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs =
    { nixpkgs
    , nixpkgs-unstable
    , home-manager
    , sops-nix
    , rust-overlay
    , vscode-extensions
    , ...
    }@inputs:
    let
      overlays = [
        rust-overlay.overlays.default
        vscode-extensions.overlays.default
      ];

      mkHost =
        { system, hostname, username, extraModules ? [] }:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = overlays;
          };

          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
            overlays = overlays;
          };

          sharedArgs = { inherit inputs pkgs pkgs-unstable hostname username; };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          
          specialArgs = sharedArgs;
          modules = [
            ./system.nix
            home-manager.nixosModules.home-manager
          ] ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        astukalov-thinkpad = mkHost {
          system = "x86_64-linux";
          hostname = "astukalov-thinkpad";
          username = "astukalov";
          extraModules = [
            {
              nixpkgs.overlays = [
                (final: prev: {
                  openvpn = prev.openvpn.override {
                    pkcs11Support = true;
                    pkcs11helper = prev.pkcs11helper;
                  };
                })
              ];
            }
          ];
        };
      };
    };
}