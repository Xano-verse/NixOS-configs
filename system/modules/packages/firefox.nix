{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;

    # Make firefox use dolphin as a file picker (the KDE file picker)
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };


  # Make firefox use xinput2
  # This improves touchscreen support and enables additional touchpad gestures. It also enables smooth scrolling as opposed to the stepped scrolling that Firefox has by default
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  # Improve screen sharing on wayland (xdg desktop integration options in configuration.nix are also doing there for screen sharing support with wayland for example)
  environment.systemPackages = with pkgs; [
    (wrapFirefox (firefox-unwrapped.override { pipewireSupport = true; }) {})
  ];
}
