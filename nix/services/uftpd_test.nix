{ pkgs, ... }:
{
  services.uftpd."uftpd" = {
    enable = true;
  };

  settings.processes.test = {
    command = pkgs.writeShellApplication {
      runtimeInputs = [ pkgs.ncftp ];
      text = ''
        ncftpls -P 2121 ftp://localhost/
      '';
      name = "uftpd-test";
    };
  };
}
