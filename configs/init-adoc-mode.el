(add-to-list 'auto-mode-alist (cons "\\.txt\\'" 'adoc-mode))
(add-to-list 'auto-mode-alist (cons "\\.adoc\\'" 'adoc-mode))
(add-to-list 'auto-mode-alist (cons "\\.asciidoc\\'" 'adoc-mode))

(setq markup-meta-face '(:stipple nil :foreground "PaleVioletRed1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "Monospace"))
(setq markup-meta-hide-face '(:inherit markup-meta-face :foreground "dark magenta" :height 1))
