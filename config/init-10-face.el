;;; init-10-face.el --- Customize the look of emacs

;; Copyright (C) 2017 Gregory J Stein

;; Author: Gregory J Stein <gregory.j.stein@gmail.com>
;; Maintainer: Gregory J Stein <gregory.j.stein@gmail.com>
;; Created: 20 Aug 2015

;; Keywords: configuration, zenburn
;; Homepage: https://github.com/gjstein/emacs.d
;; License: GNU General Public License (see init.el for details)

;;; Commentary:
;; Zenburn theme; default font is set to 'monaco'

;;; Code:
(require 'use-package)

;; Splash Screen to Org-mode
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'markdown-mode)

;; == Load Custom Theme ==

; ;;; Cyberpunk
; (use-package monokai-theme
;   :ensure t
;   :config
;   (setq monokai-height-minus-1 1.0
; 	monokai-height-plus-1 1.0
; 	monokai-height-plus-2 1.0
; 	monokai-height-plus-3 1.0
; 	monokai-height-plus-4 1.0
;   )
;   (load-theme 'monokai t)
; ;;  (add-hook 'after-make-frame-functions
; ;;	    (lambda (frame)
; ;;	      (if (display-graphic-p)
; ;;		  nil
; ;;		(load-theme 'monokai))))
;   )

(set-face-attribute 'default nil :height 180)


(defvar zenburn-override-colors-alist
  '(("zenburn-bg+05" . "#181818")
    ("zenburn-bg+1"  . "#1F1F1F")
    ("zenburn-bg+2"  . "#2F2F2F")
    ("zenburn-bg+3"  . "#3F3F3F")))

(use-package zenburn-theme 
  :ensure t
  )

;;(use-package hc-zenburn-theme :ensure t)




; ; Solarized
; ; (use-package color-theme :ensure t)
; (use-package solarized-theme
;   :ensure t
;   :init
;   (set-frame-parameter nil 'background-mode 'dark)

;   ;; make the fringe stand out from the background
;   (setq solarized-distinct-fringe-background t)

;   ;; Don't change the font for some headings and titles
;   (setq solarized-use-variable-pitch nil)

;   ;; make the modeline high contrast
;   (setq solarized-high-contrast-mode-line t)

;   ;; Use less bolding
;   (setq solarized-use-less-bold t)

;   ;; Use more italics
;   (setq solarized-use-more-italic t)

;   ;; Use less colors for indicators such as git:gutter, flycheck and similar
;   (setq solarized-emphasize-indicators nil)

;   ;; Don't change size of org-mode headlines (but keep other size-changes)
;   (setq solarized-scale-org-headlines nil)

;   ;; Avoid all font-size changes
;   (setq solarized-height-minus-1 1.0)
;   (setq solarized-height-plus-1 1.0)
;   (setq solarized-height-plus-2 1.0)
;   (setq solarized-height-plus-3 1.0)
;   (setq solarized-height-plus-4 1.0)
;   )

; I prefer using a smaller font size than the default (and 'Monaco')
; (if (eq system-type 'darwin)
;     (custom-set-faces '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 200 :width normal :foundry "nil" :family "Iosevka Light")))))
;   (custom-set-faces '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 220 :width normal :foundry "nil" :family "Ubuntu Mono"))))))


;; Set default fill column
(setq-default fill-column 80)

;; quiet, please! No dinging!
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; Disable menu bars, etc.
(if window-system (scroll-bar-mode -1))
(tool-bar-mode -1)
(menu-bar-mode -1)

;; No Backup Files
(setq make-backup-files nil)

;; initial window
(setq initial-frame-alist
      '((width . 172)   ; characters in a line
        (height . 55))) ; number of lines

;; sebsequent frame
(setq default-frame-alist
      '((width . 170)   ; characters in a line
        (height . 55))) ; number of lines

;; Diminish extraneous info in the modeline
(diminish 'abbrev-mode)
(defun sk/diminish-auto-revert ()
  "Diminishes the 'auto-revert-mode' in the mode line."
  (interactive)
  (diminish 'auto-revert-mode ""))
(add-hook 'auto-revert-mode-hook 'sk/diminish-auto-revert)

;;; Customize the modeline
(setq line-number-mode 1)
(setq column-number-mode 1)
(setq ns-use-srgb-colorspace nil)
(use-package spaceline-config
  :ensure spaceline
  :config
  ;; Set some parameters of the spaceline
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  (setq powerline-default-separator 'bar)

  ;; Define a better buffer position line
  (spaceline-define-segment gjstein-buffer-position
    "a better buffer position display"
    (let ((buffer-position (format-mode-line "%p")))
      (if (string= buffer-position "Top") "top"
	(if (string= buffer-position "Bottom") "bot"
	  (if (string= buffer-position "All") "all"
	    "%p")))
      )
    )

  ;; Removes the " Git:" from the 'version-control' segment.
  (spaceline-define-segment gjstein-version-control
    "Version control information."
    (when vc-mode
      (powerline-raw
       (s-trim (concat
		(let ((backend (symbol-name (vc-backend (buffer-file-name)))))
		  (substring vc-mode (+ (length backend) 2)))
		(when (buffer-file-name)
		  (pcase (vc-state (buffer-file-name))
		    (`up-to-date " ")
		    (`edited "*")
		    (`added "@")
		    (`unregistered "?")
		    (`removed "-")
		    (`needs-merge " Con")
		    (`needs-update " Upd")
		    (`ignored "!")
		    (_ " Unk"))))))))

  ;; Makes a shorter org-clock string.
  (defun gjstein-org-clock-get-clock-string ()
    "Makes a clock string for org."
    (let ((clocked-time (org-clock-get-clocked-time)))
      (if org-clock-effort
	  (let* ((effort-in-minutes
		  (org-duration-string-to-minutes org-clock-effort))
		 (work-done-str
		  (propertize
		   (org-minutes-to-clocksum-string clocked-time)
		   'face (if (and org-clock-task-overrun (not org-clock-task-overrun-text))
			     'org-mode-line-clock-overrun 'org-mode-line-clock)))
		 (effort-str (org-minutes-to-clocksum-string effort-in-minutes))
		 (clockstr (propertize
			    (concat  "%s/" effort-str
				     " " (replace-regexp-in-string "%" "%%" org-clock-heading))
			    'face 'org-mode-line-clock)))
	    (format clockstr work-done-str))
	(propertize (concat (org-minutes-to-clocksum-string clocked-time)
			    (format " %s" org-clock-heading))
		    'face 'org-mode-line-clock))))
  (setq spaceline-org-clock-format-function 'gjstein-org-clock-get-clock-string)

  (spaceline-compile
   'gjstein
   ;; Left side of the mode line (all the important stuff)
   '(((buffer-modified buffer-size input-method) :face highlight-face)
     '(buffer-id remote-host major-mode)
     ((point-position line-column gjstein-buffer-position) :separator "|" )
     process
     ((flycheck-error flycheck-warning flycheck-info) :separator "" :when active)
     ((which-function projectile-root (gjstein-version-control :when active)) :separator ":")
     )
   ;; Right segment (the unimportant stuff)
   '((org-clock)
     ((minor-modes :separator " ") :when active)
     (mu4e-alert-segment)))

  (spaceline-helm-mode)
  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-gjstein)))))

(use-package powerline
  :ensure t
  :after spaceline-config
  :config
  (setq
   powerline-height (truncate (* 1.0 (frame-char-height)))
   powerline-default-separator 'utf-8)
  )

(defmacro rename-major-mode (package-name mode new-name)
  "Renames a major mode."
 `(eval-after-load ,package-name
   '(defadvice ,mode (after rename-modeline activate)
      (setq mode-name ,new-name))))
(rename-major-mode "python" python-mode "π")
(rename-major-mode "markdown-mode" markdown-mode "Md")
(rename-major-mode "shell" shell-mode "σ")
(rename-major-mode "org" org-mode "ω")
(rename-major-mode "Web" web-mode "w")

(add-hook 'web-mode-hook (lambda() (setq mode-name "w")))
(add-hook 'emacs-lisp-mode-hook (lambda() (setq mode-name "ελ")))

;;; init-10-face.el ends here
