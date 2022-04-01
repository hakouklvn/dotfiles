(setq user-full-name "hakou guelfen"
      user-mail-address "hakoudev@gmail.com")
(setq doom-font (font-spec :family "Fira Code" :size 18 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 16))
(setq doom-theme 'doom-vibrant)

(setq display-line-numbers-type t)
(setq org-directory "~/org/")
(setq doom-themes-treemacs-theme "doom-colors")
(setq confirm-kill-emacs nil)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(beacon-mode 1)

(use-package centaur-tabs
  :demand
  :config

   (setq centaur-tabs-style "bar"
         centaur-tabs-set-icons t
         centaur-tabs-height 35
         centaur-tabs-gray-out-icons 'buffer
         centaur-tabs-set-modified-marker t
         centaur-tabs-modified-marker ""
         centaur-tabs-cycle-scope 'tabs
         x-underline-at-descent-line t
         centaur-tabs-set-bar 'under)

   (centaur-tabs-headline-match)
   (centaur-tabs-mode t)

  :hook
  (dired-mode . centaur-tabs-local-mode)

  :bind
  ("C-o"      . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

(defun centaur-tabs-hide-tab (x)
  "Do no to show buffer X in tabs."
  (let ((name (format "%s" x)))
    (or
     ;; Current window is not dedicated window.
     (window-dedicated-p (selected-window))
     (string-prefix-p "*doom" name)

     ;; Is not magit buffer.
     (and (string-prefix-p "magit" name)
	  (not (file-name-extension name)))
     )))

(use-package projectile)
(use-package lsp-ui)
(use-package company)

(use-package prettier-js
  :ensure t
  :after (rjsx-mode)
  :hook (rjsx-mode)
  )
