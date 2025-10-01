{ config, lib, ... }:

{
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.sudo.wheelNeedsPassword = true;
}
