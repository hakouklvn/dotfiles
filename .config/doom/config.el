(setq user-full-name "hakou guelfen"
      user-mail-address "hakoudev@gmail.com")
(setq doom-font (font-spec :family "Fira Code" :size 22 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 20))

(require 'yaml-mode)
(require 'yaml)

(defun load-yaml-file (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (goto-char (point-min))
    (yaml-mode)
    (setq my-data (yaml-parse-string (buffer-string))))
  my-data)

(setq my-data (load-yaml-file "~/.config/theme/setting.yaml"))
(setq emacs-setting (gethash 'emacs (gethash 'setting my-data)))
(message "The Emacs setting is `%s`." (intern emacs-setting))

(setq doom-theme (intern emacs-setting))

(setq display-line-numbers-type t)
(setq org-directory "~/org/")
(setq confirm-kill-emacs nil)

(setq haskell-stylish-on-save t)
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

;; add this to .emacs.d/early-init.el for flutter to work properly
;; it adds the flutter sdk path to emacs
;; (setenv "PATH" (concat (getenv "PATH") ":/opt/flutter/bin"))
;; (setq exec-path (append exec-path '("/opt/flutter/bin")))

(use-package dart-mode
  :custom
  (dart-format-on-save t))

(use-package flutter
  :after dart-mode
  :hook (dart-mode . (lambda ()
    (add-hook 'after-save-hook #'flutter-run-or-hot-reload nil t))))

(defun flutter-run-dev ()
  (interactive)
  (let ((flutter-command "flutter run --flavor dev -t lib/main/main_dev.dart"))
    (flutter-run "--flavor dev -t lib/main/main_dev.dart")))

(defun flutter-run-prod ()
  (interactive)
  (let ((flutter-command "flutter run --flavor prod -t lib/main/main_prod.dart"))
    (flutter-run "--flavor prod -t lib/main/main_prod.dart")))


(map! :leader
      (:prefix ("m" . "prefix")
        :desc "flutter-run_dev"
        "f d" #'flutter-run-dev))

(map! :leader
      (:prefix ("m" . "prefix")
        :desc "flutter-run_prod"
        "f p" #'flutter-run-prod))

(after! org
  (setq org-directory "~/Documents/Org")
  (setq org-agenda-files '("~/Documents/Org/hanuut_roadmap.org"))
  (setq org-log-done 'time))

(use-package! projectile)
(use-package! lsp-ui)
(use-package! lsp-tailwindcss)

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(use-package! treemacs
  :defer t
  :config
  (setq doom-themes-treemacs-theme "doom-colors"))

(setq +latex-viewers '(zathura))
(with-eval-after-load 'ox-latex
(add-to-list 'org-latex-classes
             '("org-plain-latex"
               "\\documentclass{article}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(map! :leader
      (:prefix ("o" . "Toggle")
       :desc "Toggle imenu shown in a sidebar" "i" #'lsp-ui-imenu))

(add-to-list 'default-frame-alist '(alpha-background . 90))
