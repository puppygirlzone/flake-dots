{ config, pkgs, ... }:
{
  enable = true;
  enableCompletion = false;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  history.size = 10000;
  history.path = "${config.xdg.dataHome}/zsh/history";

  initExtra = ''
    bindkey -e

    [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}

    # disable sort when completing `git checkout`
    zstyle ':completion:*:git-checkout:*' sort false
    # set descriptions format to enable group support
    # NOTE: don't use escape sequences here, fzf-tab will ignore them
    zstyle ':completion:*:descriptions' format '[%d]'
    # set list-colors to enable filename colorizing
    zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
    # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
    zstyle ':completion:*' menu no
    # preview directory's content with eza when completing cd
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:ls:*' fzf-preview 'cat $realpath'
    # switch group using `<` and `>`
    zstyle ':fzf-tab:*' switch-group '<' '>'
    path+=('/home/ahlo/.node-global/bin')
    path+=('/home/ahlo/.wine')
    export PATH=/home/$USER/.local/bin:$PATH
    eval "$(zoxide init zsh)"

    # Yazi cd
    function yy() {
      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
      yazi "$@" --cwd-file="$tmp"
      if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
      fi
      rm -f -- "$tmp"
    }
  '';

#  antidote.enable = true;
#  antidote.plugins = [
#    "hlissner/zsh-autopair"
#    "marlonichert/zsh-autocomplete"
#  ];

  oh-my-zsh = {
    enable = true;
    plugins = [
      "git" "sudo" "golang" "command-not-found" "pass" "docker" "rsync"
    ];
  };

    plugins = [
    {
      # will source zsh-autosuggestions.plugin.zsh
      name = "zsh-autosuggestions";
      src = pkgs.zsh-autosuggestions;
      file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
    }
    {
      name = "zsh-completions";
      src = pkgs.zsh-completions;
      file = "share/zsh-completions/zsh-completions.zsh";
    }
    {
      name = "zsh-syntax-highlighting";
      src = pkgs.zsh-syntax-highlighting;
      file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
    }
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
    {
      name = "fzf-tab";
      src = pkgs.zsh-fzf-tab;
      file = "share/fzf-tab/fzf-tab.plugin.zsh";
    }
  ];

  shellAliases = {
    ls = "eza -l --git --no-permissions --icons=auto --no-filesize --no-time --no-user";
    update = "home-manager switch --flake ~/.flake-dots/.#ahlo";
    test = "home-manager test --flake ~/.flake-dots/.#ahlo";
    nvim = "lvim";
    vim = "lvim";
#    ani-cli = "ani-cli-unwrapped --skip";
    tree = "eza -lRT --git --no-permissions --icons=auto --no-filesize --no-time --no-user";
    diary = ".~/scripts/diary";
    rebuild = "sudo nixos-rebuild switch --flake ~/.flake-dots/.#jibriel";
    rebuild-test = "sudo nixos-rebuild test --flake ~/.flake-dots/.#jibriel";
  };
}
