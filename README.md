# NixOS for RG35XX-H

Build from an arch64 device such as a Pi (dont cross compile): `nix build .#nixosConfigurations.alechandheld.config.system.build.sdImage`
Then flash to SD card using rpi-flasher or `dd`
