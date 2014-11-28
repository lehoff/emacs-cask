;; based on https://github.com/rdallasgray/pallet

(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; from old init.el

;; EQC Emacs Mode -- Configuration Start
(add-to-list 'load-path "/Users/th/Library/Erlang/lib/eqc-1.30.5/emacs/")
(autoload 'eqc-erlang-mode-hook "eqc-ext" "EQC Mode" t)
(add-hook 'erlang-mode-hook 'eqc-erlang-mode-hook)
(setq eqc-max-menu-length 30)
(setq eqc-root-dir "/Users/th/Library/Erlang/lib/eqc-1.30.5")
;; EQC Emacs Mode -- Configuration End


(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))
 
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))


(when (eq system-type 'darwin)
  (setq mac-option-modifier 'none))

;; keyboard shortcuts
(global-set-key [s-left] 'beginning-of-line)
(global-set-key [s-right] 'end-of-line)
(global-set-key [s-up] 'beginning-of-buffer)
(global-set-key [s-down] 'end-of-buffer)
(global-set-key [M-right] 'forward-word)
(global-set-key [M-left] 'backward-word)

(global-set-key [f4] 'mu4e-update-mail-and-index)
(global-set-key [C-f4] 'smtpmail-send-queued-mail)
(global-set-key [f5] 'mu4e)
(global-visual-line-mode 1)
(delete-selection-mode 1)



;;; Spelling

(setq ispell-auto-detect-encoding nil)
(setq-default ispell-program-name "aspell")
(setq ispell-dictionary "british-ise-w_accents"
  ispell-extra-args '() ;; TeX mode "-t"
  ispell-silently-savep t
  )

(setq flyspell-mode-map nil)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(add-hook 'ispell-initialize-spellchecker-hook
      (lambda ()
    (setq ispell-base-dicts-override-alist
          '((nil ; default
         "[A-Za-z]" "[^A-Za-z]" "[']" t
         ("-d" "en_US" "-i" "utf-8") nil utf-8)
        ("american" ; Yankee English
         "[A-Za-z]" "[^A-Za-z]" "[']" t
         ("-d" "en_US" "-i" "utf-8") nil utf-8)
        ("british" ; British English
         "[A-Za-z]" "[^A-Za-z]" "[']" t
         ("-d" "en_GB" "-i" "utf-8") nil utf-8)))))

(if (string-equal "darwin" (symbol-name system-type))
    (progn
      (push "/usr/local/bin" exec-path)
      (push "/usr/local/sbin" exec-path)
      (push "/usr/texbin" exec-path)
      (push "/usr/bin" exec-path)
      (push "/usr/sbin" exec-path)
      (push "~/.cabal/bin" exec-path)
      (setenv "PATH"
              (concat "/usr/local/bin:/usr/local/sbin:"
                      "~/.cabal/bin:"
                      "/usr/texbin:" (getenv "PATH")))
      (setenv "ERL_LIBS"
              (concat "/Users/th/Library/Erlang/lib/"))
      (set-fontset-font "fontset-default"
                        'unicode
                        '("Menlo" . "iso10646-1"))
      (set-frame-font "Menlo-11")
      (set-frame-size (selected-frame) 120 65)))



(add-hook 'before-make-frame-hook
      #'(lambda ()
          (add-to-list 'default-frame-alist '(left   . 0))
          (add-to-list 'default-frame-alist '(top    . 0))
          (add-to-list 'default-frame-alist '(height . 65))
          (add-to-list 'default-frame-alist '(width  . 120))))

;; from http://stackoverflow.com/questions/92971/how-do-i-set-the-size-of-emacs-window
(setq default-frame-alist
      '((top . 20) (left . 200)
        (width . 120) (height . 65)
        (font . "Menlo-11")))
        

(setq disabled-command-function nil)

;; Basic stuff we really need all the time
(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'ansi-color)

;;; needed for programming
(require 'thingatpt)

;;; customisations
(if (string-equal "darwin" (symbol-name system-type))
  (progn
    (set-frame-font "Menlo-11")))

(load-theme 'manoj-dark)
(set-face-attribute 'mode-line-buffer-id nil :background "black")
(set-face-font 'mode-line "Menlo-11")
(set-face-attribute 'region nil :background "#666" :foreground "#ffffff")


;; setting up the configs dir
(setq emacs-config-dir (file-name-directory
                        (or (buffer-file-name) load-file-name)))

(setq custom-file (concat emacs-config-dir "custom.el"))
;; (setq package-user-dir (concat emacs-config-dir "elpa"))
(setq abbrev-file-name (concat emacs-config-dir "abbrev_defs"))
(defconst *emacs-config-dir* (concat emacs-config-dir "/configs/" ""))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; configuration of packages

;; A function to load config files
(defun load-config-files (files)
  (dolist (f files)
    (load (expand-file-name
           (concat *emacs-config-dir* f)))
    (message "Loaded config file: %s" file)))

(load-config-files 
 '("defuns"
   "global"
   "init-auto-complete"
   "init-auctex"
   "init-erlang"
   "init-hippie-expand"

   "init-org-mode"
   "init-flymake"
   "init-elixir"

    "init-mu4e"
    "init-markdown"
    "init-adoc-mode"
    "init-tuareg"

;;                     "init-plantuml-mode"
;;                     "init-twelf"
;;                     "init-tags"
;;                     "init-semantic"

   ))



;; Get our custom configuration loaded
(load custom-file 'noerror)



;;; init.el ends here
(server-start)
