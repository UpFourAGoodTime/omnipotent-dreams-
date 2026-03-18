{
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
      inputs.self.nixosModules.dtbloader
      inputs.self.nixosModules.kde-plasma
    ];


    environment.systemPackages = [

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

  };

}
