{
  inputs,
  ...
}:
{
  flake.nixosConfigurations.tyche = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    modules = [
      inputs.self.nixosModules.tyche-config
      inputs.x1e-nixos-config.nixosModules.x1e
      {
      hardware.asus-vivobook-s15.enable = true;

      nixpkgs.hostPlatform.system = "aarch64-linux";

      # Uncomment this to allow unfree packages.
      # nixpkgs.config.allowUnfree = true;

      nix = {
        channel.enable = false;
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
      }
    ];
  };

  flake.nixosModules.tyche-config =
    {
    inputs,
     pkgs,
      ...
    }:
    {

      imports = [
        inputs.self.nixosModules.shared-configuration
        inputs.self.nixosModules.disko-ext4
        inputs.self.nixosModules.gabriele-config
      ];

      networking.hostName = "tyche";

      environment.systemPackages = [

        pkgs.nh

        pkgs.wget

        pkgs.nixd
        pkgs.nil

        pkgs.git
      ];

    };

}
