;;(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))


;;(require 'org-mac-link)
(setq org-default-notes-file "~/org/notes.org")
(setq org-capture-templates
      '(("t" "Task" entry (file+headline "~/org/notes.org" "Tasks")
         "* TODO %?\n  %i\n  %a")))

(setq org-clock-persist 'history)
;; (org-clock-persistence-insinuate)
(setq org-log-done 'time)

(setq org-duration-format 'h:mm)

(setq org-startup-indented 'indented)

(setq org-todo-keywords
      '((sequence "TODO(t)" "WIP(p)" "WAIT(w)" "|" "DONE(d)" "CANCELED(c)")))

;; (add-hook 'org-mode-hook 'my-org-mode-autosave-settings)
;; (defun my-org-mode-autosave-settings () "Customisation of org-mode autosave"
;;   ;; (auto-save-mode 1)   ; this is unecessary as it is on by default
;;   (set (make-local-variable 'auto-save-visited-file-name) t)
;;   (setq auto-save-interval 20))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key (kbd "s-<f9>") 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;(add-hook 'org-mode-hook (lambda () 
;;  (define-key org-mode-map (kbd "C-c C-g") 'org-mac-grab-link)))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/refile.org" "Tasks")
             "* TODO %?\n  %i\n  %a")))

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))

(setq org-agenda-files (quote ("~/org")))
(setq org-clock-in-resume t)
(setq org-clock-persist t)
(setq org-clock-report-include-clocking-task t):
(setq org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m)))
(setq org-support-shift-select t)

;;; from
;;; https://stackoverflow.com/questions/11384516/how-to-make-all-org-files-under-a-folder-added-in-agenda-list-automatically

;; recursively find .org files in provided directory
;; modified from an Emacs Lisp Intro example
(defun sa-find-org-file-recursively (&optional directory filext)
  "Return .org and .org_archive files recursively from DIRECTORY.
If FILEXT is provided, return files with extension FILEXT instead."
  (interactive "DDirectory: ")
  (let* (org-file-list
	 (case-fold-search t)	      ; filesystems are case sensitive
	 (file-name-regex "^[^.#].*") ; exclude dot, autosave, and backup files
	 (filext (or filext "org$\\\|org_archive"))
	 (fileregex (format "%s\\.\\(%s$\\)" file-name-regex filext))
	 (cur-dir-list (directory-files directory t file-name-regex)))
    ;; loop over directory listing
    (dolist (file-or-dir cur-dir-list org-file-list) ; returns org-file-list
      (cond
       ((file-regular-p file-or-dir) ; regular files
	(if (string-match fileregex file-or-dir) ; org files
	    (add-to-list 'org-file-list file-or-dir)))
       ((file-directory-p file-or-dir)
	(dolist (org-file (sa-find-org-file-recursively file-or-dir filext)
			  org-file-list) ; add files found to result
	  (add-to-list 'org-file-list org-file)))))))


(setq org-agenda-text-search-extra-files
      (append (sa-find-org-file-recursively "~/org/" "org_archive")))


(setq org-time-clocksum-format
'(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

;;; hack to get rid of sub-tree but keep node.
(defun lehoff/org-archive-subtree-keep-node ()
  (interactive)
  (setq node-text (thing-at-point 'line))
  (org-archive-subtree)
  (insert-string node-text))

;;;(global-set-key (kbd "<f8>") 'lehoff/org-archive-subtree-keep-node)
;;; (global-set-key (kbd "C-<f8>") 'org-archive-subtree)
(global-set-key (kbd "<f9>") 'org-agenda)
(global-set-key (kbd "<f10>") 'org-search-view)
(global-set-key (kbd "<f7>") 'org-save-all-org-buffers)
(global-set-key (kbd "<f5>") 'org-clock-in)
(global-set-key (kbd "<f6>") 'org-clock-out)


;;; MobileOrg set-up
;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/refile.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")


 (setq org-clock-into-drawer "LOGBOOK")
 (setq org-log-into-drawer "NOTES")
