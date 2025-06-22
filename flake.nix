{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    disko.url = "github:nix-community/disko";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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
    , nixos-hardware
    , disko
    , home-manager
    , plasma-manager
    , sops-nix
    , rust-overlay
    , vscode-extensions
    , ...
    }:
    let
      overlays = [
        rust-overlay.overlays.default
        vscode-extensions.overlays.default
      ];

      mkHost =
        { system, hostName, userName, userEmail, extraModules ? [ ] }:
        let
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            inherit overlays;

            config.allowUnfree = true;
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = { inherit hostName userName userEmail; };
          modules = [
            {
              nixpkgs = {
                inherit system;
                inherit (overlays ++ [
                  (final: prev: {
                    unstable = pkgs-unstable;
                  })
                ]);

                config.allowUnfree = true;
              };
            }
            ./system.nix
            home-manager.nixosModules.home-manager
          ] ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        # astukalov-thinkpad = mkHost {
        #   system = "x86_64-linux";
        #   hostname = "astukalov-thinkpad";
        #   username = "astukalov";
        #   useremail = "astukalov@vk.team";
        #   extraModules = [
        #     {
        #       nixpkgs.overlays = [
        #         (final: prev: {
        #           openvpn = prev.openvpn.override {
        #             pkcs11Support = true;
        #             pkcs11helper = prev.pkcs11helper;
        #           };
        #         })
        #       ];

        #       home-manager.sharedModules = [
        #         sops-nix.homeManagerModules.sops
        #       ];
        #     }
        #   ];
        # };

        msi-laptop = mkHost {
          system = "x86_64-linux";
          hostname = "msi-laptop";
          username = "sdev";
          useremail = "stukalov.dev@gmail.com";
          extraModules = [
            disko.nixosModules.disko
            ./hosts/msi-laptop/disko.nix
            sops-nix.nixosModules.sops
            {
              home-manager.sharedModules = [
                plasma-manager.homeManagerModules.plasma-manager
              ];
            }
          ];
        };
      };
    };
}
