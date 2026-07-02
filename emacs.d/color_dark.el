;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For Dark theme for Emacs26
;;                  Written by Atsushi Abe
;;
;; Time-stamp: <2019-07-25 19:34:42 piste>
;;

;; Color name definitions
(setq color_zouge         "#f8f4e6")
(setq color_binrojizome   "#433d3c")
(setq color_keshizumi     "#434343")
(setq color_kurotsurubami "#544a47")
(setq color_miruiro       "#726d40")
(setq color_soho          "#ab6953")
(setq color_genjinezu     "#888084")
(setq color_nijiiro       "#f6bfbc")
(setq color_momohanairo   "#e198b4")
(setq color_awafujiiro    "#bbc8e6")
(setq color_shojyohi      "#e2041b")
(setq color_asamurasaki   "#c4b3ef")
(setq color_kamenozoki    "#a2d7dd")
(setq color_wakanairo     "#d8e698")
(setq color_urahayanagi   "#c1d8ac")
(setq color_kenpoiro      "#543f32")
(setq color_tyojicha      "#b4866b")
(setq color_suzuiro       "#9ea1a3")
(setq color_urumiiro      "#c8c2be")
(setq color_rikyusirocha  "#b3ada0")
(setq color_sunairo       "#bcd3b2")
(setq color_natsumushi    "#cee4ae")
(setq color_yuuou         "#f9c89b")
(setq color_tankou        "#f8e58c")
(setq color_sosyoku       "#eae5e3")
(setq color_kogane        "#e6b422")
(setq color_koikurenai    "#a22041")

;; Face color setting for Dark mode
;; Base color (Dark)
(setq foreground-dark  color_zouge)
(setq background-dark  color_binrojizome)
(setq yank-bg          color_kurotsurubami)

(setq color-fg foreground-dark)
(setq color-bg background-dark)

(set-foreground-color color-fg)
(set-background-color color-bg)

;; line number
(setq color-fg-line        color_genjinezu)
(setq color-bg-line        color_kurotsurubami)
(setq color-fg-line-active color_tankou)

;; minibuffer
(setq color-fg-minibuffer-prompt foreground-dark)
(setq color-bg-minibuffer-prompt background-dark)

;; Powerline
(setq color-fg-powerline-active0 "Black")
(setq color-bg-powerline-active0 "DarkOliveGreen1")
(setq color-fg-powerline-active1 "White")
(setq color-bg-powerline-active1 "SpringGreen4")
(setq color-fg-powerline-active2 "White")
(setq color-bg-powerline-active2 "LightGoldenrod4")
(setq color-fg-powerline-inactive0 "gray30")
(setq color-bg-powerline-inactive0 "gray70")
(setq color-bg-powerline-inactive1 "gray30")
(setq color-bg-powerline-inactive2 "gray30")

;; Which function
(setq color-fg-which color-fg-powerline-active0)
(setq color-bg-which color-bg-powerline-active0)

;; White spaces
(setq color-fg-trailing color_zouge)
(setq color-bg-trailing color_miruiro)
(setq color-bg-tab      color_kurotsurubami)
(setq color-bg-db       color_kurotsurubami)

;; Programming (Bold)
(setq color-fg-warning  color_shojyohi)
(setq color-fg-keyword  color_nijiiro)
(setq color-fg-builtin  color_momohanairo)
(setq color-fg-type     color_awafujiiro)
(setq color-fg-constant color_urahayanagi)
(setq color-fg-pp       color_asamurasaki)

;; Programming (Normal)
(setq color-fg-function color_kamenozoki)
(setq color-fg-variable color_wakanairo)
(setq color-fg-string   color_urumiiro)
(setq color-bg-string   color_kenpoiro)
(setq color-fg-label    color_urahayanagi)
(setq color-fg-doc      color_rikyusirocha)
(setq color-fg-comment  color_genjinezu)

;; Rainbow
(setq color-fg-rainbow1  color_kamenozoki)
(setq color-fg-rainbow2  color_kamenozoki)
(setq color-fg-rainbow3  color_sunairo)
(setq color-fg-rainbow4  color_natsumushi)
(setq color-fg-rainbow5  color_yuuou)
(setq color-fg-rainbow6  color_tankou)
(setq color-fg-rainbow7  color_awafujiiro)
(setq color-fg-rainbow8  color_sosyoku)
(setq color-fg-rainbow9  color_momohanairo)
(setq color-fg-unmatched color_zouge)
(setq color-bg-unmatched color_koikurenai)
(setq color-fg-mismatch  color_binrojizome)
(setq color-bg-mismatch  color_kogane)
