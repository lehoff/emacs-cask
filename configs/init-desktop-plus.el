(require 'desktop+)

;;; this does not work
;; (defun lehoff/save-notmuch-search-buffer (desktop-dirname)
;;   ;; just need the name of the current buffer
;;   buffer-name)

;; (add-hook 'notmuch-search-mode-hook
;;           (lambda()
;;             (setq-local desktop-save-buffer #'lehoff/save-notmuch-search-buffer)))

;; (defun lehoff/create-notmuch-search-buffer (_filename buffer-name misc)
;;   "misc is the value returned by lehoff/save-notmuch-search-buffer"
;;   (let ((notmuch-search misc))
;;     (notmuch-search-mode)))
