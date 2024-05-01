{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.cybersecurity.enable) {
    environment = {
      systemPackages = with pkgs; [
        # Cyber Tools
        nmap
        crackmapexec
        gobuster
        theharvester
        ffuf
        wfuzz
        metasploit
        exploitdb
        sqlmap
        smbmap
        arp-scan
        enum4linux
        enum4linux-ng
        dnsrecon
        testssl
        hashcat
        john
        thc-hydra
        whatweb
        evil-winrm
        crunch
        hashcat-utils
        cadaver
        wpscan
        certipy
        coercer
        gomapenum
        kerbrute
        nbtscanner
        smbscan
        davtest
        adenum
        proxychains-ng
        aircrack-ng
        hcxtools
        hcxdumptool
        wordlists
        bloodhound
        bloodhound-py
        psudohash
        responder
        maltego

        # Utilities
        openssl
        cifs-utils
        nfs-utils
        wireguard-tools
        samba
        net-snmp
        tcpdump
        inetutils
        distrobox

        #dependencies
        libxml2
      ];
      wordlist = { };
    };
    programs.wireshark.enable = true;

  };
}
