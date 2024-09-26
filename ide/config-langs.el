;; Typescript
(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

;; Nix
(use-package nix-mode
  :mode "\\.nix\\'"
  :hook (nix-mode . lsp-deferred))

;; Markdown
;; TODO: https://jblevins.org/log/mmm
(use-package markdown-mode
  :mode "\\.md\\'"
  :hook (markdown-mode . variable-pitch-mode)
  :config
  ;; https://emacs.stackexchange.com/questions/14740/how-to-configure-markdown-mode-to-render-headings-like-org-mode
  (markdown-toggle-fontify-code-blocks-natively 1)
  (custom-set-faces
    '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.8))))
    '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.4))))
    '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.2))))))

(provide 'config-langs)
