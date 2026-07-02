;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs26 Setting File
;;                  Written by Atsushi Abe
;;
;; +DATE: 2026/07/03 00:16:13 piste
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Launch server mode
(require 'server)
(eval-when-compile (require 'server))
(when (and (functionp 'server-running-p)
           (not (server-running-p)))
  (server-start))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; OS generic setting
;(setq generic-extras-enable-list
;      '(alias-generic-mode apache-conf-generic-mode apache-log-generic-mode etc-fstab-generic-mode etc-modules-conf-generic-mode etc-passwd-generic-mode etc-services-generic-mode etc-sudoers-generic-mode fvwm-generic-mode hosts-generic-mode inetd-conf-generic-mode java-manifest-generic-mode java-properties-generic-mode javascript-generic-mode mailagent-rules-generic-mode mailrc-generic-mode named-boot-generic-mode named-database-generic-mode prototype-generic-mode resolve-conf-generic-mode samba-generic-mode show-tabs-generic-mode vrml-generic-mode x-resource-generic-mode xmodmap-generic-mode))
;
;(require 'generic-x)
;
;;; When opened from Desktep entry, PATH won't be set to shell's value.
;(if (eq system-type 'darwin)
;    (let ((path-str
;           (replace-regexp-in-string
;            "\n+$" "" (shell-command-to-string "echo $PATH"))))
;      (setenv "PATH" path-str)
;      (setq exec-path (nconc (split-string path-str ":") exec-path)))
;  )

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

;; flycheck の mode-line lighter を Powerline の緑帯で見えるようにする
;;
;;   powerline-default-theme は minor-mode 帯を mode-line 顔(grey75=グレー)で
;;   描くため、flycheck の success 顔(前景=緑)がグレー地に緑で埋もれる。success
;;   のときだけ前景を白、背景を左から2番目のセグメント色 powerline-active1
;;   (SpringGreen4=緑)へ差し替える。エラー時の赤(error 顔)は視認性のため残す。
(defun my/flycheck-mode-line-whiten-success (text)
  "flycheck lighter が success 顔(緑)なら白字・緑地へ差し替える。error(赤)等は保持。
`flycheck-mode-line-status-text' の :filter-return advice 用。"
  (if (and (stringp text)
           (eq (get-text-property 0 'face text) 'success))
      (propertize (substring-no-properties text)
                  'face '(:foreground "white" :background "SpringGreen4"))
    text))

(with-eval-after-load 'flycheck
  (advice-add 'flycheck-mode-line-status-text :filter-return
              #'my/flycheck-mode-line-whiten-success))

;; モードライン(powerline)のマイナーモード lighter を短縮する
;;
;;   powerline-default-theme は minor-mode-alist の lighter をそのまま並べる
;;   ため、常時 ON のグローバルマイナーモードで modeline が長くなる。
;;     例: "YAML Fly/-- Outl dtrt-indent EditorConfig WS FlyC:..."
;;   これらは常に ON で情報価値が薄いので lighter を空にして隠す。
;;   エラー件数を示す flycheck(FlyC:) と flyspell(Fly) は残す。
;;   (diminish 等のパッケージ不要。minor-mode-alist を直接書き換える。)
;;   隠したい/残したいモードは下のリストを増減するだけで調整できる。
(defvar my/mode-line-hidden-minor-modes
  '(outline-minor-mode
    dtrt-indent-mode
    editorconfig-mode
    global-whitespace-mode
    whitespace-mode
    abbrev-mode)
  "modeline から lighter を隠すマイナーモードのリスト。")

(defun my/tidy-mode-line-lighters ()
  "`my/mode-line-hidden-minor-modes' の lighter を空文字にして隠す。"
  (dolist (mode my/mode-line-hidden-minor-modes)
    (let ((entry (assq mode minor-mode-alist)))
      (when entry
        (setcdr entry (list ""))))))

;; 各マイナーモードは init 途中で読み込まれるため、init 完了後に一括適用する。
(add-hook 'emacs-startup-hook #'my/tidy-mode-line-lighters)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Which function mode
(which-function-mode)
(set-face-attribute 'which-func nil
                    :weight 'bold
                    :foreground color-fg-which
                    :background color-bg-which)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; doxymacs
;; TODO: Support Linux env. Now, it works only on mac
(if (eq system-type 'darwin)
    (progn
      (condition-case err
          (require 'doxymacs)
        (add-hook 'c-mode-common-hook 'doxymacs-mode)
        (setq doxymacs-doxygen-style "JavaDoc")
        (error (message "%s" err))))
)

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
        (if (>= (x-display-pixel-width) 3000) 16 12)
      (if (>= (x-display-pixel-width) 3000) 16
        (if (>= (x-display-pixel-width) 1900) 12 10))))

(defun calc-width () '(width . 120) )
(defun calc-height ()
  (if (eq ratina t)
      (if (>= (x-display-pixel-width) 3000) '(height . 80) '(height . 60))
    (if (>= (x-display-pixel-width) 3000) '(height . 70)
      (if (>= (x-display-pixel-width) 1900) '(height . 80) '(height . 60)))))

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
                          (font-height (* font-size 10) ) ;; :height は 1/10pt 単位
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
                        (font-height (* font-size 10) ) ;; :height は 1/10pt 単位
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
;; Editing configurations
;(setq default-tab-width 8)
(setq-default indent-tabs-mode nil)
(setq-default outline-minor-mode t)
;(setq indent-line-function 'indent-relative-maybe)
;(setq-default case-fold-search t)
;(setq case-replace t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Cursor Configurations
(setq next-line-add-newlines nil)
(setq require-final-newline t)
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
;; 外部で書き換えられたファイルの自動再読込 (auto-revert)
;;
;; Claude Code 等の AI エージェントが emacs で開いている最中のファイルを直接
;; 書き換えるため、ディスク側の変更を自動でバッファへ反映する。未保存の編集が
;; あるバッファは auto-revert の対象外(勝手に上書きされない)なので安全。
;; ローカルは inotify(file-notify)ベースで動くのでポーリング負荷は無い。
(setq global-auto-revert-non-file-buffers t) ; dired 等のバッファも追従
(setq auto-revert-verbose nil)               ; 再読込のたびのメッセージを抑制
;; TRAMP 越し(/ssh:, /docker:)は file-notify が効かずポーリングになるため既定の
;; まま無効(auto-revert-remote-files nil)。必要になったら t にする。
(global-auto-revert-mode 1)

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
(use-package editorconfig            ;; Emacs 30 は標準同梱
  :config (editorconfig-mode 1))
(use-package dtrt-indent
  :ensure t
  :config (dtrt-indent-global-mode 1))
;; 検出材料の無い新規ファイル用のデフォルト (既存ファイルは上2つが上書き)
(setq-default indent-tabs-mode nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LTFS (aurora-ltfs) 用 C/C++ スタイル
;;
;; かつて c-mode-common-hook / c++-mode-hook で全 C/C++ に強制していた
;; bsd ベース・タブ4 のスタイル。検出ベース(editorconfig/dtrt)と衝突するため
;; グローバル強制はやめ、LTFS のソースを開いたときだけ効くようディレクトリ
;; 限定にした。
(with-eval-after-load 'cc-mode
  (c-add-style
   "ltfs"
   '("bsd"
     (c-basic-offset . 4)
     (c-offsets-alist . ((case-label    . +)
                         (comment-intro . 0)
                         (inextern-lang . 0)
                         (inaccess      . 0)
                         (access-label  . -)
                         (innamespace   . -))))))

(dir-locals-set-class-variables
 'ltfs-cc
 '((c-mode   . ((c-file-style . "ltfs") (indent-tabs-mode . t) (tab-width . 4)))
   (c++-mode . ((c-file-style . "ltfs") (indent-tabs-mode . t) (tab-width . 4)))))

;; LTFS ソース (aurora-ltfs)。この配下の C/C++ は bsd ベース・タブ4 で開く。
(dir-locals-set-directory-class (expand-file-name "~/github/aurora-ltfs/") 'ltfs-cc)

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
;; org is bundled with Emacs 30; no package install needed.
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ansible-lint を flycheck に載せる (Ansible YAML 用)
;;
;;   VSCode 側は redhat.ansible が同じ ansible-lint を裏で回している。Emacs でも
;;   保存時に ansible-lint を走らせ、CI (.github/workflows/ansible-lint.yml と
;;   同じデフォルト設定) と一致した指摘をバッファに出す。
;;
;;   要点:
;;    - 出力は codeclimate(JSON)。pep8 と違い severity を持つので error/warning/
;;      info の3段に色分けできる(重大度で分ける)。
;;    - 実ファイルパス(source-original)に対して実行する。ansible-lint はロール
;;      構成やリポジトリ設定を辿るため、flycheck 既定の一時コピー(source)では
;;      正しく解析できない。ゆえに未保存バッファではなく「保存後の内容」が対象。
;;    - 素の YAML(CI 定義など)まで走らせないよう述語で Ansible らしいパスに限定。
;;   要 flycheck (無い環境では with-eval-after-load でまるごとスキップ)。

;; codeclimate severity → flycheck level。赤(error)を減らしたい/増やしたいときは
;; ここを書き換える。例: 実運用の指摘を全部赤にしたいなら "major" を error に。
(defvar my/ansible-lint-severity-levels
  '(("blocker"  . error)
    ("critical" . error)
    ("major"    . warning)
    ("minor"    . info)
    ("info"     . info))
  "ansible-lint codeclimate の severity 文字列を flycheck のレベルへ対応付ける。")

(defun my/ansible-lint-relevant-p ()
  "現在のバッファが Ansible 対象ファイルなら non-nil。素の YAML は除外する。"
  (when-let ((f (buffer-file-name)))
    (or (string-match-p "/\\(roles\\|group_vars\\|host_vars\\|tasks\\|handlers\\|vars\\|defaults\\|meta\\)/" f)
        (string-match-p "/playbook[^/]*\\.ya?ml\\'" f)
        (string-match-p "/\\(edges\\|requirements\\|site\\|main\\)\\.ya?ml\\'" f))))

(defun my/ansible-lint-parse-codeclimate (output checker buffer)
  "ansible-lint の codeclimate(JSON)出力を flycheck-error のリストへ変換する。
位置は positions.begin.{line,column}(列付き)か lines.begin(行のみ)の2形態を扱う。"
  ;; flycheck は stderr を stdout に混ぜてパーサへ渡すことがある。ansible-lint は
  ;; サマリ("# Rule Violation Summary" 等)や警告を stderr に出すため、出力全体を
  ;; そのまま json-parse-string にかけると先頭の非 JSON でパースが落ち、「指摘0件」
  ;; と誤判定されてflycheckが生出力をミニバッファへダンプする。
  ;;
  ;; codeclimate 本体は指摘があれば必ず行頭 '[{' の単一行(空配列なら '[]')。
  ;; ただし '[DEPRECATION WARNING]:' や '[WARNING]' 等のノイズ行も '[' 始まりで、
  ;; 素朴に "^\[" で拾うとこれらを掴んで json-parse-string が落ち、指摘があるのに
  ;; 「0件」と誤判定してしまう(exit 2 なのに flycheck が生出力をダンプする)。
  ;; そこで JSON の弁別子である '[{'…']' の行だけを取り出す(空配列=指摘なしは
  ;; 拾えなくてよい)。
  (let* ((json (if (string-match "^\\(\\[{.*\\]\\)$" output)
                   (match-string 1 output)
                 "[]"))
         (issues (condition-case nil
                     (json-parse-string json :object-type 'alist :array-type 'list)
                   (error nil)))      ; 空出力やパース失敗は「指摘なし」扱い
         errors)
    (dolist (issue issues)
      (let* ((check (alist-get 'check_name issue))
             (desc  (alist-get 'description issue))
             (sev   (alist-get 'severity issue))
             (loc   (alist-get 'location issue))
             (positions (alist-get 'positions loc))
             line column)
        (if positions
            (let ((begin (alist-get 'begin positions)))
              (setq line   (alist-get 'line begin)
                    column (alist-get 'column begin)))
          ;; lines.begin は素の数値(列情報なし)
          (setq line (alist-get 'begin (alist-get 'lines loc))))
        (when line
          (push (flycheck-error-new-at
                 line column
                 (or (cdr (assoc sev my/ansible-lint-severity-levels)) 'warning)
                 (format "%s" desc)
                 :id check
                 :checker checker
                 :buffer buffer)
                errors))))
    (nreverse errors)))

(defun my/enable-ansible-flycheck ()
  "Ansible の YAML を開いたら flycheck(ansible-lint)を有効化する。
flycheck が導入済みのときだけ動く(require の失敗は握りつぶす)。"
  (when (and (my/ansible-lint-relevant-p)
             (require 'flycheck nil t))
    (flycheck-mode 1)))

(with-eval-after-load 'flycheck
  (flycheck-define-checker ansible-lint
    "ansible-lint による Ansible 静的解析チェッカー (codeclimate/JSON, 重大度別)。"
    :command ("ansible-lint"
              "--offline"          ; バージョン確認バナー(出力を汚す)と毎保存の通信を抑止
              "--nocolor"          ; NO_COLOR=1 相当。念のため色を無効化
              "-f" "codeclimate"   ; severity 付き JSON
              source-original)     ; 実ファイルに対して実行(要保存)
    :error-parser my/ansible-lint-parse-codeclimate
    :modes (yaml-mode yaml-ts-mode)
    :predicate my/ansible-lint-relevant-p)
  (add-to-list 'flycheck-checkers 'ansible-lint))

(add-hook 'yaml-mode-hook    #'my/enable-ansible-flycheck)
(add-hook 'yaml-ts-mode-hook #'my/enable-ansible-flycheck)

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

(defun my/project-root-or-default ()
  "現在のプロジェクトのルートを返す(プロジェクト外なら default-directory)。"
  (or (and (fboundp 'project-current)
           (let ((pr (project-current nil)))
             (and pr (project-root pr))))
      default-directory))

(defun my/vterm--ai-launch (program label &optional new)
  "PROGRAM を vterm で起動する共通部。バッファ名のラベルは LABEL。
起点は現在のプロジェクト(無ければ default-directory)。NEW で別セッション。"
  (require 'vterm)
  (let* ((root (my/project-root-or-default))
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dev container を「正規CLI」(@devcontainers/cli)で扱う — プロジェクト汎用
;;   VSCode を使わずに devcontainer のライフサイクルを回す。`devcontainer up' は
;;   initializeCommand → compose/docker up → features/postCreate/postStart まで
;;   実行する。カレントプロジェクト直下の devcontainer.json を自動検出し、複数
;;   ある場合(.devcontainer/<name>/devcontainer.json)は completing-read で選ぶ。
;;   要: npm i -g @devcontainers/cli (nvm なので sudo 不要)。
;;   プロジェクト固定のラッパ(パス・設定を決め打ちしてどこからでも呼ぶ)は
;;   personal.el 側に置く。
(defun my/devcontainer--configs (root)
  "ROOT 配下の devcontainer 設定ファイル(ROOT からの相対パス)を列挙する。
探索順: .devcontainer/devcontainer.json → .devcontainer.json →
.devcontainer/<name>/devcontainer.json (CLI の探索仕様と同じ場所)。"
  (let ((dcdir (expand-file-name ".devcontainer" root))
        cands)
    (dolist (f '(".devcontainer/devcontainer.json" ".devcontainer.json"))
      (when (file-exists-p (expand-file-name f root))
        (push f cands)))
    (when (file-directory-p dcdir)
      (dolist (d (directory-files dcdir nil "\\`[^.]"))
        (let ((f (format ".devcontainer/%s/devcontainer.json" d)))
          (when (file-exists-p (expand-file-name f root))
            (push f cands)))))
    (nreverse cands)))

(defun my/devcontainer--read-config (root)
  "ROOT の devcontainer 設定を1つ返す。複数候補があれば選択を求める。"
  (let ((cands (my/devcontainer--configs root)))
    (cond ((null cands)
           (user-error "devcontainer.json が見つかりません: %s" root))
          ((null (cdr cands)) (car cands))
          (t (completing-read "devcontainer config: " cands nil t)))))

(defun my/devcontainer--insert-filter (proc string)
  "プロセス出力を整形してバッファへ追記するフィルタ。
ANSI 色は描画し、\\r\\n は普通の改行に、行内の裸の CR(^M)は「行頭へ戻って
上書き」の意味なので CR までの古い内容を捨てて最後の描画だけを残す。"
  (let ((buf (process-buffer proc)))
    (when (buffer-live-p buf)
      (with-current-buffer buf
        (let* ((moving (= (point) (process-mark proc)))
               (clean (replace-regexp-in-string
                       "[^\n]*\r" ""
                       (replace-regexp-in-string "\r\n" "\n" string))))
          (save-excursion
            (goto-char (process-mark proc))
            (insert (ansi-color-apply clean))
            (set-marker (process-mark proc) (point)))
          (when moving (goto-char (process-mark proc))))))))

(defvar my/devcontainer-up-extra-args nil
  "`my/devcontainer-up' が devcontainer up に渡す追加引数のリスト。")

(defun my/devcontainer-up (&optional config)
  "カレントプロジェクトの dev container を正規手順で起動する(非同期)。
CONFIG(プロジェクトルートからの相対パス)を省略すると自動検出し、複数候補が
あれば選択を求める。"
  (interactive)
  (require 'ansi-color)
  (let* ((root (my/project-root-or-default))
         (config (or config (my/devcontainer--read-config root)))
         (default-directory root)
         (name (file-name-nondirectory (directory-file-name root)))
         (buf (get-buffer-create (format "*devcontainer:%s*" name))))
    (display-buffer buf)
    (make-process
     :name (format "devcontainer-up-%s" name)
     :buffer buf
     ;; pty だと docker pull 等が TTY 向けのカーソル制御(ESC[1A/[2K)や
     ;; プログレスバーを吐き、普通のバッファでは制御文字まみれになる。
     ;; pipe なら非 TTY を検出して行単位のプレーンなログに切り替わる。
     :connection-type 'pipe
     ;; 残った SGR 色コードは ansi-color で描画する
     :filter #'my/devcontainer--insert-filter
     :command (append (list "devcontainer" "up"
                            "--workspace-folder" "."
                            "--config" config)
                      my/devcontainer-up-extra-args)
     ;; このファイルは lexical-binding でない(動的スコープ)ため、ラムダは
     ;; ローカル変数(name 等)を捕捉できない。sentinel が走る頃には束縛が
     ;; 消えて void-variable になるので、必要な情報はプロセス名から取る。
     :sentinel (lambda (p e)
                 (message "%s: %s" (process-name p) (string-trim e))))))

(defun my/devcontainer-rebuild (&optional config)
  "カレントプロジェクトの dev container を作り直して起動する(非同期)。
`devcontainer up' は既存コンテナがあると再利用するため、Dockerfile 等を
変更しても反映されない。--remove-existing-container を付けて
`my/devcontainer-up' を呼ぶだけのもの。CONFIG の扱いも同じ。"
  (interactive)
  ;; このファイルは動的スコープなので let 束縛が my/devcontainer-up に届く
  (let ((my/devcontainer-up-extra-args '("--remove-existing-container")))
    (my/devcontainer-up config)))

(defun my/devcontainer-shell (&optional config)
  "カレントプロジェクトの dev container 内に vterm シェルを開く(正規 exec)。
CONFIG の扱いは `my/devcontainer-up' と同じ。"
  (interactive)
  (require 'vterm)
  (let* ((root (my/project-root-or-default))
         (config (or config (my/devcontainer--read-config root)))
         (default-directory root)
         (name (file-name-nondirectory (directory-file-name root)))
         (vterm-shell (format "devcontainer exec --workspace-folder . --config %s bash"
                              (shell-quote-argument config)))
         (vterm-buffer-name (format "*dc-shell:%s*" name)))
    (vterm vterm-buffer-name)))

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
    ;; pop-to-buffer は LRU の別ウィンドウを選ぶため、マルチウィンドウでは
    ;; 出る場所が毎回変わる。送信先 vterm の直下に固定の入力欄として出す
    ;; (送信/破棄の quit-window でウィンドウごと閉じて元のレイアウトに戻る)。
    (select-window
     (display-buffer buf '((display-buffer-reuse-window
                            display-buffer-below-selected)
                           (window-height . 10))))))

(defun my/vterm-compose-send ()
  "コンポーズバッファの全文を送信先 vterm へ送る(bracketed paste)。"
  (interactive)
  (let ((target my/vterm--compose-target)
        (text (buffer-string)))
    (when (buffer-live-p target)
      (with-current-buffer target
        (vterm-send-string text t)))   ; t = bracketed paste(複数行まとめて)
    (quit-window t)
    ;; 確実に送信先 vterm へフォーカスを戻す(RET で実行確認するため)
    (when (buffer-live-p target)
      (let ((w (get-buffer-window target)))
        (when w (select-window w))))))

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
