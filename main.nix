{ pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "alechandheld";
  #home-manager.users.alec.imports = [ ./hm.nix ];

  #nixpkgs.config.allowUnfree = true;
  boot = {
    loader = {
      grub.enable = lib.mkForce false;
      generic-extlinux-compatible.enable = lib.mkForce true;
    };
    #kernelPackages = pkgs.linuxPackages_latest;
  };
  sdImage.compressImage = false;

  hardware.deviceTree = {
    enable = true;
    name = "allwinner/h700-anbernic-rg35xxh.dtb";
    path = ./sun50i-h700-anbernic-rg35xx-h.dtb
  };

  # Host-specific packages
  environment.systemPackages = with pkgs; [
    gitMinimal
    #pegasus-frontend
    #emulationstation-de
  ];
  system.stateVersion = "24.05";
}