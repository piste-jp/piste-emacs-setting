(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(package-refresh-contents)

;; Package to install
(defvar my/favorite-packages
  '(
    bind-key
    company
    company-c-headers
    company-org-block
    dash
    eat
    flycheck
    go-mode
    grip-mode
    gtags-mode
    hide-lines
    hsluv
    markdown-mode
    ov
    powerline
    rainbow-delimiters
    syslog-mode
    use-package
    visible-mark
    vterm
    tern
    js2-mode
    tern-auto-complete
    ))

;; Install packeged not installed yet
;; Kick M-x eval-buffer
(dolist (package my/favorite-packages)
  (unless (package-installed-p package)
    (package-install package)))
