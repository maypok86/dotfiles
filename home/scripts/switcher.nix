{ config, pkgs, ... }:

let
  home   = "${config.xdg.configHome}/nixpkgs";
  fish   = "${pkgs.fish}/bin/fish";
  rg     = "${pkgs.ripgrep}/bin/rg";
  xrandr = "${pkgs.xorg.xrandr}/bin/xrandr";
in
  pkgs.writeShellScriptBin "hms" ''
    if [[ $1 == "fish" ]]; then
      ${fish} -c fish_update_completions
    fi
    if [[ $1 == "restart" ]]; then
      echo "⚠️ Restarting X11 (requires authentication) ⚠️"
      systemctl restart display-manager
    fi
  ''
