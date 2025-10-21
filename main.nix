{ pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "alechandheld";
  #home-manager.users.alec.imports = [ ./hm.nix ];

  boot = {
    loader = {
      grub.enable = lib.mkForce false;
      generic-extlinux-compatible.enable = lib.mkForce true;
    };
    #kernelPackages = pkgs.linuxPackages_latest;
  };
  sdImage.compressImage = false;

  # Host-specific packages
  environment.systemPackages = with pkgs; [
    gitMinimal
    #pegasus-frontend
    #emulationstation-de
  ];
  system.stateVersion = "24.05";
}