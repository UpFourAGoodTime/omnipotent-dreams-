# In this example the top-level configuration is a [`flake-parts`](https://flake.parts) one.
# Therefore, every Nix file (other than this) is a flake-parts module.
{
  # Declares flake inputs
  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    import-tree = {
      url = "github:vic/import-tree";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh = {
      url = "github:nix-community/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    x1e-nixos-config = {
      url = "github:UpFourAGoodTime/x1e-nixos-config";
    };

    nixpkgs.url = "github:nixos/nixpkgs/25.11";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; }
      # Imports all of the top-level modules (the files under `./modules`)
      (inputs.import-tree ./modules);
}
