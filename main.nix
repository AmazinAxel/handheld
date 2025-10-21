{ pkgs, lib, config, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "alechandheld";
  #home-manager.users.alec.imports = [ ./hm.nix ];

  users.users.alec = { # Default user
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "dialout" ];
  };


  nixpkgs.config.allowUnfree = true;
  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    initrd.enable = false;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware.deviceTree = {
    enable = true;
    dtbSource = ./sun50i-h700-anbernic-rg35xx-h.dtb;
  };

  networking.networkmanager.enable = true;

  #boot.kernelPatches =
  #  [
  #    {
  #      name = "h700-config";
  #      patch = null;
  #      extraStructuredConfig = {
  #        DRM = lib.kernel.yes;
  #        INPUT_JOYSTICK = lib.kernel.yes;
  #        JOYSTICK_SINGLEADCJOY = lib.kernel.yes;
  #        EMBEDDED = lib.kernel.yes;
  #      };
  #    }
  #  ];# ++ builtins.map (p: {
    #  name = builtins.elemAt (pkgs.lib.splitString "." (builtins.baseNameOf p.url)) 0;
    #  patch = pkgs.fetchpatch p;
    #}) (import ./rocknix-patches.nix);

  environment.systemPackages = with pkgs; [
    gitMinimal
    #pegasus-frontend
    #emulationstation-de
  ];
  system.stateVersion = "24.05";
}