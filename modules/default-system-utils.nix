{
  config,
  lib,
  pkgs,
  ...
}: 
{
  options = {
    default-system-utils.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable or disable system environment utilities (htop, sshpass, rsync, etc.)";
    };
  };

  config = lib.mkIf config.default-system-utils.enable {
    home.packages = with pkgs; [
      htop
      rsync
      cowsay
      sshpass
    ];
  };
}