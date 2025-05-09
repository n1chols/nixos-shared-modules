{
  outputs = { self, nixpkgs }: {
    nixosModules = {
      default = { pkgs, ... }: {
        # Enable flakes
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
      
        # Remove default packages
        environment.defaultPackages = [];
        services.xserver.excludePackages = [ pkgs.xterm ];
      
        # Allow unfree packages
        nixpkgs.config.allowUnfree = true;
      
        # Enable all firmware
        hardware.enableAllFirmware = true;
      };
      networkmanager = { lib, ... }: {
        # Enable NetworkManager
        networking = {
          networkmanager.enable = true;
          useDHCP = lib.mkDefault true;
        };
      };
      pipewire = { ... }: {
        # Enable RTKit
        security.rtkit.enable = true;
      
        # Enable PipeWire
        services.pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
        };
      };
      bluetooth = { ... }: {
        # Enable Bluetooth driver
        hardware.bluetooth = {
          enable = true;
          powerOnBoot = true;
        };
      };
      printing = { ... }: {
        # Enable printing service
        services.printing.enable = true;
      
        # Enable printer autodiscovery
        services.avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
      };
      plasma6 = { ... }: {
        # Enable KDE Plasma 6
        services.desktopManager.plasma6.enable = true;
      };
    };
  };
}
