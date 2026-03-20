{
  inputs,
  ...
}:
{
  flake.nixosConfigurations.proteus = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.self.nixosModules.proteus-config
    ];
  };

  flake.nixosModules.proteus-config =
    {
      pkgs,
      ...
    }:
    {

      imports = [
        inputs.self.nixosModules.shared-configuration
        inputs.self.nixosModules.disko-ext4
        inputs.self.nixosModules.kde-plasma
        inputs.self.nixosModules.systemd-boot
        inputs.self.nixosModules.gabriele-config
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

        pkgs.makemkv

        pkgs.obs-studio
        pkgs.jamesdsp
        pkgs.cavalier
      ];

      boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

    };
}
