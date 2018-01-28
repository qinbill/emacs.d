;;; init.el --- Initialization code for emacs

;; Copyright (c) 2015 Gregory J Stein

;; Author: Gregory J Stein <gregory.j.stein@gmail.com>
;; Maintainer: Gregory J Stein <gregory.j.stein@gmail.com>
;; Created: 20 Aug 2015

;; Keywords: configuration
;; Homepage: https://github.com/gjstein/emacs.d

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;;; Commentary:
;; Calls my Emacs configuration files after installing use-package, which is
;; necessary for operation.  See also:
;;      http://www.cachestocaches.com/2015/8/getting-started-use-package/
;;
;; Code inspired by:
;;      http://stackoverflow.com/a/10093312/3672986
;;      http://www.lunaryorn.com/2015/01/06/my-emacs-configuration-with-use-package.html
;;      https://github.com/jwiegley/use-package

;;; Code:

;; User Info
(setq user-full-name "Jianbin Qin")
(setq user-mail-address "qinbill@gmail.com")

;; Install use-package if necessary
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives (append package-archives
			 '(("melpa" . "http://melpa.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ;; ("org" . "http://orgmode.org/elpa/")
			 ("elpy" . "http://jorgenschaefer.github.io/packages/"))))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Enable use-package
(eval-when-compile
  (require 'use-package))


(use-package diminish
  :ensure t)

(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

;; Increase garbage collection threshold to 500 MB to ease startup
;; (Don't do this for now!  It was causing my agenda mode to crawl)
;; (setq gc-cons-threshold (* 500 1024 1024))

;; Set the path variable
(use-package exec-path-from-shell
  :ensure t
  :config (exec-path-from-shell-initialize))

;; === Face Customization ===
(load-file "~/.emacs.d/config/init-10-face.el")

;; === Interface ===
(load-file "~/.emacs.d/config/init-20-nav-interface.el")

;; === Document Editing ===
(load-file "~/.emacs.d/config/init-30-doc-gen.el")
(load-file "~/.emacs.d/config/init-31-doc-org.el")

;; === Programming & Coding Functions ===
(load-file "~/.emacs.d/config/init-40-coding-gen.el")
(load-file "~/.emacs.d/config/init-41-coding-c-cpp.el")
(load-file "~/.emacs.d/config/init-42-coding-web.el")
(load-file "~/.emacs.d/config/init-43-coding-matlab.el")
(load-file "~/.emacs.d/config/init-44-coding-python.el")
(load-file "~/.emacs.d/config/init-45-coding-ROS.el")
(load-file "~/.emacs.d/config/init-46-coding-rust.el")

;; === misc ===
(load-file "~/.emacs.d/config/init-70-misc-ledger.el")

;; === mail ===
(load-file "~/.emacs.d/config/init-80-mail.el")

;; === Org ===
(load-file "~/.emacs.d/config/init-90-org.el")



(setq ispell-program-name "aspell")
(global-auto-revert-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#d6d6d6" "#c82829" "#718c00" "#eab700" "#4271ae" "#8959a8" "#3e999f" "#4d4d4c"))
 '(beacon-color "#c82829")
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(fci-rule-color "#d6d6d6")
 '(flycheck-c/c++-googlelint-executable "~/.emacs.d/scripts/cpplint.py")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(flycheck-google-cpplint-filter "-whitespace,+whitespace/braces")
 '(flycheck-google-cpplint-linelength "120")
 '(flycheck-google-cpplint-verbose "3")
 '(package-selected-packages
   (quote
    (org-pomodoro color-theme-sanityinc-tomorrow hc-zenburn-theme nzenburn-theme zenburn solarized-theme zenburn-theme yaml-mode ws-butler which-key web-mode use-package swiper-helm swift-mode spacemacs-theme spaceline rust-mode navigate monokai-theme matlab-mode markdown-mode ledger-mode helm-projectile helm-gtags helm-ag haskell-mode google-c-style general flycheck-rust exec-path-from-shell evil-vimish-fold evil-surround evil-snipe evil-magit emmet-mode elpy diminish deep-thought-theme company-irony color-theme-solarized color-theme-sanityinc-solarized color-theme-dg color-theme-cobalt cmake-mode base16-theme auctex ag)))
 '(safe-local-variable-values (quote ((Tex-PDF-mode . t))))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.staffmail.ed.ac.uk")
 '(smtpmail-smtp-service 587)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#c82829")
     (40 . "#f5871f")
     (60 . "#eab700")
     (80 . "#718c00")
     (100 . "#3e999f")
     (120 . "#4271ae")
     (140 . "#8959a8")
     (160 . "#c82829")
     (180 . "#f5871f")
     (200 . "#eab700")
     (220 . "#718c00")
     (240 . "#3e999f")
     (260 . "#4271ae")
     (280 . "#8959a8")
     (300 . "#c82829")
     (320 . "#f5871f")
     (340 . "#eab700")
     (360 . "#718c00"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
