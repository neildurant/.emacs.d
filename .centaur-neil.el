;;; .centaur-neil.el --- A test file.                         -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;;; BOOTSTRAP USE-PACKAGE
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

(use-package undo-fu)

(use-package swiper)

(use-package back-button
  :config
  (back-button-mode 1))

;;; Vim Bindings
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  ;; (setq evil-undo-function 'undo)
  :config
  (evil-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

(use-package all-the-icons
  :if (display-graphic-p))

;;;; Functions
(defun neil/evil-search-word-forward-without-jump () "Search forward for a word without jumping."
       (interactive)
       (save-excursion
         (evil-search-word-forward)))

(defun neil/evil-search-word-backward-without-jump () "Search backwards for a word without jumping."
       (interactive)
       (save-excursion
         (evil-search-word-backward)))

(defun what-mode() "Display the current major mode"
       (interactive)
       (message "%s" major-mode))

(defun what-face (pos) "Display the face at the point. POS specifies the position, for reporting purposes only."
       (interactive "d")
       (let ((face (or (get-char-property (point) 'read-face-name)
                       (get-char-property (point) 'face))))
         (if face
             (message "Face: %s" face)
           (message "No face at %d" pos))))

;; General
(global-set-key (kbd "C-`") 'evil-window-next)

;;; Modes
(hl-line-mode -1)

;; Tabs
(global-set-key (kbd "C-<prior>") 'tab-previous)
(global-set-key (kbd "C-<next>") 'tab-next)

;; Bookmarks
;;(global-set-key (kbd "<f2>") 'bm-next)
;;(global-set-key (kbd "S-<f2>") 'bm-previous)
;;(global-set-key (kbd "C-<f2>") 'bm-toggle)
;;(global-set-key (kbd "M-<f2>") 'helm-bm)

;; Dired
;; (define-key dired-mode-map (kbd "C-/") 'dired-narrow)
;; (define-key dired-mode-map (kbd "M-/") 'revert-buffer)

;; Search/highlight
                                        ;(evil-define-key 'normal 'global "*" 'neil/evil-search-word-forward-without-jump)
                                        ;(evil-define-key 'normal 'global "#" 'neil/evil-search-word-backward-without-jump)

(setq evil-search-module 'evil-search)

;; Spacemacs leader extensions
;;(evil-leader/set-key
;;
;;  ;; SPC-fd: File
;;  "f d" 'dired
;;
;;  ;; SPC-pB: Projectile
;;  "p B" 'helm-browse-project
;;
;;  ;; SPC-bi: IBuffer
;;  "b i" 'ibuffer)

;;Ido mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-use-filename-at-point 'guess)
(ido-mode 1)

(setq
 ;; General
 ;; frame-resize-pixelwise t

 ;; Tabs/indenting
 tab-width 4
 indent-tabs-mode nil                         ; Spaces instead of tabs
 tab-always-indent 'complete                  ; First indent, then complete

 ;;  Highlighting
 ;; highlight-nonselected-windows t              ; Highlight region even in nonselected windows

 ;; Debug
 debug-on-error nil
 debug-on-quit nil

 ;; Scrolling
 scroll-conservatively 0                      ; Always centre the point if it goes off screen

 ;; Windows-specific
 ;; w32-apps-modifier 'hyper                      ; Menu/App key as Hyper
 ;; w32-pass-rwindow-to-system nil
 ;; w32-rwindow-modifier 'hyper

 ;; Diff
 ;; ediff-window-setup-function 'ediff-setup-windows-plain ; Keep the ediff control window in the same frame
 ;; ediff-split-window-function 'split-window-horizontally ; Split side-by-side by default

 ;; Projectile
 ;; projectile-switch-project-action 'helm-projectile
 ;; projectile-enable-caching t

 ;; Identification
 user-full-name "Neil Durant"
 user-mail-address "ndurant@inmusicbrands.com"

 ;; Misc
 vc-handled-backends '(Git)
 echo-keystrokes 0.1                      ; Echo commands faster than the default 1s
 fill-column 120                          ; Wrap/fill at column 120
 indicate-buffer-boundaries 'right        ; Show buffer boundaries in right fringe
 comment-empty-lines t                    ; Comments appear on empty lines too
 large-file-warning-threshold 100000000   ; Only warn for files over 100Mb
 ;; python-indent-offset 4                   ; Python indents 2 spaces
 blink-matching-paren t                   ; Blink the matching parenthesis
 global-auto-revert-mode t                ; Automatically revert on external changes
 blink-cursor-mode t

 ;; Tab-bar
 tab-bar-mode t
 tab-bar-show t

 ;; Bookmarks
 ;; bm-marker 'bm-marker-left                ; Highlight bookmarks in the left fringe
 ;; bm-highlight-style 'bm-highlight-only-fringe    ; Highlight bookmarks in the left fringe
 ;; bm-recenter t                            ; Center after locating bookmark
 ;; bookmark-save-flag 1                     ; Save bookmarks file after each addition

 ;; Helm
 ;; helm-rg-default-directory 'git-root
 ;; helm-ag-insert-at-point 'symbol

 ;; helm-projectile-fuzzy-match nil
 ;; helm-M-x-fuzzy-match nil
 ;; helm-use-fuzzy nil
 ;; helm-buffer-max-length 36     ;; Wider filename field in Helm candidates
 ;; helm-boring-buffer-regexp-list '("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*tramp" "\\*Minibuf" "\\*epc")
 ;; helm-white-buffer-regexp-list '("Dired")

 ;; Suppress warning at startup
 ;; ls-lisp-use-insert-directory-program t

 custom-theme-directory "~/.emacs.d/custom-themes/"
 )

(tab-bar-mode t)

(load-theme 'neil t)

(add-to-list 'centaur-theme-alist '(neil . doom-neil))

;; Auto modes
;; (add-to-list 'auto-mode-alist
;; '("\\.js\\'" . js-mode))

;;(defun my-c-mode-common-hook ()
;;  ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
;;  (c-set-offset 'substatement-open 0)
;;  ;; other customizations can go here
;;
;;  (setq c++-tab-always-indent t)
;;  (setq c-basic-offset 4)                  ;; Default is 2
;;  (setq c-indent-level 4)                  ;; Default is 2
;;  (setq c-default-style "allman")
;;
;;  (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
;;  (setq tab-width 4)
;;  (setq indent-tabs-mode t)  ; use spaces only if nil
;;  )
;;
;;(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
