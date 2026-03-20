{
  inputs,
  pkgs,
  ...
}:
{
  flake.nixosConfigurations.tyche = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    modules = [
      inputs.self.nixosModules.tyche-config
    ];
  };

  flake.nixosModules.tyche-config =
    {
      ...
    }:
    {

      imports = [
        inputs.self.nixosModules.shared-configuration
        inputs.self.nixosModules.disko-ext4
        inputs.self.nixosModules.kde-plasma
        inputs.self.nixosModules.gabriele-config
        inputs.self.nixosModules.asus-vivobook-s15
      ];

      environment.systemPackages = [

        pkgs.nh

        pkgs.wget

        pkgs.nixd
        pkgs.nil

        pkgs.git

        pkgs.nerd-fonts.jetbrains-mono
        pkgs.nerd-fonts.hasklug
        pkgs.nerd-fonts.hurmit

        pkgs.python312Packages.yt-dlp

        pkgs.obs-studio
        pkgs.cavalier
      ];

    };

  flake.nixosModules.asus-vivobook-s15 =
    {
      ...
    }:
    {

      imports = [
        inputs.x1e-nixos-config.nixosModules.x1e
      ];

      networking.hostName = "system";
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
    };

}
