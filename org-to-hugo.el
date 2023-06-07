(require 'org-roam)
(require 'citeproc-org-setup)

(citeproc-org-setup)

(setq org-hugo-base-dir "/home/junghan/sync/emacs/blog")
(remove-hook 'find-file-hook #'+org-roam-open-buffer-maybe-h)

;; (defadvice +editorconfig--inhibit-in-org-exports-a (orig-fn &rest args)
;;  :around '(org-export-to-file org-babel-tangle)
;;  (let ((editorconfig-exclude-regexps '(".")))
;;    (apply orig-fn args)))

(defun my/org-roam-export-all-console ()
  "Re-exports all Org-roam files to Hugo markdown."
  (interactive)
  (dolist (org-file (directory-files-recursively org-roam-directory "\.org$"))
    (with-current-buffer (find-file org-file)
      (when (s-contains? "SETUPFILE" (buffer-string))
      ;; (when (and (s-contains? "SETUPFILE" (buffer-string))
                 ;; (s-contains? "ISPRIVATE: t" (buffer-string))
                 ;;)
        (message (format "[build] Exporting %s" org-file))
        (org-hugo-export-wim-to-md)))))
