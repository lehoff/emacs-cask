
(require 'notmuch)

(require 'org-notmuch)

(defun lehoff/notmuch-trash (&optional beg end)
  "trash by removing inbox and adding trash"
  (interactive (notmuch-search-interactive-region))
  (notmuch-search-tag (list "-inbox" "+trash") beg end)
  (when (eq beg end)
    (notmuch-search-next-thread)))

(defun lehoff/notmuch-trash-show ()
  "trash shown msg by removing inbox and adding trash"
  (interactive)
  (notmuch-show-add-tag (list "-inbox" "+trash"))
  (unless (notmuch-show-next-open-message)
    (notmuch-show-next-thread t)))

(defun lehoff/notmuch-show-trash-thread-then-next ()
  "trash current thread by removing inbox and adding trash"
  (interactive)
  (lehoff/notmuch-show-trash-thread)
  (notmuch-show-next-thread t))

(defun lehoff/notmuch-show-trash-thread (&optional unarchive)
  "Trash each message in thread.

   For current thread remove \"inbox\" and add \"trash\".
   If a prefix argument is given the opposite operation will be done.

   Code structure based on notmuch-show-archive-thread."
  (interactive "P")
  (let ((op-inbox (if unarchive "+" "-"))
        (op-trash (if unarchive "-" "+")))
         (notmuch-show-tag-all (concat op-inbox "inbox"))
         (notmuch-show-tag-all (concat op-trash "trash"))))
  

(defun lehoff/compose-mail-other-frame ()
  "create a new frame for the mail composition"
  (compose-mail-other-frame))

(setq notmuch-address-command "~/bin/nottoomuch-addresses.sh")

(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "~/bin/msmtp-enqueue.sh")
(setq message-sendmail-extra-arguments '("-a" "Basho"))
(setq mail-host-address "@basho.com")
(setq user-full-name "Torben Hoffmann")
(setq user-mail-address "thoffmann@basho.com")
(setq message-sendmail-f-is-evil 't)


;; from https://github.com/fgeller/emacs.d/blob/master/email.org
(add-hook 'notmuch-show-hook 'notmuch-show-prefer-html-over-text)
(defun notmuch-show-prefer-html-over-text ()
  (interactive)
  (let* ((text-button (save-excursion
                        (goto-char (point-min))
                        (search-forward "[ text/plain ]" (point-max) t)))
         (html-button (save-excursion
                        (goto-char (point-min))
                        (search-forward "[ text/html (hidden) ]" (point-max) t))))
    (when html-button
      (save-excursion
        (goto-char (- html-button 1))
        (notmuch-show-toggle-part-invisibility)))
    (when text-button
      (save-excursion
        (goto-char (- text-button 1))
        (notmuch-show-toggle-part-invisibility)))))


(define-key notmuch-show-mode-map "\C-t"
  (lambda ()
    (interactive)
    (lehoff/notmuch-trash-show)))

(define-key notmuch-search-mode-map "T"
    'lehoff/notmuch-trash)

(define-key notmuch-show-mode-map "T"
  'lehoff/notmuch-show-trash-thread-then-next)

(setq notmuch-search-oldest-first nil)

;;; saved searches
(setq notmuch-saved-searches '((:name "inbox"
                                      :query "tag:inbox and not (github notifications) and not to:thoffmann"
                                      :key "i") 
                               (:name "mymail" :query "(to:thoffmann or to:eng-arch) and tag:inbox" :key "m")
                               (:name "Erlang"
                                      :key "e"
                                      :query "erlang-questions@erlang.org and tag:inbox")
                               (:name "github"
                                      :query "github notifications tag:inbox not rfc@noreply.github.com"
                                      :key "g")
                               (:name "Jira"
                                      :key "j"
                                      :query "tag:inbox and from:jira@bashoeng.atlassian.net")
                               (:name "inbox"
                                      :query "tag:inbox not tag:sent and not (github notifications) and not to:thoffmann"
                                      :key "i") 
                               (:name "unread" :query "tag:unread AND tag:inbox " :key "u")
                               (:name "flagged" :query "tag:flagged" :key "f")
                               (:name "sent"
                                      :query "from:thoffmann@basho.com" :key "s")
                               (:name "drafts"
                                      :query "tag:drafts" :key "d")
                               (:name "all mail"
                                      :query "*" :key "a")
                               (:name "SyncFree"
                                      :query "SF-Tech tag:inbox" :key "S")
                               (:name "rfc"
                                      :query "tag:inbox basho/rfc rfc@noreply.github.com" :key "r")
                               ))

;;;'(notmuch-search-unread-face ((t (:background "dark cyan" :foreground "white")))) 
(setq notmuch-search-line-faces '(("unread"  :weight "bold" :background "blue")
                                  ("flagged" :background "purple")
                                  ("trash" :strike-through t)
                                  ))

(setq notmuch-tag-formats
   (quote
    (("unread"
      (propertize tag
                  (quote face)
                  (quote
                   (:foreground "red"))))
     ("flagged"
      (notmuch-tag-format-image-data tag
                                     (notmuch-tag-star-icon))
      (propertize tag
                  (quote face)
                  (quote
                   (:foreground "blue")))))))

;(setq hl-line `(t (:background "deep pink")))
(set-face-attribute 'hl-line nil :background "DarkGoldenrod4")
