{ ... }:

{
  desktops.kde.enable = true;
  programs.plasma = {
    powerdevil = {
      AC = {
        autoSuspend = {
          action = "nothing";
          idleTimeout = null;
        };
        dimDisplay.enable = false;
        powerButtonAction = "sleep";
        powerProfile = "performance";
        turnOffDisplay = {
          idleTimeout = 1800;
          idleTimeoutWhenLocked = 900;
        };
        whenLaptopLidClosed = "sleep";
        whenSleepingEnter = "standbyThenHibernate";
      };

      battery = {
        autoSuspend = {
          action = "sleep";
          idleTimeout = 600;
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 300;
        };
        powerButtonAction = "sleep";
        powerProfile = "balanced";
        turnOffDisplay = {
          idleTimeout = null;
          idleTimeoutWhenLocked = null;
        };
        whenLaptopLidClosed = "sleep";
        whenSleepingEnter = "standbyThenHibernate";
      };

      general.pausePlayersOnSuspend = true;
    };
  };
}
