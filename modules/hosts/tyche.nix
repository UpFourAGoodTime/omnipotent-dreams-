{
  inputs,
  ...
}:
{
  flake.nixosConfigurations.tyche = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    modules = [
      inputs.self.nixosModules.tyche-config
      inputs.self.nixosModules.shared-configuration
      inputs.self.nixosModules.disko-ext4
      inputs.self.nixosModules.gabriele-config
      inputs.x1e-nixos-config.nixosModules.x1e
      inputs.self.nixosModules.systemd-boot
    ];
  };

  flake.nixosModules.tyche-config =
    {
     inputs,
     pkgs,
     lib,
      ...
    }:
    {

      imports = [ ];

      networking.hostName = "tyche";

      environment.systemPackages = [

        pkgs.nh

        pkgs.wget

        pkgs.nixd
        pkgs.nil

        pkgs.git
      ];

      hardware.asus-vivobook-s15.enable = true;

      nixpkgs.hostPlatform.system = "aarch64-linux";

      hardware.enableRedistributableFirmware = true;

      networking.networkmanager = {
      enable = true;
      plugins = lib.mkForce [ ];
      };

      boot.kernel.sysctl."kernel.sysrq" = 80;

      # Uncomment this to allow unfree packages.
      # nixpkgs.config.allowUnfree = true;

      nix = {
        channel.enable = false;
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

    };

}
