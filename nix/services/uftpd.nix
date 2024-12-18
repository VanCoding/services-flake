{ pkgs
, lib
, name
, config
, ...
}:
{
  options = {
    ftpPort = lib.mkOption {
      type = lib.types.port;
      default = 2121;
    };
    tftpPort = lib.mkOption {
      type = lib.types.port;
      default = 6969;
    };
    directory = lib.mkOption {
      type = lib.types.str;
      default = "./";
    };
    package = lib.mkPackageOption pkgs "uftpd" { };
  };
  config.outputs.settings.processes.${name} = {
    command = ''
      ${pkgs.coreutils}/bin/mkdir -p ${config.directory}
      ${config.package}/bin/uftpd -o ftp=${builtins.toString config.ftpPort},tftp=${builtins.toString config.tftpPort} -n ${config.directory}
    '';
    availability = {
      restart = "on_failure";
      max_restarts = 5;
    };
    readiness_probe = {
      exec.command = ''
        ${if config.ftpPort == 0 then "" else "${pkgs.ncftp}/bin/ncftpls ftp://localhost:${builtins.toString config.ftpPort}"}
      '';
      initial_delay_seconds = 2;
      period_seconds = 10;
      timeout_seconds = 4;
      success_threshold = 1;
      failure_threshold = 5;
    };
  };
}
