(require 'flymake)
(require 'erlang-flymake)

(setq flymake-gui-warnings-enabled nil
      flymake-log-level 0
      )

(require 'cl-lib)
(defun my-flymake-cfgerr-is-benign (orig-fun &rest args)
  "Don't let `flymake-post-syntax-check' deactivate Flymake.
As described in http://debbugs.gnu.org/cgi/bugreport.cgi?bug=2491,
CFGERR errors can be benign conditions."
  ;; Using `cl-letf' as a kind of temporary advice.
  (cl-letf (((symbol-function 'flymake-report-fatal-status)
             (lambda (_status _warning)
               (flymake-report-status "0/0" ":CFGERR"))))
    (apply orig-fun args)))

(with-eval-after-load "flymake"
  (advice-add 'flymake-post-syntax-check :around 'my-flymake-cfgerr-is-benign))


(defvar mh-erlang-flymake-code-path-dirs (list "../deps/*/ebin")
  "List of directories to add to code path for Erlang Flymake.
Wildcards are expanded.")

(defun mh-simple-get-deps-code-path-dirs ()
  ;; Why complicate things?
  (and (buffer-file-name)
       (let ((default-directory (file-name-directory (buffer-file-name))))
         (apply 'append
                (mapcar
                 (lambda (wildcard)
                   ;; If the wild card expands to a directory you
                   ;; don't have read permission for, this would throw
                   ;; an error.
                   (ignore-errors
                     (file-expand-wildcards wildcard)))
                 mh-erlang-flymake-code-path-dirs)))))

(defun mh-simple-get-deps-include-dirs ()
  (list "../include" "../src" ".."))

(setq erlang-flymake-get-code-path-dirs-function 'mh-simple-get-deps-code-path-dirs
      erlang-flymake-get-include-dirs-function 'mh-simple-get-deps-include-dirs)


;; Erlang
;; (defun flymake-erlang-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file
;;           (file-relative-name temp-file
;;                               (file-name-directory buffer-file-name))))
;;     (list (concat emacs-config-dir
;;                   "/scripts/"
;;                   "flymake_erlang_script") (list local-file))))

;; (add-to-list 'flymake-allowed-file-name-masks
;;              '("\\.erl\\'" flymake-erlang-init))

;; (add-hook 'find-file-hook 'flymake-find-file-hook)

;; Disable flymake for html and xml files as this is handled by nxml mode.
(delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)
(delete '("\\.xml\\'" flymake-xml-init) flymake-allowed-file-name-masks)
(delete '("\\.java\\'" flymake-simple-make-java-init flymake-simple-java-cleanup)
 flymake-allowed-file-name-masks)

(defun flymake-get-tex-args (file-name)
  (list "latex" (list "-file-line-error-style" file-name)))


;; see `flymake-start-syntax-check'
(defun my-flymake-compile-manually ()
  (interactive)
  (let* ((init-f (flymake-get-init-function buffer-file-name))
         (cmd-and-args (funcall init-f))
         (cmd (nth 0 cmd-and-args))
         (args (nth 1 cmd-and-args))
         (dir (nth 2 cmd-and-args)))
    (let ((default-directory (or dir default-directory)))
      (compile
       (apply 'concat cmd " " (mapcar (lambda (arg) (concat (shell-quote-argument arg) " ")) args))))))
