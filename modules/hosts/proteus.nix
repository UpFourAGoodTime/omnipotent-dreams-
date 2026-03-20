{
  inputs,
  ...
}:
{
  flake.nixosConfigurations.proteus = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.self.nixosModules.proteus-config
      inputs.self.nixosModules.proteus-hw-config
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

      networking.hostName = "proteus";

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

  flake.nixosModules.proteus-hw-config =
    {
      config,
      lib,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "atkbd.reset=1"
        "i8042.nopnp=1"
        "i8042.debug=1"
        "udev.log_level=0"
        "amd_iommu=fullflush"
        "usbcore.blinkenlights=1"
        "rd.systemd.show_status=1"
      ];

      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "rtsx_pci_sdmmc"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [
        "kvm-amd"
        "sg"
      ];
      boot.extraModulePackages = [ ];

      services.pulseaudio.enable = false;

      services.pipewire = {
        enable = true;
        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
      };

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      networking.useDHCP = lib.mkDefault true;
      # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
