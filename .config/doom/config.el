(setq user-full-name "hakou guelfen"
      user-mail-address "hakoudev@gmail.com")
(setq doom-font (font-spec :family "Fira Code" :size 20 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 18))

(setq display-line-numbers-type t)
(setq org-directory "~/org/")

(beacon-mode 1)
(setq confirm-kill-emacs nil)

;; (setq haskell-stylish-on-save t)
;; (add-hook 'before-save-hook #'+format/buffer nil t)

;; (require 'yaml-mode)
;; (require 'yaml)

;; (defun load-yaml-file (filename)
;;   (with-temp-buffer
;;     (insert-file-contents filename)
;;     (goto-char (point-min))
;;     (yaml-mode)
;;     (setq my-data (yaml-parse-string (buffer-string))))
;;   my-data)

;; (setq my-data (load-yaml-file "~/.config/theme/setting.yaml"))
;; (setq emacs-setting (gethash 'emacs (gethash 'setting my-data)))
;; (message "The Emacs setting is `%s`." (intern emacs-setting))

(setq doom-theme 'doom-vibrant)

;; add this to .emacs.d/early-init.el for flutter to work properly
;; it adds the flutter sdk path to emacs
;; (setenv "PATH" (concat (getenv "PATH") ":/opt/flutter/bin"))
;; (setq exec-path (append exec-path '("/opt/flutter/bin")))

;; (use-package dart-mode
;;   :custom
;;   (dart-format-on-save t))

;; (use-package flutter
;;   :after dart-mode
;;   :hook (dart-mode . (lambda ()
;;     (add-hook 'after-save-hook #'flutter-run-or-hot-reload nil t))))

;; (defun flutter-run-dev ()
;;   (interactive)
;;   (let ((flutter-command "flutter run --flavor dev -t lib/main/main_dev.dart"))
;;     (flutter-run "--flavor dev -t lib/main/main_dev.dart")))

;; (defun flutter-run-prod ()
;;   (interactive)
;;   (let ((flutter-command "flutter run --flavor prod -t lib/main/main_prod.dart"))
;;     (flutter-run "--flavor prod -t lib/main/main_prod.dart")))


;; (map! :leader
;;       (:prefix ("m" . "prefix")
;;         :desc "flutter-run_dev"
;;         "f d" #'flutter-run-dev))

;; (map! :leader
;;       (:prefix ("m" . "prefix")
;;         :desc "flutter-run_prod"
;;         "f p" #'flutter-run-prod))

(after! org
  (setq org-directory "~/Documents/Org")
  (setq org-log-done 'time))

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

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
