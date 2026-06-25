;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For Light theme for Emacs26
;;                  Written by Atsushi Abe
;;
;; Time-stamp: <2019-07-25 19:39:17 piste>
;;

;; Color name definitions
(setq color_zouge         "#f8f4e6")
(setq color_binrojizome   "#433d3c")
(setq color_kurotsurubami "#544a47")
(setq color_shojyohi      "#e2041b")
(setq color_torinokoiro   "#fff1cf")
(setq color_karekusairo   "#ede4cd")
(setq color_budouiro      "#522f60")
(setq color_seiran        "#274a78")
(setq color_aiiro         "#165e83")
(setq color_chitosemidori "#316745")
(setq color_mushiao       "#3a5b52")
(setq color_hiwamoegi     "#82ae46")
(setq color_oitakeiro     "#769164")
(setq color_biroudo       "#2f5d50")
(setq color_tokusairo     "#3b7960")
(setq color_benikikyou    "#4d4398")
(setq color_shiraai       "#c1e4e9")
(setq color_shirahanairo  "#e8ecef")
(setq color_uguisucha     "#715c1f")
(setq color_tetsukon      "#17184b")
(setq color_ebizome       "#7a4171")
(setq color_moegiiro      "#006e54")
(setq color_azukiiro      "#96415d")
(setq color_mirucha       "#5a544b")
(setq color_kogane        "#e6b422")
(setq color_koikurenai    "#a22041")

;; Face color setting for Light mode
;; Base color (Light)
(setq foreground-light color_binrojizome)
(setq background-light color_torinokoiro)
(setq yank-bg          color_kurotsurubami)

(setq color-fg foreground-light)
(setq color-bg background-light)

(set-foreground-color color-fg)
(set-background-color color-bg)

(setq color-fg foreground-light)
(setq color-bg background-light)

(set-foreground-color color-fg)
(set-background-color color-bg)

;; line number
(setq color-fg-line        foreground-light)
(setq color-bg-line        color_karekusairo)
(setq color-fg-line-active color_budouiro)

;; minibuffer
(setq color-fg-minibuffer-prompt foreground-light)
(setq color-bg-minibuffer-prompt background-light)

;; Powerline
(setq color-bg-powerline-active0 "DarkOliveGreen1")
(setq color-fg-powerline-active0 color-fg)
(setq color-bg-powerline-active1 "SpringGreen4")
(setq color-fg-powerline-active1 color-bg)
(setq color-bg-powerline-active2 "LightGoldenrod4")
(setq color-fg-powerline-active2 color-bg)
(setq color-bg-powerline-inactive0 "gray30")
(setq color-fg-powerline-inactive0 "gray70")
(setq color-bg-powerline-inactive1 "gray70")
(setq color-bg-powerline-inactive2 "gray70")

;; Which function
(setq color-fg-which color-fg-powerline-active0)
(setq color-bg-which color-bg-powerline-active0)

;; White spaces
(setq color-fg-trailing color_binrojizome)
(setq color-bg-trailing color_shirahanairo)
(setq color-bg-tab      color_shiraai)
(setq color-bg-db       color_kurotsurubami)

;; Programming (Bold)
(setq color-fg-warning  color_shojyohi)
(setq color-fg-keyword  color_budouiro)
(setq color-fg-builtin  color_seiran)
(setq color-fg-type     color_aiiro)
(setq color-fg-constant color_chitosemidori)
(setq color-fg-pp       color_mushiao)

;; Programming (Normal)
(setq color-fg-function color_biroudo)
(setq color-fg-variable color_tokusairo)
(setq color-fg-string   color_binrojizome)
(setq color-bg-string   color_karekusairo)
(setq color-fg-label    color_benikikyou)
(setq color-fg-doc      color_hiwamoegi)
(setq color-fg-comment  color_oitakeiro)

;; Rainbow
(setq color-fg-rainbow1  color_biroudo)
(setq color-fg-rainbow2  color_biroudo)
(setq color-fg-rainbow3  color_uguisucha)
(setq color-fg-rainbow4  color_tetsukon)
(setq color-fg-rainbow5  color_koikurenai)
(setq color-fg-rainbow6  color_ebizome)
(setq color-fg-rainbow7  color_moegiiro)
(setq color-fg-rainbow8  color_azukiiro)
(setq color-fg-rainbow9  color_mirucha)
(setq color-fg-unmatched color_zouge)
(setq color-bg-unmatched color_koikurenai)
(setq color-fg-mismatch  color_binrojizome)
(setq color-bg-mismatch  color_kogane)
