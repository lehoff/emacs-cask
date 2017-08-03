
;; based on https://github.com/rdallasgray/pallet


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask "/usr/local/Cellar/cask/0.7.4/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; from old init.el

;; EQC Emacs Mode -- Configuration Start
(add-to-list 'load-path "/Users/th/Library/Erlang/lib/eqc-1.33.3/emacs/")
(autoload 'eqc-erlang-mode-hook "eqc-ext" "EQC Mode" t)
(add-hook 'erlang-mode-hook 'eqc-erlang-mode-hook)
(setq eqc-max-menu-length 30)
(setq eqc-root-dir "/Users/th/Library/Erlang/lib/eqc-1.33.3")
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


;(setq mac-control-modifier 'ctrl)      



;; keyboard shortcuts
(global-set-key [s-left] 'beginning-of-line)
(global-set-key [s-right] 'end-of-line)
(global-set-key [s-up] 'beginning-of-buffer)
(global-set-key [s-down] 'end-of-buffer)
(global-set-key [M-right] 'forward-word)
(global-set-key [M-left] 'backward-word)

(global-set-key [f4] 'notmuch-jump-search)
(global-set-key [f5] 'notmuch)
(global-set-key [f8] 'desktop+-load)
                

(global-visual-line-mode 1)
(delete-selection-mode 1)

;; helm
(helm-mode 1)
(global-set-key (kbd "M-o") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-mini) ; override iswitchb
(global-set-key (kbd "C-o") 'helm-projectile)
(global-set-key (kbd "C-x b") 'helm-mini)   ;
(helm-autoresize-mode)


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
                        '("Inconsolata" . "iso10646-1"))
      (set-frame-font "Inconsolata-13")
      (set-frame-size (selected-frame) 120 65)))



(add-hook 'before-make-frame-hook
      #'(lambda ()
          (add-to-list 'default-frame-alist '(left   . 0))
          (add-to-list 'default-frame-alist '(top    . 0))
          (add-to-list 'default-frame-alist '(height . 60))
          (add-to-list 'default-frame-alist '(width  . 120))))

;; from http://stackoverflow.com/questions/92971/how-do-i-set-the-size-of-emacs-window
(setq default-frame-alist
      '((top . 20) (left . 200)
        (width . 120) (height . 60)
        (font . "Inconsolata-13")))
        

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
    (set-frame-font "Inconsolata-13")))

(load-theme 'hc-zenburn)
(set-face-attribute 'mode-line-buffer-id nil :background "black")
(set-face-font 'mode-line "Inconsolata-13")
(set-face-attribute 'region nil :background "#666" :foreground "#ffffff")


;; setting up the configs dir
(setq emacs-config-dir (file-name-directory
                        (or (buffer-file-name) load-file-name)))

(setq custom-file (concat emacs-config-dir "custom.el"))
;; (setq package-user-dir (concat emacs-config-dir "elpa"))
(setq abbrev-file-name (concat emacs-config-dir "abbrev_defs"))
(defconst *emacs-config-dir* (concat emacs-config-dir "/configs/" ""))

;; EQC Emacs Mode -- Configuration Start
(add-to-list 'load-path "/usr/local/lib/erlang/lib/eqc-1.38.3/emacs/")
(autoload 'eqc-erlang-mode-hook "eqc-ext" "EQC Mode" t)
(add-hook 'erlang-mode-hook 'eqc-erlang-mode-hook)
(setq eqc-max-menu-length 30)
(setq eqc-root-dir "/usr/local/lib/erlang/lib/eqc-1.38.3")


;;; colour customisation
;(set-face-attribute 'markup-meta-face nil :foreground "PaleVioletRed1"
;       :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant
;       'normal :weight 'normal :height 90 :width 'normal  :family "Monospace")
;(set-face-attribute 'markup-meta-hide-face nil :inherit markup-meta-face :foreground "dark magenta" :height 1)
;(set-face-attribute 'markup-attribute-face nil :foreground 'PaleVioletRed1 :height 1)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; configuration of packages

;; A function to load config files
(defun load-config-files (files)
  (dolist (f files)
    (load (expand-file-name
           (concat *emacs-config-dir* f)))
    (message "Loaded config file: %s" f)))

(load-config-files 
 '("defuns"
   "global"
   "init-elscreen"
   "init-desktop-plus"
   "init-bookmark-plus"
   "init-auto-complete"
   "init-auctex"
   "init-erlang"
   "init-hippie-expand"
;;;   "init-flycheck"
   
   "init-projectile"
   "init-org-mode"
   "init-flymake"
   "init-elixir"

   "init-notmuch"
;;    "init-mu4e"
    "init-markdown"
    "init-adoc-mode"
    "init-ack"
;;    "init-tuareg"

;;    "init-plantuml-mode"
;;                     "init-twelf"
;;                     "init-tags"
;;                     "init-semantic"

   ))



;; Get our custom configuration loaded
(load custom-file 'noerror)

(when (eq system-type 'darwin)
 (exec-path-from-shell-initialize))

;;; init.el ends here
(server-start)
