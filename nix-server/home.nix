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
    
    # Docker stuff
    docker
    docker-compose
    lazydocker
    # Security
    crowdsec
    # Programs I use
    yazi
    zoxide
    appimage-run
    btop
    curl
    eza
    lazygit
    lunarvim
    nerdfonts
    nodejs_22
    nodePackages_latest.create-react-native-app
    p7zip
    python3
    python312Packages.devgoldyutils
    python312Packages.pip
    stow
    wget
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


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    
    ".ssh/authorized_keys" = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6CKDT2NK0zjmHFeoyZKTVZK1M7aNUWxKILZoeRLvlb main-pc
    '';

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


  programs = {
    zsh = (import ./home-modules/zsh.nix { inherit config pkgs; });
    tmux = (import ./home-modules/tmux.nix { inherit pkgs; });
    fzf = (import ./home-modules/fzf.nix { inherit pkgs; });
  };
 
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
