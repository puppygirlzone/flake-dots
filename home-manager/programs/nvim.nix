{ pkgs, ... }:
enable = true
configure = {
  packages.myVimPackage = with pkgs.VimPlugins; {
    which-key-nvim
    
  };
}
