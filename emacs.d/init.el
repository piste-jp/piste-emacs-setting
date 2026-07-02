;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs Setting File
;;                  Written by Atsushi Abe
;;
;; Time-stamp: <2019-07-25 19:26:03 piste>

;; XEmacs backwards compatibility file
(cond
 ((= emacs-major-version 30)
  (load (expand-file-name "~/.emacs.d/emacs30.el") nil t nil))

 ((= emacs-major-version 29)
  (load (expand-file-name "~/.emacs.d/emacs29.el") nil t nil))

 ((= emacs-major-version 28)
  (load (expand-file-name "~/.emacs.d/emacs28.el") nil t nil))

 ((= emacs-major-version 27)
  (load (expand-file-name "~/.emacs.d/emacs27.el") nil t nil))

 ((= emacs-major-version 26)
  (load (expand-file-name "~/.emacs.d/emacs26.el") nil t nil))

 ((= emacs-major-version 24)
  (load (expand-file-name "~/.emacs.d/emacs24.el") nil t nil))
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END OF FILE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company company-c-headers company-org-block dash flycheck go-mode grip-mode gtags-mode hide-lines hsluv js2-mode markdown-mode ov powerline rainbow-delimiters syslog-mode tern tern-auto-complete use-package visible-mark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
