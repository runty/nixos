shell: {
  cat = "bat";
  ls = "eza -al --color=always --group-directories-first --icons";
  ll = "eza -l --color=always --group-directories-first --icons";
  la = "eza -a --color=always --group-directories-first --icons";
  ldot = "eza -a | grep -e '^\.'";
  vi = "nvim";
  nsh = "nix-shell --run ${shell}";
  dev = "nix develop --command ${shell}";
}
