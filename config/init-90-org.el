
(require 'use-package)

; (use-package org-agenda
;    :ensure t)

(use-package org-pomodoro
   :ensure t)


;;; Code:
;; Some general settings
(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file "~/Dropbox/org/refile.org")
(defvar org-default-diary-file "~/Dropbox/org/diary.org")
(setq org-agenda-files (quote ("~/Dropbox/org")))

; (setq org-agenda-files (list "~/Dropbox/org/work.org"
;                              "~/Dropbox/org/school.org" 
;                              "~/Dropbox/org/home.org"))


;; Display properties
(setq org-cycle-separator-lines 0)
(setq org-tags-column 80)
(setq org-agenda-tags-column org-tags-column)
(setq org-agenda-sticky t)


