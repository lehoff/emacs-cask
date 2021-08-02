
(setq erlang-version "21.3.8.9")
(setq erl-top (format "%s/%s" "~/.asdf/installs/erlang" erlang-version))

(setq erlang-root-dir erl-top)
;; (setq tools-ver "2.6.11")
;; (setq load-path (cons (concat erlang-root-dir "/lib/tools-" tools-ver "/emacs")
;;                       load-path))
(setq exec-path (cons (concat erlang-root-dir "/bin")
                      exec-path))


(require 'erlang-start)

;(add-to-list 'load-path "~/tools/distel/elisp")
;(require 'distel)
;(distel-setup)

;; Wrangler


;; NOTE: check if ~/.erlang has a code path to the Wrangler ebin dir
;; This goes away in a future Emacs for Erlang, so as a hack:
(defconst erlang-xemacs-p (string-match "Lucid\\|XEmacs" emacs-version)
  "Non-nil when running under XEmacs or Lucid Emacs.")

;; install with brew!
;(add-to-list 'load-path
;             "/usr/local/lib/erlang/lib/wrangler-1.2.0/elisp")
;(add-to-list 'load-path
                                        ;             "~/.emacs.d/el-get/distel/elisp")
;(add-to-list 'load-path
                                        ;             "~/Library/Erlang/lib/erlang/lib/wrangler-1.2.0/elisp")
(add-to-list 'load-path
             "~/tools/wrangler/elisp")
(require 'wrangler)

(add-hook 'erlang-mode-hook 'esk-prog-mode-hook)

;(setq erlang-indent-level 2)

;; Align (thanks @eproxus)
(add-hook 'align-load-hook
          (lambda ()
            (add-to-list 'align-rules-list
                         '(erlang-align
                           (regexp . ",\\(\\s-+\\)")
                           (repeat . t)
                           (modes quote (erlang-mode))))))

;; ;; edts for Erlang
;; (add-to-list 'load-path "~/git_repos/edts")
;; (require 'edts-start)

;; (setq edts-projects
;;       '(( ;; lotl
;;          (root       . "~/git_repos/lotl")
;;          (lib-dirs   . ("deps" "test")) 
;;          )))
        ;; ( ;; My awesome project.
        ;;  (name       . "awesome_stuff")
        ;;  (root       . "~/src/awesome_stuff")
        ;;  (node-sname . "awesome")
        ;;  (otp-path   . "~/otp/r15b02"
        ;;  (start-command . "./start-being-awesome.sh"))
        ;; ( ;; My other project.
        ;;  (name       . "other_stuff")
        ;;  (root       . "~/src/other_stuff")
        ;;  (node-sname . "not_as_awesome")
        ;;  (lib-dirs   . ("lib" "test")))))

(defun insert-erl-emacs-vars ()
  "Insert the right local variables."
  (interactive)
  (insert "%%% Local Variables:\n")
  (insert "%%% erlang-indent-level: 2\n")
  (insert "%%% End:"))


;;; (require 'flycheck-dialyzer)
;;; (add-hook 'erlang-mode-hook 'flycheck-mode)
