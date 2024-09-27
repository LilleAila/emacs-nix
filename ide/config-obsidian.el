;; Manual re-implementation of this: https://github.com/licht1stein/obsidian.el/blob/1d1adbdbfdac9a4f89c6d28225a0dbf0caecdda3/obsidian.el#L754
;; because the `eval-when-compile` doesn't trigger on NixOS
(defhydra obsidian-hydra (:hint nil)
  "
    Obsidian
    _f_ollow at point   insert _w_ikilink          _q_uit
    _j_ump to note      insert _l_ink              capture daily _n_ote
    _t_ag find          _c_apture new note
    _s_earch by expr.   _u_pdate tags/alises etc.
  "
  ("c" obsidian-capture)
  ("n" obsidian-daily-note)
  ("f" obsidian-follow-link-at-point)
  ("j" obsidian-jump)
  ("l" obsidian-insert-link :color blue)
  ("q" nil :color blue)
  ("s" obsidian-search)
  ("t" obsidian-tag-find)
  ("u" obsidian-update)
  ("w" obsidian-insert-wikilink :color blue))

(use-package obsidian
  :config
  (obsidian-specify-path "~/Documents/Obsidian Vault")
  (global-obsidian-mode t)
  :custom
  (obsidian-inbox-directory "Notes")
  (obsidian-daily-notes-directory "Daily")
  (obsidian-include-hidden-files 0)
  :bind (:map obsidian-mode-map
  ("C-c C-o" . obsidian-follow-link-at-point)
  ("C-c C-b" . obsidian-backlink-jump)
  ("C-c C-l" . obsidian-insert-wikilink))
  :bind
  ("C-c M-o" . obsidian-hydra/body)
)

(provide 'config-obsidian)
