{ config, lib, userName, ... }:

{
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "storage"
      "scanner"
      "lp"
    ];
  };
}
