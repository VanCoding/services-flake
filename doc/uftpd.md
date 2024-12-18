# uftpd

[uftpd](https://troglobit.com/projects/uftpd/) is a trivial, open-source FTP & TFTP server.

## Getting Started

```nix
# In `perSystem.process-compose.<name>`
{
  services.uftpd."ftp-server" = {
    enable = true;
    ftpPort = 2121; # default, 0 = disable FTP
    tftpPort = 6969; # default, 0 = disable TFTP
    directory = "./"; # default
  };
}
