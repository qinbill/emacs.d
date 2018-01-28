;;; init-70-misc-ledger.el --- Enable ledger-mode

;; Copyright (C) 2017 Gregory J Stein

;; Author: Gregory J Stein <gregory.j.stein@gmail.com>
;; Maintainer: Gregory J Stein <gregory.j.stein@gmail.com>
;; Created: 20 Aug 2015

;; Keywords: configuration, ledger
;; Homepage: https://github.com/gjstein/emacs.d
;; License: GNU General Public License (see init.el for details)

;;; Commentary:n
;; Ledger mode

;;; Code:

(require 'use-package)


(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")

(require 'mu4e)
(setq mu4e-maildir "~/.Mail")
(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder   "/[Gmail].Sent Mail")
;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)
;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; shortcuts
(setq mu4e-maildir-shortcuts
    '( ("/INBOX"               . ?i)
       ("/[Gmail].Sent Mail"   . ?s)))

;; something about ourselves
(setq
   user-mail-address "jqin@inf.ed.ac.uk"
   user-full-name  "Jianbin Qin"
   mu4e-compose-signature
    (concat
      "Regards,\n"
      "Jianbin Qin\n\n\n"
      "-- \n"
      "The University of Edinburgh is a charitable body, registered in\n"
      "Scotland, with registration number SC005336.\n"))

;; show images
(setq mu4e-show-images t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; convert html emails properly
;; Possible options:
;;   - html2text -utf8 -width 72
;;   - textutil -stdin -format html -convert txt -stdout
;;   - html2markdown | grep -v '&nbsp_place_holder;' (Requires html2text pypi)
;;   - w3m -dump -cols 80 -T text/html
;;   - view in browser (provided below)
(setq mu4e-html2text-command "textutil -stdin -format html -convert txt -stdout")

;; spell check
(add-hook 'mu4e-compose-mode-hook
        (defun my-do-compose-stuff ()
           "My settings for message composition."
           (set-fill-column 72)
           (flyspell-mode)))

;; add option to view html message in a browser
;; `aV` in view to activate
(add-to-list 'mu4e-view-actions
  '("ViewInBrowser" . mu4e-action-view-in-browser) t)

;; fetch mail every 10 mins
(setq mu4e-update-interval 600)

(custom-set-variables
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.staffmail.ed.ac.uk")
 '(smtpmail-smtp-service 587)
 '(weechat-color-list
   (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )





; ;; configuration for sending mail
; (setq message-send-mail-function 'smtpmail-send-it
;      smtpmail-stream-type 'starttls
;      smtpmail-default-smtp-server "smtp.staffmail.ed.ac.uk"
;      smtpmail-smtp-server "smtp.staffmail.ed.ac.uk"
;      smtpmail-smtp-service 465)




; (use-package ledger-mode
;   :ensure t
;   :defer t
;   :init
;   (add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

;   :config
;   (use-package flycheck-ledger
;     :ensure t
;     )

;   (general-define-key
;    :keymaps 'ledger-mode-map
;    :states '(normal motion)
;    :prefix (concat gjs-leader-key "c")
;    "r" 'ledger-report
;    "R" 'ledger-report-redo
;    )

;   (evil-set-initial-state 'ledger-report-mode 'motion)
;   (general-define-key
;    :keymaps 'ledger-report-mode-map
;    :states '(normal motion)
;    "q" 'ledger-report-quit
;    "e" 'ledger-report-edit-report
;    "r" 'ledger-report-redo
;    )
;   )
