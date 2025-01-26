{pkgs, ...}:
{
  enable = true;
  xwayland.enable = true;
  settings = {
    "$mod" = "ALT";
    input = {
      monitor = [
      ];
    };
    bind =
    [
      "$mod, Q, exec, alacritty"
      "$mod, X, fakefullscreen"
      "$mod, C, killactive"
      "$mod, M, exit"
      "$mod, B, exec, firefox"
      "$mod, F, exec, nautilus"
      "$mod, V, togglefloating"
      "$mod, R, exec, wofi --show drun"
      "$mod, P, pseudo"
      "$mod, J, togglesplit"
      "$mod, T, togglegroup"
      "$mod+CTRL, J, changegroupactive, f"
      "$mod+CTRL, K, changegroupactive, f"
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
      "$mod, Z, fullscreen, 1"
    ]
    ++ (
      builtins.concatLists (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString(x + 1 - (c * 10));
        in [
          "$mod, ${ws}, workspace, ${toString (x + 1)}"
          "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        ]
      )
      10)
    );
  };

  extraConfig = ''
  exec-once = waybar
  exec = gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"   # for GTK3 apps
  exec = gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"   # for GTK4 apps

  env = QT_QPA_PLATFORMTHEME,qt6ct   # for Qt apps

  exec-once = $HOME/.local/lib/import_env tmux

  bindm=$mod,mouse:272,movewindow
  bindm=$mod,mouse:273,resizewindow

  bezier=easeOutBack,0.34,1.56,0.64,1
  bezier=easeInBack,0.36,0,0.66,-0.56
  bezier=easeInCubic,0.32,0,0.67,0
  bezier=easeInOutCubic,0.65,0,0.35,1
  animation=windowsIn,1,5,easeOutBack,popin
  animation=windowsOut,1,5,easeInBack,popin
  animation=fadeIn,0
  animation=fadeOut,1,10,easeInCubic
  animation=workspaces,1,4,easeInOutCubic,slide
  general:gaps_out=30
  xwayland {
    force_zero_scaling = true
  }

  monitor=DP-1,2560x1440,0x240,1,
  monitor=DP-3,2560x1440,-2560x240,1
  monitor=DP-2,1920x1080,auto-right,1,transform,1

  input {
    follow_mouse = 1
      touchpad {
        natural_scroll = true
          disable_while_typing = true
          tap-to-click = false
          middle_button_emulation = false
      }
    sensitivity = 0
  }
  '';
}
