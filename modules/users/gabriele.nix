{
  ...
}:
{
  flake.nixosModules.gabriele-config =
    {
      ...
    }:
    {
      users.users."gabriele" = {
        createHome = true;
        description = "Gabriel Eaker";
        extraGroups = [
          "networkmanager"
          "wheel"
          # "qemu-libvirtd"
          # "libvirtd"
        ];
        isNormalUser = true;
        home = "/home/gabriele";

      };
    };
}
