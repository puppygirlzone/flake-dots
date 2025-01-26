{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ahlo";
  home.homeDirectory = "/home/ahlo";
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # Hyprland stuff
    ags
    cava
    fastfetch
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    kitty
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    nwg-look
    rofi-wayland
    swappy
    swaynotificationcenter
    swww
    wallust
    waybar
    wlogout
    yad
    
    # Game Stuff
    godot3
    blender
    protonup-qt

    # Games
    prismlauncher
    atlauncher
    osu-lazer-bin

    # Programs
    ani-cli
    appimage-run
    bitwarden-desktop
    brave
    btop
    curl
    discord-canary
    discordo
    eza
    flameshot
    gimp
    helvum
    hidapi
    ivpn
    lazygit
    lunarvim
    mov-cli
    mpv
    mumble
    nerdfonts
    newsboat
    nodePackages_latest.create-react-native-app
    nodejs_22
    nvfancontrol
    obs-studio
    p7zip
    picom-pijulius
    pipewire
    python3
    python312Packages.devgoldyutils
    python312Packages.pip
    qemu
    qutebrowser
    slack
    stow
    sxiv
    tailscale
    thunderbird
    transmission_4-gtk
    usbutils
    vesktop
    vlc
    vscodium
    wget
    wineWowPackages.staging
    winetricks
    wofi
    xfce.thunar
    xfce.tumbler
    xorg.xinit
    yazi
    youtube-music
    yt-dlp
    zathura
    zoxide
    zulu17
    # KDE Packages
    kdePackages.qtmultimedia
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Picom?
#  services.picom.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
    xdgOpenUsePortal = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ahlo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "lvim";
  };

  programs.git = {
  enable = true;
  userName = "ItsNotAhlo";
  userEmail = "153831898+ItsNotAhlo@users.noreply.github.com";
  };

  # Picom
#  picom.override = { withDebug = true; };

  # imports = [
  #   ./home-modules/zsh.nix
  #   ./home-modules/tmux.nix
  #   ./home-modules/alacritty.nix
  #   ./home-modules/fzf.nix
  # ];

  programs = {
    zsh = (import ./home-modules/zsh.nix { inherit config pkgs; });
    tmux = (import ./home-modules/tmux.nix { inherit pkgs; });
    alacritty = (import ./home-modules/alacritty.nix { inherit config pkgs; });
    fzf = (import ./home-modules/fzf.nix { inherit pkgs; });
    # nvim = (import ./home-modules/nvim.nix {inherit pkgs; });
  };

  # wayland.windowManager = {
  #   hyprland = (import ./home-modules/hyprland.nix { inherit pkgs; });
  # };
#  programs.neovim = {
#      enable = true;
#      plugins = with pkgs.vimPlugins; [
#        nvchad
#	nvchad-ui
#	];
#  };
  
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
