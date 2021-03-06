

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")



;;; taken from http://www.djcbsoftware.nl/code/mu/mu4e/Longer-configuration.html#Longer-configuration
;; example configuration for mu4e
(require 'mu4e)
(require 'org-mu4e)

;; path to our Maildir directory
(setq mu4e-maildir "~/Maildir")

;; the next are relative to `mu4e-maildir'
;; instead of strings, they can be functions too, see
;; their docstring or the chapter 'Dynamic folders'
(setq mu4e-sent-folder   "/[Gmail].Sent Mail"
      mu4e-drafts-folder "/[Gmail].Drafts"
      mu4e-trash-folder  "/[Gmail].Trash"
      mu4e-refile-folder "/[Gmail].All Mail")

;; the maildirs you use frequently; access them with 'j' ('jump')
(setq   mu4e-maildir-shortcuts
        '(("/[Gmail].All Mail"    . ?a)
          ("/INBOX"       . ?i)
          ("/[Gmail].Sent Mail"        . ?s)
          ))

;; a  list of user's e-mail addresses
(setq mu4e-user-mail-address-list '("torben.hoffmann@erlang-solutions.com"
                                    "torben@erlang-solutions.com"))

;; how to get mail
(setq
 mu4e-get-mail-command "offlineimap"   ;; or fetchmail, or ...
 mu4e-update-interval 300)             ;; update every 5 minutes

;; when you want to use some external command for text->html
;; conversion, e.g. the 'html2text' program
;; (setq mu4e-html2text-command "html2text")

;; the headers to show in the headers list -- a pair of a field
;; and its width, with `nil' meaning 'unlimited'
;; better only use that for the last field.
;; These are the defaults:
(setq mu4e-headers-fields
      '( (:date          .  18)
         (:flags         .   6)
         (:from          .  22)
         (:subject       .  nil)))

;; program to get mail; alternatives are 'fetchmail', 'getmail'
;; isync or your own shellscript. called when 'U' is pressed in
;; main view.

;; If you get your mail without an explicit command,
;; use "true" for the command (this is the default)
(setq mu4e-get-mail-command "offlineimap")

;; general emacs mail settings; used when composing e-mail
;; the non-mu4e-* stuff is inherited from emacs/message-mode
(setq mu4e-reply-to-address "torben.hoffmann@erlang-solutions.com"
      user-mail-address "torben.hoffmann@erlang-solutions.com"
      user-full-name  "Torben Hoffmann")
(setq mu4e-user-mail-address-regexp
      "torben@erlang-solutions\.com\\|torben.hoffmann@erlang-soultions\.com")
(setq mu4e-org-contacts-file  "~/org/contacts.org")
(add-to-list 'mu4e-headers-actions
             '("org-contact-add" . mu4e-action-add-org-contact) t)
(add-to-list 'mu4e-view-actions
             '("org-contact-add" . mu4e-action-add-org-contact) t)

(setq mu4e-compose-signature (with-temp-buffer
                               (insert-file-contents "~/.signature")
                               (buffer-string)))

(setq message-signature-file "~/.signature")

(setq gnutls-min-prime-bits 1024)

(load "tls")
;; smtp mail setting
(require 'smtpmail)
(setq
 message-send-mail-function 'smtpmail-send-it
 ;; starttls-use-gnutls t
 ;; starttls-gnutls-program "/usr/local/bin/gnutls-bin"
 ;; starttls-extra-arguments "--insecure"      

 ;; smtpmail-gnutls-credentials
 ;; '(("mail.erlang-solutions.com" 587 nil nil))
 ;; smtpmail-starttls-credentials 
 ;; '(("mail.erlang-solutions.com" 587 nil nil))

 ;;  smtpmail-gnutls-credentials
 ;; '(("smtp.gmail.com" 587 nil nil))
 ;; smtpmail-starttls-credentials 
 ;; '(("smtp.gmail.com" 587 nil nil))

 
 ;; alternative from http://www.djcbsoftware.nl/code/mu/mu4e/Gmail-configuration.html
 ;; smtpmail-starttls-credentials 
 ;; '(("mail.erlang-solutions.com" 587 nil nil))
 ;; smtpmail-stream-type 'ssl;;'starttls ;;'ssl 

 ;; new one inspired by http://stackoverflow.com/questions/16763033/wanderlust-osx-emacs-smtp-certification-failed
 ;; starttls-use-gnutls t
 ;; starttls-gnutls-program "/usr/bin/openssl"
 ;; starttls-extra-arguments "s_client -ssl2 -connect %s:%p"
 
;; smtpmail-default-smtp-server "mail.erlang-solutions.com"
 ;; smtpmail-smtp-server "mail.erlang-solutions.com"
 ;; smtpmail-local-domain "erlang-solutions.com"

 smtpmail-stream-type 'starttls
 smtpmail-default-smtp-server "smtp.gmail.com"
 smtpmail-smtp-server "smtp.gmail.com"
 smtpmail-smtp-service 587

 
;; smtpmail-stream-type 'starttls
 ;; smtpmail-default-smtp-server "smtp.gmail.com"
 ;; smtpmail-smtp-server "smtp.gmail.com"

; smtpmail-smtp-service 25
;;  smtpmail-smtp-service 993
 smtpmail-debug-info t
 ;; if you need offline mode, set these -- and create the queue dir
 ;; with 'mu mkdir', i.e.. mu mkdir /home/user/Maildir/queue
 smtpmail-queue-mail  t
 smtpmail-queue-dir  "/Users/th/Maildir/queue/cur")

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(setq
;; mu4e-use-fancy-chars t
;; mu4e-view-prefer-html t
 org-mu4e-convert-to-html t
 mu4e-show-images t
 message-kill-buffer-on-exit t
 mu4e-headers-include-related nil
 mu4e-headers-skip-duplicates t
 mu4e-headers-visible-lines 18)

;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(setq mu4e-headers-date-format "%Y-%m-%d %H.%M")

;; from https://github.com/fgallina/dotemacs/blob/master/init.el
(defun my:mu4e-toggle-headers-include-related ()
      "Toggle `mu4e-headers-include-related' and refresh."
      (interactive)
      (setq mu4e-headers-include-related
            (not mu4e-headers-include-related))
      (mu4e-headers-rerun-search))

(define-key 'mu4e-headers-mode-map "o"
  'my:mu4e-toggle-headers-include-related)



;; view in browser with aV
(add-to-list 'mu4e-view-actions
             '("ViewInBrowser" . mu4e-action-view-in-browser) t)

;; use imagemagick if available
(when (fboundp 'imagemagick-register-types)
        (imagemagick-register-types))

(setq mu4e-html2text-command "html2text -utf8 -nobs -width 100")


;; automatic refiling from http://www.djcbsoftware.nl/code/mu/mu4e/Refiling-message.html

;; bookmarks for easy access
(setq mu4e-bookmarks
      '( ("flag:unread AND NOT flag:trashed"     "Unread messages"      ?u)
         ("maildir:/INBOX" "INBOX" ?i)
         ("maildir:/INBOX and not flag:list" "INBOX-me" ?j)
         ("maildir:/INBOX and flag:replied" "Filable" ?f)
         ("date:today..now and maildir:/INBOX" "Today's messages"     ?t)
         ("maildir:/INBOX and date:7d..now"      "Last 7 days"          ?w)
         ("maildir:/INBOX and date:31d..now"    "Last month"          ?m)
         ("maildir:/erlang-questions" "erlang-questions" ?e)
         ("mime:image/*"                         "Messages with images" ?p)
         ("(maildir:/ActivityStream or maildir:/INBOX or maildir:/Redmine) and from:redmine@erlang-solutions.com"
          "Redmine"              ?r)
         ("(maildir:/ActivityStream or maildir:/INBOX or maildir:/Github)  and from:github.com" "Github"               ?g)
         ("maildir:/ActivityStream and (not from:github.com) and (not from:redmine@erlang-solutions.com)" "Later"  ?l)
         ("(maildir:/INBOX or maildir:/ActivityStream) and (from:alarm@erlang-solutions.com or from:nagios@monitoring.erlang-solutions.com  or from:graylog@erlang-solutions.com)"
          "Alarms" ?a)
         ))



;; printing via mutt
;; https://groups.google.com/forum/#!searchin/mu-discuss/print/mu-discuss/WQdwVSluj3w/84jzXGL4AP4J
(add-to-list 'mu4e-view-actions
  `("Muttprint" .
     ,(defun mu4e-action-muttprint (msg)
        "Print the message using muttprint."
        (mu4e-view-pipe "muttprint -p Virtual_PDF_Printer")))) 

;; compose hook from manual §6.4
(add-hook 'mu4e-compose-mode-hook
          (defun my-do-compose-stuff ()
            "My settings for message composition."
            (set-fill-column 85)
            (flyspell-mode)))

;; em


;; mailto-compose-mail
;; from http://www.emacswiki.org/emacs/MailtoHandler
(defun mailto-compose-mail (mailto-url)
  "Parse MAILTO-URL and start composing mail."
  (if (and (stringp mailto-url)
           (string-match "\\`mailto:" mailto-url))
      (progn
        (require 'rfc2368)
        (require 'rfc2047)
        (require 'mailheader)

        (let ((hdr-alist (rfc2368-parse-mailto-url mailto-url))
              (body "")
              to subject
              ;; In addition to To, Subject and Body these headers are
              ;; allowed:
              (allowed-xtra-hdrs '(cc bcc in-reply-to)))

          (with-temp-buffer
            ;; Extract body if it's defined
            (when (assoc "Body" hdr-alist)
              (dolist (hdr hdr-alist)
                (when (equal "Body" (car hdr))
                  (insert (format "%s\n" (cdr hdr)))))
              (rfc2047-decode-region (point-min) (point-max))
              (setq body (buffer-substring-no-properties
                          (point-min) (point-max)))
              (erase-buffer))

            ;; Extract headers
            (dolist (hdr hdr-alist)
              (unless (equal "Body" (car hdr))
                (insert (format "%s: %s\n" (car hdr) (cdr hdr)))))
            (rfc2047-decode-region (point-min) (point-max))
            (goto-char (point-min))
            (setq hdr-alist (mail-header-extract-no-properties)))

          (setq to (or (cdr (assq 'to hdr-alist)) "")
                subject (or (cdr (assq 'subject hdr-alist)) "")
                hdr-alist
                (remove nil (mapcar
                             #'(lambda (item)
                                 (when (memq (car item) allowed-xtra-hdrs)
                                   (cons (capitalize (symbol-name (car item)))
                                         (cdr item))))
                             hdr-alist)))

          (compose-mail to subject hdr-alist nil nil
                        (list (lambda (string)
                                (insert string))
                              body))))
    (compose-mail)))

























