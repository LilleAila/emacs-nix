{
  pkgs,
  emacs-all-the-icons-fonts,
  emacsPackagesFor,
  emacs-pgtk, # Would use emacs-unstable-pgtk, but nix-community/emacs-overlay#425
  wrapper-manager,

  # Color scheme
  callPackage,
  colorScheme,
}:
let
  emacsPackage = (emacsPackagesFor emacs-pgtk).emacsWithPackages (
    epkgs: with epkgs; [
      # === Use-package ===
      use-package

      # === Completion ===
      ivy
      ivy-rich
      counsel
      swiper
      helpful

      # === UI ===
      all-the-icons
      emacs-all-the-icons-fonts
      doom-modeline
      (callPackage ./theme.nix { inherit colorScheme; })

      # === Keybinds ===
      evil
      evil-collection
      which-key
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

      # === Org-mode ===
      org
      org-bullets
      visual-fill-column
    ]
  );
in
(wrapper-manager.lib.build {
  inherit pkgs;
  modules = [
    {
      wrappers.emacs = {
        basePackage = emacsPackage;
        flags = [
          "--init-directory"
          "${./.}"
        ];
      };
    }
  ];
}).overrideAttrs
  {
    meta.mainProgram = "emacs";
  }
