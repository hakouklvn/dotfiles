(setq user-full-name "hakou guelfen"
      user-mail-address "hakoudev@gmail.com")
(setq doom-font (font-spec :family "Fira Code" :size 18 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 16))
(setq doom-theme 'doom-vibrant)

(setq display-line-numbers-type t)
(setq org-directory "~/org/")
(setq doom-themes-treemacs-theme "doom-colors")
(setq confirm-kill-emacs nil)
(beacon-mode 1)

 (use-package centaur-tabs
   :load-path "~/.emacs.d/other/centaur-tabs"
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
   ;; (centaur-tabs-enable-buffer-reordering)
   ;; (setq centaur-tabs-adjust-buffer-order t)
   (centaur-tabs-mode t)
   (setq uniquify-separator "/")
   (setq uniquify-buffer-name-style 'forward)
   (defun centaur-tabs-buffer-groups ()
     "`centaur-tabs-buffer-groups' control buffers' group rules.

 Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
 All buffer name start with * will group to \"Emacs\".
 Other buffer group by `centaur-tabs-get-group-name' with project name."
     (list
      (cond
	;; ((not (eq (file-remote-p (buffer-file-name)) nil))
	;; "Remote")
	((or (string-equal "*" (substring (buffer-name) 0 1))
	     (memq major-mode '(magit-process-mode
				magit-status-mode
				magit-diff-mode
				magit-log-mode
				magit-file-mode
				magit-blob-mode
				magit-blame-mode
				)))
	 "Emacs")
	((derived-mode-p 'prog-mode)
	 "Editing")
	((derived-mode-p 'dired-mode)
	 "Dired")
	((memq major-mode '(helpful-mode
			    help-mode))
	 "Help")
	((memq major-mode '(org-mode
			    org-agenda-clockreport-mode
			    org-src-mode
			    org-agenda-mode
			    org-beamer-mode
			    org-indent-mode
			    org-bullets-mode
			    org-cdlatex-mode
			    org-agenda-log-mode
			    diary-mode))
	 "OrgMode")
	(t
	 (centaur-tabs-get-group-name (current-buffer))))))
   :hook
   (dashboard-mode . centaur-tabs-local-mode)
   (term-mode . centaur-tabs-local-mode)
   (calendar-mode . centaur-tabs-local-mode)
   (org-agenda-mode . centaur-tabs-local-mode)
   (helpful-mode . centaur-tabs-local-mode)
   :bind
   ("C-<prior>" . centaur-tabs-backward)
   ("C-<next>" . centaur-tabs-forward)
   ("C-c t s" . centaur-tabs-counsel-switch-group)
   ("C-c t p" . centaur-tabs-group-by-projectile-project)
   ("C-c t g" . centaur-tabs-group-buffer-groups)
   (:map evil-normal-state-map
	  ("g t" . centaur-tabs-forward)
	  ("g T" . centaur-tabs-backward)))

(use-package prettier-js
  :after (rjsx-mode)
  :hook (rjsx-mode)
  )

(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs '("snippets"))
  (yas-global-mode 1))

(use-package dart-mode
  :ensure t
  :custom
  (dart-format-on-save t))

(use-package flutter
  :ensure t
  :after dart-mode
  :hook (dart-mode . (lambda ()
    (add-hook 'after-save-hook #'flutter-run-or-hot-reload nil t))))

(after! org
  (setq org-directory "~/Documents/Org")
  (setq org-agenda-files '("~/Documents/Org/hanuut_roadmap.org"))
  (setq org-log-done 'time))

(use-package projectile)
(use-package lsp-ui)

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))
