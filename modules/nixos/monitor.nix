{ lib, config, ... }:
let
  cfg = config.hardware.display;
  getPrimary = monitors: lib.head (lib.filter (monitor: monitor.primary == true) monitors);
in
{
  options.hardware.display = {
  monitors = lib.mkOption {
    type = lib.types.listOf (lib.types.attrsOf {
      name = lib.types.str;
      alias = lib.types.str;
      width = lib.types.int;
      height = lib.types.int;
      refreshRate = lib.types.int;
      primary = lib.types.bool;
      headless = lib.types.bool;
    });
    description = "List of monitor configurations.";
    default = [];
  };

  };
  config.hardware.display = {
    monitors = cfg.monitors;
  };
}
