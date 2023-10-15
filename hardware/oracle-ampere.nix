{ config, lib, pkgs, modulesPath, ... }:
 
{
  imports =
    [
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F20F-05B1";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/sda2";
    fsType = "ext4";
  };

  # Boot sections
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
  };

  boot.initrd.kernelModules = [ "nvme" ];

  # Network settings
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
  networking.enableIPv6 = true;
}
