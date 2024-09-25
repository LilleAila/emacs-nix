{
  stdenv,
  runCommand,
  emacsPackagesFor,
  emacs30-pgtk,
  makeWrapper,

  # Color scheme
  callPackage,
  colorScheme,
}:
let
  emacsPackage = (emacsPackagesFor emacs30-pgtk).emacsWithPackages (
    epkgs: with epkgs; [
      # === Use-package ===
      use-package

      # === Completion ===
      ivy
      ivy-rich
      counsel
      swiper
      helpful
      elisp-refs

      # === UI ===
      all-the-icons
      doom-modeline
      (callPackage ./theme.nix { inherit colorScheme; })

      # === Keybinds ===
      evil
      evil-collection
      # which-key
      general
      hydra

      # === IDE ===
      lsp-mode
      lsp-ui
      lsp-treemacs
      lsp-ivy
      company
      company-box
      undo-tree
      evil-nerd-commenter
      direnv

      # === Languages ===
      typescript-mode
      nix-mode

      # === Org-mode ===
      org
      org-bullets
      visual-fill-column
    ]
  );
in
# runCommand "emacs-config"
#   {
#     nativeBuildInputs = [ makeWrapper ];
#     meta.mainProgram = "emacs";
#   }
#   ''
#     cp -r ${emacsPackage} $out
#     wrapProgram $out/bin/emacs \
#         --add-flags "--init-directory=${./.}"
#   ''
stdenv.mkDerivation {
  pname = "emacs-config";
  version = "0.0.1";
  src = emacsPackage;
  nativeBuildInputs = [
    makeWrapper
  ];
  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out/
  '';
  postFixup = ''
    wrapProgram $out/bin/emacs \
      --add-flags "--init-directory=${./.}"
  '';
  meta.mainProgram = "emacs";
}
