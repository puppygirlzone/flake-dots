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
    yad
    cava
    fastfetch
    kitty
    rofi-wayland
    swappy
    swww
    swaynotificationcenter
    wallust
    wlogout
    waybar
    libsForQt5.qt5ct
    kdePackages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    nwg-look
    # hello
    vscodium
    ani-cli
    appimage-run
    atlauncher
    bitwarden-desktop
    blender
    brave
    btop
    chatterino2
    curl
    discord-canary
    discordo
    eza
    flameshot
    gimp
    godot3
    helvum
    hidapi
    ivpn
    lazygit
    lunarvim
    modrinth-app
    mov-cli
    mpv
    mumble
    nerdfonts
    newsboat
    nodejs_22
    nodePackages_latest.create-react-native-app
    nvfancontrol
    obs-studio
    obsidian
    osu-lazer-bin
    p7zip
    picom-pijulius
    pipewire
    prismlauncher
    protonup-qt
    python3
    python312Packages.devgoldyutils
    python312Packages.pip
    qemu
    qtemu
    qutebrowser
    ragnarwm
    simplex-chat-desktop
    slack
    steam
    stow
    sxiv
    tailscale
    texmaker
    thunderbird
    transmission-gtk
    vlc
    warp-terminal
    webcord-vencord
    wget
    wineWowPackages.staging
    winetricks
    wofi
    xfce.thunar
    xorg.xinit
    youtube-music
    yt-dlp
    zathura
    zulu17
    # KDE Packages
    kdePackages.qtmultimedia
    # Fuck you Lunarvim I'll add it myself
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

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "*";

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
    # EDITOR = "emacs";
  };

  programs.git = {
  enable = true;
  userName = "ItsNotAhlo";
  userEmail = "153831898+ItsNotAhlo@users.noreply.github.com";
  };

#  programs.zsh = {
#  enable = true;
#  enableCompletion = false;
#  autosuggestion.enable = true;
#  syntaxHighlighting.enable = true;
#  antidote.enable = true;
#
#  antidote.plugins = [
#  "hlissner/zsh-autopair"
#  "marlonrichert/zsh-autocomplete"
#  ];
#
#  shellAliases = {
#    ls = "ls -a";
#    update = "home-manager switch";
#    nvim = "lvim";
#    vim = "lvim";
#    test = "home-manager build";
#    ani-cli = "ani-cli-unwrapped --skip";
#    };
#  };

  # Picom
#  picom.override = { withDebug = true; };

  programs = {
    zsh = (import ./zsh.nix { inherit config pkgs; });
    tmux = (import ./tmux.nix { inherit pkgs; });
    alacritty = (import ./alacritty.nix { inherit config pkgs; });
    fzf = (import ./fzf.nix { inherit pkgs; });
    # nvim = (import ./nvim.nix {inherit pkgs; });
  };

  # wayland.windowManager = {
  #   hyprland = (import ./hyprland.nix { inherit pkgs; });
  # };
#  programs.neovim = {
#      enable = true;
#      plugins = with pkgs.vimPlugins; [
#        nvchad
#	nvchad-ui
#	];
#  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
