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
    enable = false;
    name = "allwinner/h700-anbernic-rg35xxh.dtb";

    package =
      pkgs.runCommandCC "h700-dts" {
        inherit (config.boot.kernelPackages.kernel) src;
        nativeBuildInputs = [ pkgs.dtc ];
      } ''
        unpackPhase
        cd "$sourceRoot"
        DTS=arch/arm64/boot/dts/h700-anbernic-rg35xxh.dts
        cp "${./sun50i-h700-anbernic-rg35xx-h.dtb}" "$DTS"
        mkdir -p "$out/rockchip"
        $CC -E -nostdinc -Iinclude -undef -D__DTS__ -x assembler-with-cpp "$DTS" | \
          dtc -I dts -O dtb -@ -o "$out/allwinner/h700-anbernic-rg35xxh.dtb"
      '';
  };

  environment.systemPackages = with pkgs; [
    gitMinimal
    #pegasus-frontend
    #emulationstation-de
  ];
  system.stateVersion = "24.05";
}