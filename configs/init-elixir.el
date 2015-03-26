;;; init-elixir.el --- 


;;; Commentary:

;; Set-up of elixir emacs mode. 

;;; Code:

(require 'elixir-mode)
(elixir-mode)

;; (add-to-list 'elixir-mode-hook
;;              (defun auto-activate-ruby-end-mode-for-elixir-mode ()
;;                (set (make-variable-buffer-local 'ruby-end-expand-keywords-before-re)
;;                     "\\(?:^\\|\\s-+\\)\\(?:do\\)")
;;                (set (make-variable-buffer-local 'ruby-end-check-statement-modifiers) nil)
;;                (ruby-end-mode +1)))



(require 'alchemist)

(require 'flymake-elixir)
(add-hook 'elixir-mode-hook 'flymake-elixir-load)

;;; init-elixir.el ends here
