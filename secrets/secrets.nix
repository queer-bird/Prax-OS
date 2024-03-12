let
  cmde = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO+ZdcDI7nryzyzhAiCnRlnU7+0Nzlr4n6rAgW4hFbxT pokingvictim@protonmail.com
";

  io = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIFMR4XHc7mhSs0Diy2gWtXurueQiQ1gKjyzW2fuqtqv root@io";
in {
  "spotify.age".publicKeys = [cmde io];
}
