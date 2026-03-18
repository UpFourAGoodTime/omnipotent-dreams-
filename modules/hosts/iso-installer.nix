{
  modulesPath,
  config,
  lib,
  options,
  pkgs,
  ...
}:
{
  flake.nixosConfigurations.iso-installer = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    modules = [

    ];
  };

  flake.nixosModules.iso-installer-configuration =
  {
    ...
  }:
  {

    imports = [
      ${modulesPath}/installer/cd-dvd/iso-image.nix

      # Profiles of this basic installation CD.
      ${modulesPath}/profiles/base.nix
      ${modulesPath}/profiles/installation-device.nix
    ];

    hardware.deviceTree.enable = true;

    hardware.enableAllHardware = true;

    # Adds terminus_font for people with HiDPI displays
    console.packages = options.console.packages.default ++ [ pkgs.terminus_font ];

    # EFI booting
    isoImage.makeEfiBootable = true;

    # USB booting
    isoImage.makeUsbBootable = true;

    # Add Memtest86+ to the CD.
    boot.loader.grub.memtest86.enable = true;

    # An installation media cannot tolerate a host config defined file
    # system layout on a fresh machine, before it has been formatted.
    swapDevices = lib.mkImageMediaOverride [ ];
    fileSystems = lib.mkImageMediaOverride config.lib.isoFileSystems;
    boot.initrd.luks.devices = lib.mkImageMediaOverride { };

    boot.postBootCommands = ''
      for o in $(</proc/cmdline); do
        case "$o" in
          live.nixos.passwd=*)
            set -- $(IFS==; echo $o)
            echo "nixos:$2" | ${pkgs.shadow}/bin/chpasswd
            ;;
        esac
      done
    '';

    environment.defaultPackages = with pkgs; [
      rsync
    ];

    programs.git.enable = lib.mkDefault true;

    system.stateVersion = lib.mkDefault lib.trivial.release;

    documentation.man.enable = lib.mkOverride 500 true;

    # Although we don't really need HTML documentation in the minimal installer,
    # not including it may cause annoying cache misses in the case of the NixOS manual.
    documentation.doc.enable = lib.mkOverride 500 true;

    fonts.fontconfig.enable = lib.mkOverride 500 false;

    isoImage.edition = lib.mkOverride 500 "minimal";
  };


}
