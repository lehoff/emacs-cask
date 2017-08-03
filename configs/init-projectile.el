
(defun projectile-key-bindings()
  (local-set-key (kbd "M-s") 'helm-projectile-ag)
  (local-set-key (kbd "C-M-s") 'helm-git-grep)
)

(add-hook 'projectile-mode-hook 'projectile-key-bindings)
