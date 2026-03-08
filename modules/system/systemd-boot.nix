{
  # inputs,
  ...
}:
{
  flake.nixosModules.systemd-boot =
    {
      ...
    }:
    {
      boot = {
        initrd = {
          systemd.enable = true;
          verbose = false;
        };
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          timeout = 0;
        };
      };
    };
}
