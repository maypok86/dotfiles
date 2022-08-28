#! /usr/bin/env bash

# Shows the output of every command
set +x

rebuild_home() {
  nix build .#homeConfigurations.maypok-home.activationPackage
  HOME_MANAGER_BACKUP_EXT=bak result/activate
}

rebuild_system() {
  sudo nixos-rebuild switch --flake .#huawei-amd
}

rebuild_vm() {
  sudo nixos-rebuild build-vm --flake .#huawei-amd
}

restart_X() {
  echo "⚠️ Restarting X11 (requires authentication) ⚠️"
  systemctl restart display-manager
}

case $1 in
  "restart-x")
    restart_X;;
  "update-fish")
    fish -c fish_update_completions;;
  "home")
    rebuild_home;;
  "system")
    rebuild_system;;
  "vm")
    rebuild_vm;;
  *)
    echo "expected 'restart-x', 'update-fish', 'system' or 'vm'";;
esac
