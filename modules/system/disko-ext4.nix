{
  inputs,
  config,
  lib,
  ...
}:
{
  flake.nixosModules.ext4-disko =
    {
      ...
    }:
    let
      cfg = config.ext4-disko;
    in
    {

      imports = [
        inputs.disko.nixosModules.disko
      ];

      options.ext4-disko = {
        main-device = lib.mkOption {
          type = lib.types.str;
        };
      };

      disko.devices = {
        disk = {
          main = {
            device = "/dev/${cfg.main-device}";
            type = "disk";
            content = {
              type = "gpt";
              partitions = {
                boot = {
                  size = "1M";
                  type = "EF02"; # for grub MBR
                };
                ESP = {
                  size = "1G";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };
                root = {
                  size = "100%";
                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                  };
                };
              };
            };
          };
        };
      };
    };
}
