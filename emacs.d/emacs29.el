;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs26 Setting File
;;                  Written by Atsushi Abe
;;
;; +DATE: 2025/11/26 15:01:14 piste
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Launch server mode
;(require 'server)
;(eval-when-compile (require 'server))
;(when (and (functionp 'server-running-p);           (not (server-running-p)))
;  (server-start))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Additional site-lisp paths
(setq load-path (cons "/usr/local/share/emacs/site-lisp" load-path))
(setq load-path (cons "/usr/local/share/emacs/site-lisp/doxymacs" load-path))

(setq load-path (cons "~/github/gtags" load-path))
(setq load-path (cons "~/github/sct-mode" load-path))

;; Prereq packages are described into prereq-package.el

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package setting
(require 'package)
(require 'use-package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Color configuration
;; Switch theme

(if (string= (getenv "DARK") "YES")
    (progn
      (setq theme "Dark")
      )
  (setq theme "Light")
  )

(if (string= (getenv "RATINA") "YES")
    (progn
      (setq ratina t)
      )
  (setq ratina nil)
  )

;; NOTE: daemon (emacs --daemon) では init 実行時にフレームがまだ無く
;; `window-system' は nil になる。だが後で emacsclient -c が作るのは GUI
;; フレームなので、ここは (display-graphic-p) だけでなく (daemonp) も真として
;; truecolor パレットを読む。純ターミナル(emacs -nw)のときだけ term256。
(if (or (display-graphic-p) (daemonp))
  ;; GUI color setting
  (if (string= theme "Dark")
      (progn
        (load (expand-file-name "~/.emacs.d/color_dark.el") nil t nil)
        )
    (load (expand-file-name "~/.emacs.d/color_light.el") nil t nil)
    )

  ; 256 terminal color setting
  (progn
    (if (string= theme "Dark")
        (progn
          (load (expand-file-name "~/.emacs.d/color_dark_term256.el") nil t nil)
          )
      (load (expand-file-name "~/.emacs.d/color_light_term256.el") nil t nil)
      )
    (set-face-attribute 'default nil :background color-bg) ;; disable transparency
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load personal secrets
(load (expand-file-name "~/.emacs.d/secret.el") nil t nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load personal (non-public / work-specific) settings if present
(load (expand-file-name "~/.emacs.d/personal.el") t t nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Character code setting
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OS generic setting
(setq generic-extras-enable-list
      '(alias-generic-mode apache-conf-generic-mode apache-log-generic-mode etc-fstab-generic-mode etc-modules-conf-generic-mode etc-passwd-generic-mode etc-services-generic-mode etc-sudoers-generic-mode fvwm-generic-mode hosts-generic-mode inetd-conf-generic-mode java-manifest-generic-mode java-properties-generic-mode javascript-generic-mode mailagent-rules-generic-mode mailrc-generic-mode named-boot-generic-mode named-database-generic-mode prototype-generic-mode resolve-conf-generic-mode samba-generic-mode show-tabs-generic-mode vrml-generic-mode x-resource-generic-mode xmodmap-generic-mode))

(require 'generic-x)

;; When opened from Desktep entry, PATH won't be set to shell's value.
(if (eq system-type 'darwin)
    (let ((path-str
           (replace-regexp-in-string
            "\n+$" "" (shell-command-to-string "echo $PATH"))))
      (setenv "PATH" path-str)
      (setq exec-path (nconc (split-string path-str ":") exec-path)))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Setting
(global-display-line-numbers-mode)
(set-face-attribute 'line-number nil
                    :foreground color-fg-line
                    :background color-bg-line)
(set-face-attribute 'line-number-current-line nil
                    :weight 'bold
                    :foreground color-fg-line-active)

(setq column-number-mode t)
(display-time-mode)
(setq kill-whole-line t)
(define-key global-map "\C-z" nil)
(setq-default major-mode 'text-mode)

(set-face-attribute 'minibuffer-prompt nil
                    :foreground color-fg-minibuffer-prompt
                    :background color-bg-minibuffer-prompt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Powerline
(require 'powerline)

;(setq powerline-default-separator 'utf-8)
;(setq powerline-current-separator 'utf-8)

(powerline-default-theme)
;(powerline-center-theme)
;(powerline-center-evil-theme)
;(powerline-vim-theme)
;(powerline-nano-theme)

(setq ns-use-srgb-colorspace nil)

(set-face-attribute 'powerline-active0 nil
                    :foreground color-fg-powerline-active0
                    :background color-bg-powerline-active0)
(set-face-attribute 'powerline-active1 nil
                    :foreground color-fg-powerline-active1
                    :background color-bg-powerline-active1)
(set-face-attribute 'powerline-active2 nil
                    :foreground color-fg-powerline-active2
                    :background color-bg-powerline-active2)
(set-face-attribute 'powerline-inactive0 nil
                    :foreground color-fg-powerline-inactive0
                    :background color-bg-powerline-inactive0)
(set-face-attribute 'powerline-inactive1 nil
                    :foreground color-bg-powerline-inactive1
                    :background color-bg-powerline-inactive1)
(set-face-attribute 'powerline-inactive2 nil
                    :foreground color-bg-powerline-inactive2
                    :background color-bg-powerline-inactive2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Which function mode
(which-function-mode)
(set-face-attribute 'which-func nil
                    :weight 'bold
                    :foreground color-fg-which
                    :background color-bg-which)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; doxymacs
(when (require 'doxymacs nil t)
  (add-hook 'c-mode-common-hook 'doxymacs-mode)
  (setq doxymacs-doxygen-style "JavaDoc"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; linum setting
(unless (or (display-graphic-p) (daemonp))
  (add-hook 'linum-before-numbering-hook
            (lambda ()
              (setq-local linum-format-fmt
                          (let ((w (length (number-to-string
                                            (count-lines (point-min) (point-max))))))
                            (concat "%" (number-to-string w) "d"))))))

(defun linum-format-func (line)
  (concat
   (propertize (format linum-format-fmt line) 'face 'linum)
   (propertize " " 'face 'mode-line)))

(unless (or (display-graphic-p) (daemonp))
  (setq linum-format 'linum-format-func))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enable Clipboard
(setq select-enable-clipboard t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Font setting on X

(defun calc-point ()
    (if (eq ratina t)
        (if (>= (x-display-pixel-width) 3000) 12 10)
      (if (>= (x-display-pixel-width) 1900) 12 10)))

(defun calc-width () '(width . 120) )
(defun calc-height ()
  (if (eq ratina t)
      (if (>= (x-display-pixel-width) 3000) '(height . 80) '(height . 60))
    (if (>= (x-display-pixel-width) 1900) '(height . 50) '(height . 50))))

;; フォント・フレームサイズ・スクロールバー・前景/背景色といった「表示(グラフィ
;; カル)フレームが存在して初めて意味を持つ設定」をここにまとめる。GUI 直接起動な
;; ら起動時に即実行、daemon なら emacsclient -c が最初の GUI フレームを作った時に
;; `server-after-make-frame-hook' から一度だけ呼ばれる(末尾のディスパッチ参照)。
;; こうしないと daemon 側は init 実行時に window-system=nil のためこの塊が丸ごと
;; スキップされ、フォント/サイズ/色が GUI 直接起動と食い違う。
(defvar my/graphic-frame-configured nil
  "フォント等のグローバルなグラフィカル設定が済んだかどうか。")

(defun my/apply-frame-appearance (frame)
  "FRAME 個別に効かせる表示設定(サイズ・スクロールバー・前景/背景色)を当てる。
`default-frame-alist' が WM 都合で無視され、新しい emacsclient フレームが極小に
なることがあるため、グラフィカルフレームが出来るたびに毎回サイズを当て直す。"
  (with-selected-frame frame
    (modify-frame-parameters frame (list (calc-width) (calc-height)))
    (set-scroll-bar-mode 'right)
    (set-foreground-color color-fg)
    (set-background-color color-bg)))

(defun my/setup-graphic-frame (&optional frame)
  "FRAME がグラフィカルなら表示系設定を適用する。
フォント/フォントセット等のグローバル設定は初回のみ。サイズ・色などフレーム個別に
効かせる設定は `my/apply-frame-appearance' で毎回当て直す。"
  (let ((frame (or frame (selected-frame))))
    (when (display-graphic-p frame)
      ;; --- グローバル設定(フォント等)は初回のみ ---
      (unless my/graphic-frame-configured
        (setq my/graphic-frame-configured t)
        (with-selected-frame frame
     (if (eq system-type 'darwin)
         (setq mac-allow-anti-aliasing t)      ;; turn on anti-aliasing (default)
       ;;(setq mac-allow-anti-aliasing nil)  ;; turn off anti-aliasing
       )

     (if (>= emacs-major-version 23)
         (if (eq system-type 'darwin)
             (progn
               ;; Mac setting
               (condition-case err
                   ;;(let* ((font-family "DejaVu Sans Mono for Powerline")
                   (let* ((font-family "DejaVuSansM Nerd Font Mono")
                          (jp-font-family "PlemolJP Console NF")
                          (font-size (calc-point))
                          (font-height (* font-size (calc-point)) )
                          )
                     (set-face-attribute 'default nil :family font-family :height font-height)
                     (let ((name (frame-parameter nil 'font))
                           (jp-font-spec (font-spec :family jp-font-family))
                           (jp-characters '(katakana-jisx0201
                                            cp932-2-byte
                                            japanese-jisx0212
                                            japanese-jisx0213-2
                                            japanese-jisx0213.2004-1))
                           (font-spec (font-spec :family font-family))
                           (characters '((?\u00A0 . ?\u00FF)    ; Latin-1
                                         (?\u0100 . ?\u017F)    ; Latin Extended-A
                                         (?\u0180 . ?\u024F)    ; Latin Extended-B
                                         (?\u0250 . ?\u02AF)    ; IPA Extensions
                                         (?\u0370 . ?\u03FF)))) ; Greek and Coptic
                       (dolist (jp-character jp-characters)
                         (set-fontset-font name jp-character jp-font-spec))
                       (dolist (character characters)
                         (set-fontset-font name character font-spec))
                       (add-to-list 'face-font-rescale-alist
                                    '("PlemolJP Console NF" . 1.2))
                       )
                     (tool-bar-mode -1))
                 (error (message "%s" err))))
           (progn
             ;; Linux setting
             (condition-case err
                 ;;(let* ((font-family "DejaVu Sans Mono for Powerline")
                 (let* ((font-family "DejaVuSansM Nerd Font Mono")
                        (jp-font-family "PlemolJP Console NF")
                        (font-size (calc-point))
                        (font-height (* font-size (calc-point)) )
                        )
                   (set-face-attribute 'default nil :family font-family :height font-height)
                   (let ((name (frame-parameter nil 'font))
                         (jp-font-spec (font-spec :family jp-font-family))
                         (jp-characters '(katakana-jisx0201
                                          cp932-2-byte
                                          japanese-jisx0212
                                          japanese-jisx0213-2
                                          japanese-jisx0213.2004-1))
                         (font-spec (font-spec :family font-family))
                         (characters '((?\u00A0 . ?\u00FF)    ; Latin-1
                                       (?\u0100 . ?\u017F)    ; Latin Extended-A
                                       (?\u0180 . ?\u024F)    ; Latin Extended-B
                                       (?\u0250 . ?\u02AF)    ; IPA Extensions
                                       (?\u0370 . ?\u03FF)))) ; Greek and Coptic
                     (dolist (jp-character jp-characters)
                       (set-fontset-font name jp-character jp-font-spec))
                     (dolist (character characters)
                       (set-fontset-font name character font-spec))
                     (add-to-list 'face-font-rescale-alist
                                  '("PlemolJP Console NF" . 1.15))
                     )
                   (tool-bar-mode -1))
               (error (message "%s" err))))
           )
       )

     ;; これから作られる別フレームにもサイズ・色が乗るよう default-frame-alist へ。
     ;; (initial-frame-alist は最初の 1 フレーム専用なので daemon では無意味)
     (setq default-frame-alist
           (append (list (calc-width)
                         (calc-height)
                         (cons 'foreground-color color-fg)
                         (cons 'background-color color-bg))
                   default-frame-alist))))
      ;; --- フレーム個別設定は毎回当てる ---
      ;; default-frame-alist が WM 都合で無視され新フレームが極小になることがあるので、
      ;; グラフィカルフレームが出来るたびにサイズ等を確実に当て直す。
      (my/apply-frame-appearance frame))))

;; グラフィカルフレームが出来るたびに表示設定を適用する(グローバル分は初回のみ)。
;;   - 非 daemon (emacs / emacs -nw): init 時点のフレームで判定して即実行
;;   - daemon: emacsclient フレーム生成のたびに server-after-make-frame-hook から
;;             呼ぶ(GUI フレームでなければ何もしない。毎回呼ぶことで 2 枚目以降の
;;             フレームにもサイズが確実に当たり、極小フレーム化を防ぐ)
(if (daemonp)
    (add-hook 'server-after-make-frame-hook #'my/setup-graphic-frame)
  (my/setup-graphic-frame))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setting of Anthy
;(load "anthy")
;(global-set-key "\C-o" 'anthy-mode)
;(setq anthy-wide-space " ")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setting of mozc
(when (require 'mozc nil t)
  (setq default-input-method "japanese-mozc"))
(setq mozc-leim-title "かな")
(setq mac-command-modifier 'super)

;; Disable mozc input mode switch for enabling region selection by C-SPC
(with-eval-after-load 'mozc
  (define-key mozc-mode-map (kbd "C-SPC") nil)
  (when (boundp 'mozc-preedit-keymap)
    (define-key mozc-preedit-keymap (kbd "C-SPC") nil))
  (when (boundp 'mozc-keymap)
    (define-key mozc-keymap (kbd "C-SPC") nil)))

(global-set-key (kbd "s-SPC") 'toggle-input-method)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Editing configurations
;(setq default-tab-width 8)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default outline-minor-mode t)
;(setq indent-line-function 'indent-relative-maybe)
;(setq-default case-fold-search t)
;(setq case-replace t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Cursor Configurations
(setq-default require-final-newline t)
(setq mode-require-final-newline t)
(setq next-line-add-newlines nil)
(setq next-screen-context-lines 15)
(setq scroll-step 0)
(setq scroll-conservatively 0)
(setq scroll-margin 2)
(setq scroll-preserve-screen-position nil)
(setq transient-mark-mode 1)
(setq mouse-yank-at-point t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Window setting
(setq-default truncate-lines nil)
(setq-default truncate-partial-width-windows t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Scroll bar setting
;; スクロールバーは `my/setup-graphic-frame' 内(グラフィカルフレーム確定後)で
;; 設定する。daemon 起動時は window-system=nil でここが素通りしてしまうため。

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Startup setting
(setq inhibit-startup-message t)   ; No startup message
(setq initial-scratch-message nil)

(set-foreground-color color-fg)
(set-background-color color-bg)
(set-face-attribute 'region nil :background yank-bg)
(set-face-foreground 'minibuffer-prompt color-fg)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc
(setq completion-ignore-case t)
(setq message-log-max 10000)
(setq repeat-message-function 'ignore)
(setq use-dialog-box nil)
;;(setq suggest-key-bindings nil)
;;(setq view-read-only t)
(setq enable-recursive-minibuffers t)

;; garbage correction setting
(setq gc-cons-threshold 40000000)
(setq garbage-collection-messages nil) ;; Print garbage correction message

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; debug/error
(setq debug-on-error nil)
(setq eval-expression-print-level nil)
(setq eval-expression-print-length nil)
(setq eval-expression-debug-on-error nil)
(setq edebug-print-length 1000)
(setq edebug-print-level 1000)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto fill of update time
;; Insert date automatically if the file has "Time-stamp: <>" or
;; "Time-stamp: " "" within 20 lines at the top of the file
(require 'time-stamp)

(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-line-limit 20)
;
;; Magic text format
;; (setq time-stamp-start "Time-stamp:[ \t]+\\\\?[\"<]+")
;; (setq time-stamp-end "\\\\?[\">]")
(setq time-stamp-start "+DATE:")
(setq time-stamp-end "\n")

;; Time stump format
;(setq time-stamp-format "%:y-%02m-%02d %02H:%02M:%02S %u")
(setq time-stamp-format " %:y/%02m/%02d %02H:%02M:%02S %u")

;; Suppress warning
(setq time-stamp-old-format-warn nil) ;; default: 'ask

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Highlight parentheses
(show-paren-mode t)

(setq show-paren-style 'parenthesis)
;(setq show-paren-style 'mixed)
;(setq show-paren-style 'expression)

;(setq show-paren-ring-bell-on-mismatch t)
(setq show-paren-delay 0.05)

;; Disable default highlight feature by M-:
(setq blink-matching-paren nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rainbow-delimiters configuration
(require 'rainbow-delimiters)
;;(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Use color setting
(set-face-attribute 'rainbow-delimiters-depth-1-face nil
                    :weight 'bold
                    :foreground color-fg-rainbow1)
(set-face-attribute 'rainbow-delimiters-depth-2-face nil
                    :weight 'bold
                    :foreground color-fg-rainbow2)
(set-face-attribute 'rainbow-delimiters-depth-3-face nil
                    :weight 'bold
                    :foreground color-fg-rainbow3)
(set-face-attribute 'rainbow-delimiters-depth-4-face nil
                    :weight 'bold
                    :foreground color-fg-rainbow4)
(set-face-attribute 'rainbow-delimiters-depth-5-face nil
                    :weight 'bold
                     :foreground color-fg-rainbow5)
(set-face-attribute 'rainbow-delimiters-depth-6-face nil
                    :weight 'bold
                    :foreground color-fg-rainbow6)
(set-face-attribute 'rainbow-delimiters-depth-7-face nil
                    :weight 'bold
                    :foreground color-fg-rainbow7)
(set-face-attribute 'rainbow-delimiters-depth-8-face nil
                    :weight 'bold
                    :foreground color-fg-rainbow8)
(set-face-attribute 'rainbow-delimiters-depth-9-face nil
                    :weight 'bold
                    :foreground color-fg-rainbow9)
(set-face-attribute 'rainbow-delimiters-unmatched-face nil
                     :weight 'bold
                     :foreground color-fg-unmatched
                     :background color-bg-unmatched )
(set-face-attribute 'rainbow-delimiters-mismatched-face nil
                     :weight 'bold
                     :foreground color-fg-mismatch
                     :background color-bg-mismatch)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set executable bit automatically
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Remove needless white space characters
(defun my-trim-buffer ()
  "Delete excess white space."
  (interactive)
  (save-excursion
    ;; Remove trailing white spaces
    (goto-char (point-min))
    (while (re-search-forward "[ \t]+$" nil t)
      (replace-match "" nil nil))
    ;; Remove trailing empty lines
    (goto-char (point-max))
    (delete-blank-lines)
    ;; Replace white spaces to tab if possible
    ;; (mark-whole-buffer)
    ;; (tabify (region-beginning) (region-end))
    ))
(add-hook 'before-save-hook 'my-trim-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Delete empty file
(defun my-delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (= (point-min) (point-max)))
    (when (y-or-n-p "Delete file and kill buffer?")
      (delete-file
       (buffer-file-name (current-buffer)))
      (kill-buffer (current-buffer)))))
(if (not (memq 'my-delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'my-delete-file-if-no-contents after-save-hook)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Change yes/no to y/n in finishing emacs
(defadvice save-buffers-kill-emacs
    (around save-buffers-kill-emacs-yornp activate)
  (let ((default (symbol-function 'yes-or-no-p)))
    (fset 'yes-or-no-p 'y-or-n-p)
    ad-do-it
    (fset 'yes-or-no-p default)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Highlighting
(defgroup visible-mark nil
  "Show the position of your mark."
  :group 'convenience
  :prefix "visible-mark-")

(defface visible-mark-face
  `((((type tty) (class color))
     (:background "blue" :foreground "white"))
    (((type tty) (class mono))
     (:inverse-video t))
    (((class color) (background dark))
     (:background "blue"))
    (((class color) (background light))
     (:background "lightblue"))
    (t (:background "gray")))
  "Face for the mark."
  :group 'visible-mark)

(defvar visible-mark-overlay nil
  "The overlay used in this buffer.")
(make-variable-buffer-local
 'visible-mark-overlay)

(defun visible-mark-move-overlay ()
  "Move the overlay in `visible-mark-overlay'
 to a new position."
  (move-overlay visible-mark-overlay
                (mark)
                (1+ (mark))))

(define-minor-mode visible-mark-mode
  "A mode to make the mark visible."
  :init-value nil :lighter nil :keymap nil
  :group 'visible-mark
  (if visible-mark-mode
      (unless visible-mark-overlay
        (setq visible-mark-overlay
              (make-overlay (mark)
                            (1+ (mark))))
        (overlay-put visible-mark-overlay
                     'face 'visible-mark-face)
        (add-hook 'post-command-hook
                  'visible-mark-move-overlay))
    (when visible-mark-overlay
      (delete-overlay visible-mark-overlay)
      (setq visible-mark-overlay nil))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Highlighting double-byte-space tab and trailing white spaces
(require 'whitespace)
(setq whitespace-style '(face           ; Using face
                         trailing       ; trailing spaces
                         tabs           ; Tab
                         empty          ; Following/Trailing empty lines
                         ;space-mark     ; Mark for space
                         ;tab-mark       ; Mark for tab
                         ))
(setq whitespace-display-mappings
      '(
        (space-mark ?\u3000 [?\u2423])
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])
        ))
(setq whitespace-trailing-regexp  "\\([ \u00A0]+\\)$")
(setq whitespace-space-regexp "\\(\u3000+\\)")
(set-face-attribute 'whitespace-trailing nil
                    :foreground color-fg-trailing
                    :background color-bg-trailing
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :foreground color-fg-trailing
                    :background color-bg-tab
                    :underline nil)
(set-face-attribute 'whitespace-space nil
                    :foreground color-fg-trailing
                    :background color-bg-db
                    :underline nil)

(global-whitespace-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Highlighting yanked region
(when (or (display-graphic-p) (daemonp))
  (defadvice yank (after ys:highlight-string activate)
    (let ((ol (make-overlay (mark t) (point))))
      (overlay-put ol 'face 'highlight)
      (sit-for 0.5)
      (delete-overlay ol)))
  (defadvice yank-pop (after ys:highlight-string activate)
    (when (eq last-command 'yank)
      (let ((ol (make-overlay (mark t) (point))))
        (overlay-put ol 'face 'highlight)
        (sit-for 0.5)
        (delete-overlay ol)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TRAMP Setting
(require 'tramp)
(add-to-list 'tramp-remote-process-environment
             "HISTFILE=/dev/null")

;; Honor the dev container's own PATH so remote eglot/company can find
;; language servers installed inside it (pyright, clangd, ruff, ...).
(with-eval-after-load 'tramp
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; company mode
(require 'company)

;(global-company-mode)
(setq company-idle-delay nil)

(global-set-key (kbd "M-C") 'company-complete)
(global-set-key (kbd "<S-tab>") 'company-indent-or-complete-common)

(add-hook
  'find-file-hook
  (lambda ()
    (when (file-remote-p default-directory)
      (set (make-local-variable 'company-gtags-executable) "global"))))

(add-hook
  'find-file-hook
  (lambda ()
    (when (file-remote-p default-directory)
      (set (make-local-variable 'company-clang-executable) "clang"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eglot (LSP) -- opt-in.  When the buffer is on a TRAMP /docker: path eglot
;; starts the language server INSIDE the dev container.  Run M-x eglot in a
;; Python or C/C++ buffer.  global+gtags stays as the always-on layer.
(with-eval-after-load 'eglot
  ;; Python -> pyright (lives in the openpilot venv, so imports resolve)
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode)
                 . ("pyright-langserver" "--stdio")))
  ;; C/C++ -> clangd
  (add-to-list 'eglot-server-programs
               '((c-mode c-ts-mode c++-mode c++-ts-mode) . ("clangd"))))

;; Feed eglot's completions into company (the existing completion UI).
(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (company-mode 1)
            (add-to-list (make-local-variable 'company-backends) 'company-capf)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Indentation -- project-agnostic, detection based.
;;   editorconfig : .editorconfig を持つプロジェクトはそれを尊重
;;   dtrt-indent  : .editorconfig が無いリポジトリは各ファイルの実インデントを
;;                  自動検出して追従 (kernel=tab/8, ansible=space/2 等)
;; プロジェクト固有のタブ強制リストは personal.el 側に置く。
(use-package editorconfig            ;; Emacs 29 は ELPA から導入
  :ensure t
  :config (editorconfig-mode 1))
(use-package dtrt-indent
  :ensure t
  :config (dtrt-indent-global-mode 1))
;; 検出材料の無い新規ファイル用のデフォルト (既存ファイルは上2つが上書き)
(setq-default indent-tabs-mode nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings for spell check
(if (eq system-type 'darwin)
    (setq-default ispell-program-name "/usr/local/bin/aspell") ;; aspell for Mac
    (setq-default ispell-program-name "/usr/bin/aspell") ;; aspell for others
  )
;; For ignoring Japanese text
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\0377]+")))

;; Mode hook setting
;;(mapc
;; (lambda (hook)
;;   (add-hook hook 'flyspell-prog-mode))
;; '(
;;   c-mode-common-hook
;;   c++-mode-hook
;;   python-mode-hook
;;   emacs-lisp-mode-hook
;;   shell-script-mode-hook
;;   ))

;;(mapc
;; (lambda (hook)
;;   (add-hook hook #'(lambda () (flyspell-mode 1))))
;; '(
;;   fundamental-mode-hook
;;   text-mode-hook
;;   org-mode-hook
;;   ))

(global-set-key (kbd "C-c C-,") 'flyspell-buffer)
(global-set-key (kbd "C-c C-.") 'flyspell-goto-next-error)
(global-set-key (kbd "C-c C-/") 'flyspell-correct-word-before-point)

(eval-after-load "flyspell"
    '(progn
       (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
       (define-key flyspell-mouse-map [mouse-3] #'undefined)
       (define-key flyspell-mouse-map [down-mouse-2] nil)
       (define-key flyspell-mouse-map [mouse-2] nil)
       )
    )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Close all buffers
(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; recentf setting
(when (require 'recentf-ext nil t)
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 100)
  (setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
  )

(recentf-mode 1)

;; Open recentf at start time
;(add-hook 'after-init-hook (lambda()
;    (recentf-open-files)
;    ))

;; Key binding of recentf
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; diff mode setting
(defun update-diff-refine-colors ()
  "update the colors for diff faces"

;; defined faces are
;;    `diff-added', `diff-changed', `diff-context',
;;    `diff-file-header', `diff-header', `diff-hunk-header',
;;    `diff-index', `diff-indicator-added', `diff-indicator-changed',
;;    `diff-indicator-removed', `diff-nonexistent', `diff-removed'.

  (set-face-attribute 'diff-indicator-added nil
                      :foreground color-fg-label :background color-bg
                      :weight 'normal)
  (set-face-attribute 'diff-added nil
                      :foreground color-fg-label :background color-bg
                      :weight 'normal)
  (set-face-attribute 'diff-indicator-changed nil
                      :foreground color-fg-variable :background color-bg
                      :weight 'bold)
  (set-face-attribute 'diff-changed nil
                      :foreground color-fg-variable :background color-bg
                      :weight 'bold)
  (set-face-attribute 'diff-context nil
                      :foreground color-fg-doc :background color-bg
                      :weight 'normal)
  (set-face-attribute 'diff-file-header nil
                      :foreground color-fg-type :background color-bg-tab
                      :weight 'normal)
  (set-face-attribute 'diff-header nil
                      :foreground color-fg-function :background color-bg
                      :weight 'bold)
  (set-face-attribute 'diff-hunk-header nil
                      :foreground color-fg-pp :background color-bg-tab
                      :weight 'normal)
  (set-face-attribute 'diff-index nil
                      :foreground color-fg :background color-bg
                      :weight 'normal)
  (set-face-attribute 'diff-nonexistent nil
                      :foreground color-fg :background color-bg
                      :weight 'normal)
  (set-face-attribute 'diff-indicator-removed nil
                      :foreground color-fg-keyword :background color-bg
                      :weight 'normal)
  (set-face-attribute 'diff-removed nil
                      :foreground color-fg-keyword :background color-bg
                      :weight 'normal)

  (set-face-attribute 'diff-refine-added nil
                      :foreground nil :background color-bg
                      :weight 'bold :underline t)
  (set-face-attribute 'diff-refine-changed nil
                      :foreground nil :background color-bg
                      :weight 'bold :underline t)
  (set-face-attribute 'diff-refine-removed nil
                      :foreground nil :background color-bg
                      :weight 'bold :underline t)
)

(eval-after-load "diff-mode"
  '(update-diff-refine-colors))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode setting
;(require 'org-install)
(require 'org)

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when (eq system-type 'darwin)
  (set-exec-path-from-shell-PATH))

;(setenv "PATH" (concat "/Library/TeX/texbin" (getenv "PATH")))
;(setq exec-path (append '("/Library/TeX/texbin") exec-path))

;; Key binds
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-switchb)
;; org-remember was removed from org; use org-capture (C-c c) instead.
;(global-set-key "\C-cr" 'org-remember)

;; Automode alias
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; Hide leading starts
;;(setq org-hide-leading-stars t)

;; Directory of org-default-notes-file
(setq org-directory "~/org")

;; File name of org-default-notes-file
(setq org-default-notes-file "captured.org")

;; File list for agenda
;;(setq org-agenda-files (list org-directory))
(setq org-agenda-files '("~/org"))

;; Use underline in agenda
(add-hook 'org-agenda-mode-hook #'(lambda () (hl-line-mode 1)))
(setq hl-line-face 'underline)

;; Do not use holiday in agenda
(setq calendar-holidays nil)

;; TODO State
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))

;; Recored timestamp of TODO completion
(setq org-log-done 'time)

;; org-mode templates
;; org-remember-templates is obsolete; superseded by org-capture-templates below.
;(setq org-remember-templates
;      '(("Note" ?n "* %?\n  %i\n  %a" nil "Tasks")
;        ("Todo" ?t "* TODO %?\n  %i\n  %a" nil "Tasks")))

(setq org-capture-templates
      '(("l" "Project(LTFS)" entry (file+headline "~/org/projects.org" "LTFS project")
         "* %?\n %U\n %i")
        ("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
     "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("n" "Note" entry (file+headline "~/org/notes.org" "Notes")
         "* %?\n %U\n %i")
        ("i" "Idea" entry (file+headline "~/org/ideas.org" "Ideas")
         "* %?\nIdea: %U\n %i")
        ("p" "Patents" entry (file+headline "~/org/ideas.org" "Patents")
         "* %?\nPatents: %U\n %i")
        ("m" "Meeting" entry (file+headline "~/org/meeting.org" "Meeting")
         "* %?\n %U\n %i")
        ))

(with-eval-after-load 'ox-latex

  (setq org-latex-default-packages-alist
  '(("AUTO"     "inputenc"  t)
    ("T1"       "fontenc"   t)
    (""         "fixltx2e"  nil)
    ("dvipdfmx" "graphicx"  t)
    (""         "longtable" nil)
    (""         "float"     nil)
    (""         "wrapfig"   nil)
    (""         "rotating"  nil)
    ("normalem" "ulem"  t)
    (""         "amsmath"   t)
    (""         "textcomp"  t)
    (""         "marvosym"  t)
    (""         "wasysym"   t)
    (""         "amssymb"   t)
    (""         "hyperref"  nil)
    "\\tolerance=1000")
  )

  (add-to-list 'org-latex-classes
               '("jsarticle"
                 "\\documentclass{jsarticle}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
                 ))

  (add-to-list 'org-latex-packages-alist '("english" "babel") t)
  (add-to-list 'org-latex-packages-alist '(
                                           "top=20truemm,bottom=20truemm,left=15truemm,right=15truemm"
                                           "geometry")
                                           t)
)

(setq org-latex-default-class "jsarticle")
(setq org-confirm-babel-evaluate nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-babel setting
(eval-after-load "org"
  '(progn
     (require 'ob-shell)
     (require 'ob-ruby)
     (require 'ob-python)
     (require 'ob-C)
     (require 'ob-dot)
     (require 'ob-gnuplot)
     (require 'ob-latex)
     (require 'ob-org)
     ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; markdown-mode
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configuration of font lock

;(defface font-lock-function-call-face
;  '((t (:foreground "DarkBlue")))
;  "Font lock mode face used to highlight function calls."
;  :group 'font-lock-highlighting-faces)
;(defvar font-lock-function-call-face 'font-lock-function-call-face)
;
;;; Following block is for Emacs24.5.1 or later for highlighting keywords.
(font-lock-add-keywords 'c-mode
                        '(
                          ;("\\<\\(\\sw+\\)(" 1 'font-lock-function-call-face)
                          ("\\<\\(FIXME:\\|TODO:\\)" 1 'font-lock-warning-face prepend)
                          ("!!!!!" 0 'font-lock-warning-face prepend)
                          )
                        )

(font-lock-add-keywords 'c++-mode
                        '(
                          ;("\\<\\(\\sw+\\)(" 1 'font-lock-function-call-face)
                          ("shard_ptr" . 'font-lock-warning-face)
                          ("\\<\\(FIXME:\\|TODO:\\)" 1 'font-lock-warning-face prepend)
                          ("!!!!!" 0 'font-lock-warning-face prepend)
                          )
                        )

(defun what-face (pos)
    (interactive "d")
        (let ((face (or (get-char-property (point) 'read-face-name)
            (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(progn
  (global-font-lock-mode t)
  (require 'font-lock)
  ;; Bold faces
  (set-face-attribute 'font-lock-warning-face nil
                      :weight     'bold
                      :foreground color-fg-warning
                      :background color-bg
                      :underline  nil)
  (set-face-attribute 'font-lock-keyword-face nil
                      :weight     'bold
                      :foreground color-fg-keyword
                      :background color-bg
                      :underline  nil)
  (set-face-attribute 'font-lock-builtin-face nil
                      :weight     'bold
                      :foreground color-fg-builtin
                      :background color-bg
                      :underline  nil)
  (set-face-attribute 'font-lock-type-face nil
                      :weight     'bold
                      :foreground color-fg-type
                      :background color-bg
                      :underline  nil)
  (set-face-attribute 'font-lock-constant-face nil
                      :weight     'bold
                      :foreground color-fg-constant
                      :background color-bg
                      :underline  nil)
  (set-face-attribute 'font-lock-preprocessor-face nil
                      :weight     'bold
                      :foreground color-fg-pp
                      :background color-bg
                      :underline  nil)
  ;; Normal faces
  (set-face-attribute 'font-lock-function-name-face nil
                      :foreground color-fg-function
                      :background color-bg
                      :underline  nil)
  (set-face-attribute 'font-lock-variable-name-face nil
                      :foreground color-fg-variable
                      :background color-bg
                      :underline nil)
  (set-face-attribute 'font-lock-string-face nil
                      :foreground color-fg-string
                      :background color-bg-string
                      :underline  nil)
  (set-face-attribute 'font-lock-doc-face nil
                      :foreground color-fg-doc
                      :background color-bg
                      :underline  nil)
  (set-face-attribute 'font-lock-comment-face nil
                      :foreground color-fg-comment
                      :background color-bg
                      :underline nil)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setting for c-mode, c++-mode

(setq default-tab-width 4)
(setq tab-width 4)
(setq tab-stop-list
      '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))

;;(setq indent-tabs-mode nil)

;(add-hook 'c-mode-hook #'(lambda () (font-lock-mode)))
;(add-hook 'c++-mode-hook #'(lambda () (font-lock-mode)))
;(add-hook 'objc-mode-hook #'(lambda () (font-lock-mode)))
;(add-hook 'java-mode-hook #'(lambda () (font-lock-mode)))
;(add-hook 'emacs-lisp-mode-hook #'(lambda () (font-lock-mode)))
;(add-hook 'html-helper-mode-hook #'(lambda () (font-lock-mode)))
;(add-hook 'dired-mode-hook #'(lambda () (font-lock-mode)))
;(add-hook 'sh-mode-hook #'(lambda () (font-lock-mode)))

;(require 'hi-lock)
;(global-hi-lock-mode t)
;(setq hi-lock-file-patterns-policy t)

(add-hook 'c-mode-common-hook
          #'(lambda ()
             ;; インデント(タブ/スペース・幅・style)は editorconfig + dtrt-indent
             ;; + personal.el のプロジェクト別設定が管理する。ここは表示系のみ。
             (setq font-lock-keywords c-font-lock-keywords-2)
             ; User Preference
             (setq c-tab-always-indent 10)
             ;(setq-local company-backends
             ;            '((company-gtags company-keywords company-c-headers)))
             (gtags-mode)
             (ruler-mode)
             (set-fill-column 120)
             (setq comment-column 0)
             (rainbow-delimiters-mode)
             (flyspell-prog-mode)
             ;(highlight-phrase "TODO:" 'hi-red-b)
             ;(highlight-phrase "FIXME:" 'hi-red-b)
             ;(highlight-phrase "!!!!!" 'hi-red-b)
             (font-lock-add-keywords nil
                                     '(
                                       ("\\<\\(FIXME:\\|TODO:\\)" 1 'font-lock-warning-face prepend)
                                       ("!!!!!" 0 'font-lock-warning-face prepend)
                                       )
                                     )
             (company-mode)
             (add-to-list (make-local-variable 'company-backends)
;                          '(company-gtags company-clang company-dabbrev-code company-keywords :separate))
                          '(company-gtags company-dabbrev-code company-keywords :separate))
             )
          )

(add-hook 'c++-mode-hook
          #'(lambda ()
             ;; インデントは editorconfig + dtrt-indent + personal.el が管理。表示系のみ残す。
             (setq font-lock-keywords c++-font-lock-keywords-2)
             ; User Preference
             (font-lock-add-keywords nil
                                     '(
                                       ("\\<\\(FIXME:\\|TODO:\\)" 1 'font-lock-warning-face prepend)
                                       ("!!!!!" 0 'font-lock-warning-face prepend)
                                       ("shard_ptr" 0 'font-lock-warning-face prepend)
                                       ("shared_ptr" 0 'font-lock-type-face)
                                       )
                                     )
             )
          )

(setq auto-mode-alist
      (append
       '(
         ("\\.h$" . c++-mode)
         ("\\.x$" . c++-mode)
         )
       auto-mode-alist))

(add-hook 'perl-mode-hook
          #'(lambda ()
             ;(setq c-tab-always-indent t)
             (setq default-tab-width 4)
             (setq tab-width 4)
             (setq indent-tabs-mode nil)
             (setq tab-stop-list
                   '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
             (gtags-mode)
             (ruler-mode)
             (set-fill-column 120)
             (setq comment-column 0)
             (rainbow-delimiters-mode)
             (flyspell-prog-mode)
             (company-mode)
             (add-to-list (make-local-variable 'company-backends)
                          '(company-gtags company-clang company-dabbrev-code company-keywords :separate))
             )
          )

(add-hook 'python-mode-hook
          #'(lambda ()
             (setq indent-tabs-mode nil)
             (setq indent-level 4)
             ;(setq default-tab-width 3)
             ;(setq tab-width 3)
             ;(setq python-indent 3)
             ;(setq tab-stop-list
             ;      '(3 6 9 12 15 18 21 24 27 30 33 36 39 42 45))
             (setq tab-width 4)
             (setq python-indent-offset 4)
             ;(setq tab-stop-list
             ;      '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
             (gtags-mode)
             (ruler-mode)
             (set-fill-column 120)
             (setq comment-column 0)
             (flyspell-prog-mode)
             (company-mode)
             (add-to-list (make-local-variable 'company-backends)
                          '(company-gtags company-clang company-dabbrev-code company-keywords :separate))
             )
          )
(add-to-list 'auto-mode-alist '("\\.json$" . python-mode))

(add-hook 'sh-mode-hook
          #'(lambda ()
             (setq default-tab-width 4)
             (setq tab-width 4)
             (setq indent-tabs-mode nil)
             (setq tab-stop-list
                   '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
             (ruler-mode)
             (set-fill-column 120)
             (setq comment-column 0)
             (flyspell-prog-mode)
             )
          )

(add-hook 'sgml-mode-hook
          #'(lambda ()
             (setq default-tab-width 4)
             (setq tab-width 4)
             (setq indent-tabs-mode nil)
             (setq tab-stop-list
                   '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
             (ruler-mode)
             (set-fill-column 120)
             (setq comment-column 0)
             (flyspell-prog-mode)
             )
          )

(add-hook 'emacs-lisp-mode-hook
          #'(lambda ()
            (setq indent-tabs-mode nil)
            (ruler-mode)
            (set-fill-column 120)
            (setq comment-column 0)
            (flyspell-prog-mode)
            )
          )

(add-hook 'text-mode-hook
          #'(lambda ()
             (setq indent-tabs-mode t)
             (ruler-mode)
             (set-fill-column 120)
             (setq comment-column 0)
             (flyspell-mode)
             )
          )

(add-hook 'fundamental-mode-hook
          #'(lambda ()
             (setq indent-tabs-mode t)
             (ruler-mode)
             (set-fill-column 120)
             (setq comment-column 0)
             (flyspell-mode)
             )
          )

(add-hook 'org-mode-hook
          #'(lambda ()
             (setq indent-tabs-mode nil)
             (setq truncate-lines t)
             (setq truncate-partial-width-windows t)
             (ruler-mode)
             (set-fill-column 120)
             (setq comment-column 0)
             (font-lock-mode)
             (visual-line-mode)
             (flyspell-mode)
             (company-mode)
             (add-to-list (make-local-variable 'company-backends)
                          '(company-org-block company-dabbrev :separate))
             )
          )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings for Tag Jump by gtags-mode
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      #'(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; update GTAGS
(defun update-gtags (&optional prefix)
  (interactive "P")
  (let ((rootdir (gtags-get-rootpath))
        (args (if prefix "-v" "-iv")))
    (when rootdir
      (let* ((default-directory rootdir)
             (buffer (get-buffer-create "*update GTAGS*")))
        (save-excursion
          (set-buffer buffer)
          (erase-buffer)
          (let ((result (process-file "gtags" nil buffer nil args)))
            (if (= 0 result)
                (message "GTAGS successfully updated.")
              (message "update GTAGS error with exit status %d" result))))))))
;;(add-hook 'after-save-hook 'update-gtags)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JavaScript
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'js2-mode-hook
    (lambda ()
      (tern-mode t)
      (gtags-mode)
      (ruler-mode)
      (set-fill-column 120)
      (setq comment-column 0)
      (flyspell-prog-mode)))

(eval-after-load 'tern
    '(progn
        (require 'tern-auto-complete)
        (tern-ac-setup)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Definitions of perltidy
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point)
                             (mark) "perltidy -q" nil t)))
(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
                  (perltidy-region)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; syslog mode
;(require 'syslog-mode)
;(add-to-list 'auto-mode-alist '("/var/log.*\\'" . syslog-mode))
;(add-to-list 'auto-mode-alist '("\\.catcsv$" . syslog-mode))
;(add-to-list 'auto-mode-alist '("\\ltfs.*log$" . syslog-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SCT mode
(autoload 'sct-mode "sct-mode" "SCT" t)
(setq auto-mode-alist (cons '("\\.in$" . sct-mode) auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; YAML mode
(autoload 'yaml-ts-mode "yaml-ts-mode" "YAML" t)
(setq auto-mode-alist (cons '("\\.yml$" . yaml-ts-mode) auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dictionary setting on OSX
(if (eq system-type 'darwin)
    (global-set-key
     "\C-cw"
     (lambda ()
       (interactive)
       (let ((url (concat "dict://" (read-from-minibuffer "" (current-word)))))
         (browse-url url))))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; grip-mode

;; Path to the grip binary
(setq grip-binary-path "/usr/bin/grip")
(setq grip-github-api-url "https://api.github.com")

;; Hook at mode
(use-package grip-mode
  :ensure t
  :hook ((markdown-mode org-mode) . grip-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; vterm + Claude Code / Devin CLI ランチャ
;;
;; Claude の TUI は本物の libvterm を使う vterm でないと正しく描画できない。
;; 検証結果: eat(純 elisp) は claude のエスケープ列で emacs 全体が固まり、内蔵
;; term.el は動くが画面が崩れた。vterm のみ OK(要ビルド: cmake + libvterm-dev)。
;; eat はビルド不要の汎用端末として残してあるが、claude には使わない。
;;
;; vterm は `/bin/sh -c "stty …; exec <vterm-shell>"' で `vterm-shell' を起動する
;; (:connection-type 'pty)。よって `vterm-shell' にコマンド全体を入れればよい。
(setq vterm-always-compile-module t)   ; 初回ロード時にモジュールを無確認でコンパイル
(use-package vterm
  :ensure t
  :commands (vterm vterm-other-window my/claude my/devin my/codex))
(use-package eat
  :ensure t
  :commands (eat eat-make))

(defvar my/claude-program
  ;; `claude' は多くの環境で PATH 上の実行ファイルではなく ~/.bashrc の alias
  ;; として定義されている。my/claude は `bash -lc "exec …"' で起動するが、
  ;;   (1) 非対話シェルなので .bashrc の alias 定義自体が読まれない、
  ;;   (2) 仮に対話(-i)でも `exec' の引数は alias 展開されない、
  ;; ため "claude" のままだと command not found で即終了する。標準のローカル
  ;; インストール先の実体を直接指す。無ければ従来どおり "claude" にフォールバック。
  (let ((local (expand-file-name "~/.claude/local/claude")))
    (if (file-exists-p local) local "claude"))
  "Claude Code を起動するコマンド。引数を含めてもよい。")

(defvar my/devin-program "devin"
  ;; devin は alias ではなく ~/.local/bin/devin の実体なので、bash -lc の
  ;; PATH(~/.local/bin)でそのまま見つかる。claude のようなフルパス解決は不要。
  "Devin CLI を起動するコマンド。引数を含めてもよい。")

(defvar my/codex-program "codex"
  ;; codex は nvm の node bin(~/.nvm/versions/node/*/bin/codex)にある実体。
  ;; bash -lc(ログインシェル)が nvm を読み込むので PATH でそのまま見つかる。
  "Codex CLI を起動するコマンド。引数を含めてもよい。")

(defun my/vterm--ai-launch (program label &optional new)
  "PROGRAM を vterm で起動する共通部。バッファ名のラベルは LABEL。
起点は現在のプロジェクト(無ければ default-directory)。NEW で別セッション。"
  (require 'vterm)
  (let* ((root (or (and (fboundp 'project-current)
                        (let ((pr (project-current nil)))
                          (and pr (project-root pr))))
                   default-directory))
         (default-directory root)
         (host (or (file-remote-p root 'host) "local"))
         (vterm-shell (concat "bash -lc "
                              (shell-quote-argument
                               (concat "exec " program))))
         (vterm-buffer-name (if new
                                (format "*%s:%s:%s*" label host
                                        (abbreviate-file-name root))
                              (format "*%s:%s*" label host))))
    (vterm vterm-buffer-name)))

(defun my/claude (&optional new)
  "現在のプロジェクト(無ければ default-directory)を起点に vterm で Claude を起動。
ローカルはもちろん /ssh: バッファでも vterm が remote 実行する。コンテナは
TRAMP より `docker exec' 直結が安定なので `my/openpilot-claude' を使う。前置
引数 NEW で別セッション。ログインシェル(bash -lc)経由で PATH(nvm/.local)を通す。"
  (interactive "P")
  (my/vterm--ai-launch my/claude-program "claude" new))

(defun my/devin (&optional new)
  "現在のプロジェクト(無ければ default-directory)を起点に vterm で Devin を起動。
方式は `my/claude' と同一(vterm + bash -lc)。前置引数 NEW で別セッション。"
  (interactive "P")
  (my/vterm--ai-launch my/devin-program "devin" new))

(defun my/codex (&optional new)
  "現在のプロジェクト(無ければ default-directory)を起点に vterm で Codex を起動。
方式は `my/claude' と同一(vterm + bash -lc)。前置引数 NEW で別セッション。"
  (interactive "P")
  (my/vterm--ai-launch my/codex-program "codex" new))

;; vterm での日本語・長文入力(mozc コンポーズバッファ)
;;   vterm はバッファが read-only で、マイナーモード型 IME である mozc.el は確定
;;   文字をバッファに insert するため inline では使えない(Buffer is read-only)。
;;   回避策: 別バッファ(普通の編集バッファなので mozc が inline で効く)で和文・
;;   複数行を自由に編集し、C-c C-c で全文を vterm へ bracketed paste 送信する
;;   (改行ごとに送信されず 1 メッセージとして claude に渡る)。vterm で C-c C-j。
(defvar-local my/vterm--compose-target nil
  "コンポーズバッファの送信先 vterm バッファ。")

(defun my/vterm-compose ()
  "別バッファで(mozc inline・複数行で)端末へ送る文章を編集する。
編集バッファでは mozc がそのまま inline で使え、長文・複数行も書ける。
C-c C-c で全文を元の vterm へ bracketed paste 送信(改行で勝手に確定しない)、
C-c C-k で破棄。送信後は元の vterm に戻るので、内容を確認して RET で実行する。"
  (interactive)
  (let ((target (current-buffer))
        (buf (get-buffer-create "*vterm-compose*")))
    (with-current-buffer buf
      (erase-buffer)
      (text-mode)
      (setq my/vterm--compose-target target)
      (when default-input-method
        (activate-input-method default-input-method))
      (local-set-key (kbd "C-c C-c") #'my/vterm-compose-send)
      (local-set-key (kbd "C-c C-k") #'my/vterm-compose-abort)
      (setq header-line-format
            "C-c C-c: 送信   C-c C-k: 破棄   (s-SPC で和英切替)"))
    (pop-to-buffer buf)))

(defun my/vterm-compose-send ()
  "コンポーズバッファの全文を送信先 vterm へ送る(bracketed paste)。"
  (interactive)
  (let ((target my/vterm--compose-target)
        (text (buffer-string)))
    (when (buffer-live-p target)
      (with-current-buffer target
        (vterm-send-string text t)))   ; t = bracketed paste(複数行まとめて)
    (quit-window t)))

(defun my/vterm-compose-abort ()
  "コンポーズバッファを破棄する。"
  (interactive)
  (quit-window t))

(defun my/vterm--guard-input-method ()
  "vterm バッファで IME が ON にされたら即 OFF に戻す安全網。
read-only で詰むのを防ぐ。和文入力は C-c C-j / s-SPC のコンポーズを使う。"
  (when (derived-mode-p 'vterm-mode)
    (deactivate-input-method)
    (message "vterm では IME を直接使えません。C-c C-j か s-SPC でコンポーズを開いてください。")))

(add-hook 'vterm-mode-hook
          (lambda ()
            (add-hook 'input-method-activate-hook
                      #'my/vterm--guard-input-method nil t)))

(with-eval-after-load 'vterm
  (define-key vterm-mode-map (kbd "C-c C-j") #'my/vterm-compose)
  ;; vterm 内で IME を ON にすると read-only で詰む。手癖の s-SPC(toggle-input-
  ;; method)を「IME 切替」ではなく「コンポーズを開く」に割り当てて事故を防ぐ。
  (define-key vterm-mode-map (kbd "s-SPC") #'my/vterm-compose))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END OF FILE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
