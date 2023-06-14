+++
title = "jh-visual layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:50:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-visual
{{< /hint >}}

<!--more-->


## Goals {#goals}

프로그래밍 언어와 인간 언어 둘다 검사기가 필요하다. 여기에 통합해서 넣는다.
한글은 따로 레이어가 없다. 관련 설정은 사용자 코드에서 한다. CJK 는 관심을
가지고 봐야 한다. 중국, 일본 사용자들이 많기 때문에 그 분들의 노하우를 한글로
옮겨 오면 좋겠다.


## Layer {#layer}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
;;
;; Copyright (c) 2012-2023 Sylvain Benner & Contributors
;;
;; Author: Junghan Kim <junghanacs@gmail.com>
;; URL: https://github.com/junghanacs
;;
;; This file is not part of GNU Emacs.
;;
;; License: GPLv3

;;; Commentary:

;;; Code:
(configuration-layer/declare-layer-dependencies
 '(
   (colors :packages (color-identifiers-mode
                      rainbow-mode))
   theming

   ;; ligatures on text-mode may cause issues with org-mode and magit
   (unicode-fonts
    :packages (ligature) ; not unicode-fonts
    :variables
    unicode-fonts-ligature-set '("<==" "<~~" "==>" "~~>"
                                 "<=>" "<==>" "->" "-->" "<-" "<--"
                                 "<->" "<-->")
    unicode-fonts-enable-ligatures nil
    unicode-fonts-ligature-modes '(prog-mode))

   (spacemacs-modeline
    :packages (anzu spaceline))

   (spacemacs-visual
    :packages (ansi-colors desktop display-fill-column-indicator popwin
                           posframe zoom-frm)) ; not all-the-icons
   ))
```


## Packages {#packages}


### Packages {#packages}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
;;
;; Copyright (c) 2012-2023 Sylvain Benner & Contributors
;;
;; Author: Junghan Kim <junghanacs@gmail.com>
;; URL: https://github.com/junghanacs
;;
;; This file is not part of GNU Emacs.
;;
;; License: GPLv3

;;; Commentary:

;;; Code:
(defconst jh-visual-packages
  '(
    ;; 재정의 패키지
    hl-todo
    spaceline
    evil
    popwin
    ;; vterm

    ;; 새로 등록하는 패키지
    hide-mode-line
    popup
    minions
    modus-themes
    ef-themes
    standard-themes
    nerd-icons
    (nerd-icons-completion :location (recipe :fetcher github :repo "rainstormstudio/nerd-icons-completion"))
    (nerd-icons-dired :location (recipe :fetcher github :repo "rainstormstudio/nerd-icons-dired"))
    kind-icon
    popper
    ;; dimmer
    ))
```


### Hide-mode-line {#hide-mode-line}

```elisp
  (defun jh-visual/init-hide-mode-line ()
    (use-package hide-mode-line :demand))
```


### `Modeline` Spaceline with minions {#modeline-spaceline-with-minions}

-   [X] 2023-02-17 완벽하다.
    바닐라, 둠 모드 라인을 거쳐서 다시 돌아 왔다. 이 과정은 완벽하게 배움의
    시간이었다. 탭 바, 미니온즈 등을 넣었고 어색한 부분이 하나도 없다.
    결국 이렇게 될 일. 인연에 따라 오고 간다는 말이로다.

<!--listend-->

```elisp
(defun jh-visual/pre-init-spaceline ()
  (spacemacs|use-package-add-hook spaceline-config
    :pre-config
    ;; (require 'window)
    ;; (spaceline-define-segment window-info
    ;;   "Shows the current window-info (dedication/size-fixed) "
    ;;   (when (configuration-layer/package-used-p 'spaceline)
    ;;     (let* ((dedicated (window-dedicated-p) )
    ;;            (fixed window-size-fixed)
    ;;            (pad (if (or dedicated fixed) " " "")))
    ;;       (format "%s%s%s%s"
    ;;               pad
    ;;               (if dedicated "#" "")
    ;;               (if fixed "X" "")
    ;;               pad))))
    ;; (add-to-list 'spacemacs-spaceline-additional-segments '(window-info :when active))
    ;; (message "JH post-init-spaceline")

    ;; (when (display-graphic-p) ; gui
    ;;   (require 'hide-mode-line)
    ;;   (message "jh-visual/global-hide-mode-line-mode")
    ;;   (global-hide-mode-line-mode) ; off
    ;;   )

    (setq display-time-default-load-average nil)
    (setq spaceline-global-p nil) ; remove global-mode-string
    ;; Change to spaceline's default
    (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
    (set-face-attribute 'spaceline-evil-emacs nil :background "#bd93f9" :foreground "#000000")

    ;; (spaceline-toggle-buffer-size-off)
    ;; (spaceline-toggle-minor-modes-off)
    ;; (spaceline-toggle-window-number-off)
    ;; (spaceline-toggle-purpose-off)
    ;; (spaceline-toggle-buffer-encoding-abbrev-off)

    :post-config
    (require 'minions)
    (setq minions-mode-line-lighter ";")
    ;; NOTE: This will be expanded whenever I find a mode that should not
    ;; be hidden
    (setq minions-prominent-modes
          (list 'defining-kbd-macro
                'flymake-mode
                'flycheck-mode
                ))
    (spaceline-define-segment minor-modes
      (if (bound-and-true-p minions-mode)
          (format-mode-line minions-mode-line-modes)
        (spaceline-minor-modes-default)))

    (defun jh-visual/enable-mode-line-addons ()
      (message "jh-visual/enable-mode-line-addons")
      (minions-mode 1)
      )
    (add-hook 'spacemacs-post-user-config-hook #'jh-visual/enable-mode-line-addons)
    ))
```


#### Modeline minions {#modeline-minions}

```elisp
(defun jh-visual/init-minions ()  (use-package minions :demand ))
```


### Themes and colors {#themes-and-colors}

스페이스맥스 기본 테마도 무리 없다. 욕심내면 modus-themes 를 쓰면 된다.
그게 아니라면 doom-themes 에서 골라 쓴다.


#### ef-themes {#ef-themes}

```elisp
(defun jh-visual/init-ef-themes ()
  (use-package ef-themes
    :defer
    :init
    (defun ef-themes-load-random-light ()
      (interactive) (ef-themes-load-random 'light))
    (defun ef-themes-load-random-dark ()
      (interactive) (ef-themes-load-random 'dark))
    :config
    (setq ef-themes-to-toggle '(ef-summer ef-winter))
    (setq ef-themes--select-theme-history t)

    (setq ef-themes-common-palette-overrides
          `(
            (ef-themes-heading-0 bg-dim) ; title
            (ef-themes-heading-3 bg-blue-subtle)
            (ef-themes-heading-4 bg-magenta-subtle)
            ))

    (when (display-graphic-p) ; gui
      (setq ef-themes-mixed-fonts nil)
      (setq ef-themes-variable-pitch-ui t)

      (setq ef-themes-headings
            '(
              (0                . (variable-pitch bold 1.3))
              (1                . (variable-pitch bold 1.2))
              (2                . (variable-pitch semibold 1.05))
              (3                . (variable-pitch semibold))
              (4                . (variable-pitch medium))
              (7                . (variable-pitch bold ))
              (8                . (variable-pitch bold ))
              (agenda-date      . (variable-pitch semibold 1.2))
              (agenda-structure . (variable-pitch semibold 1.1))
              (t                . (variable-pitch medium 1.0))))
      ) ; end-of gui

    (defun my-ef-themes-hl-todo-faces ()
      "Configure `hl-todo-keyword-faces' with Ef themes colors.
  The exact color values are taken from the active Ef theme."
      (ef-themes-with-colors
        (setq hl-todo-keyword-faces
              `(("HOLD" . ,yellow)
                ("TODO" . ,red)
                ("NEXT" . ,blue)
                ("THEM" . ,magenta)
                ("PROG" . ,cyan-warmer)
                ("OKAY" . ,green-warmer)
                ("DONT" . ,yellow-warmer)
                ("FAIL" . ,red-warmer)
                ("BUG" . ,red-warmer)
                ("DONE" . ,green)
                ("NOTE" . ,blue-warmer)
                ("KLUDGE" . ,cyan)
                ("HACK" . ,cyan)
                ("TEMP" . ,red)
                ("FIXME" . ,red-warmer)
                ("XXX+" . ,red-warmer)
                ("REVIEW" . ,red)
                ("DEPRECATED" . ,yellow)))))

    (add-hook 'ef-themes-post-load-hook #'my-ef-themes-hl-todo-faces)

    ;; Read the doc string or manual for this one.  The symbols can be
    ;; combined in any order.
    (setq ef-themes-region '(intense no-extend neutral))

    (defun my-ef-themes-mode-line ()
      "Tweak the style of the mode lines."
      (ef-themes-with-colors
        (custom-set-faces
         ;; `(mode-line ((,c :background ,bg-active :foreground ,fg-main)))
         ;; `(mode-line-inactive ((,c :background ,bg-alt :foreground ,fg-dim)))
         `(tab-bar ((,c :inherit ef-themes-ui-variable-pitch :background ,bg-tab-bar)))
         `(tab-line ((,c :inherit ef-themes-ui-variable-pitch :background ,bg-tab-bar :height 0.95)))
         `(powerline-active2 ((,c :inherit mode-line-active)))
         `(org-mode-line-clock ((,c :inherit bold :foreground ,modeline-info)))
         `(org-mode-line-clock-overrun ((,c :inherit bold :foreground ,modeline-err)))
         ;; `(wcheck-default-face ((,c :foreground ,red-cooler :underline
         ;;                            (:color foreground-color :style wave :position nil))))
         )))
    (add-hook 'ef-themes-post-load-hook #'my-ef-themes-mode-line)
    )
  )
```


#### standard-themes {#standard-themes}

```elisp
(defun jh-visual/init-standard-themes ()
  (use-package standard-themes
    :defer
    :demand t
    :config

    (setq standard-themes-italic-constructs t)
    (setq standard-themes-bold-constructs t)
    (setq standard-themes-mode-line-accented nil)

    (setq standard-themes-common-palette-overrides
          `(
            (standard-themes-heading-0 bg-dim) ; title
            (standard-themes-heading-3 bg-blue-subtle)
            (standard-themes-heading-4 bg-magenta-subtle)
            ))

    (setq standard-themes-region '(intense no-extend neutral))
    (setq standard-themes-prompts '(bold))
    (setq standard-themes-links (quote (neutral-underline faint)))
    (setq standard-themes-fringes 'intense) ; 'subtle

    (when (display-graphic-p) ; gui
      (setq standard-themes-mixed-fonts nil)
      (setq standard-themes-variable-pitch-ui t)
      (setq standard-themes-headings
            '(
              (0                . (variable-pitch bold 1.3))
              (1                . (variable-pitch bold 1.2))
              (2                . (variable-pitch semibold 1.05))
              (3                . (variable-pitch semibold))
              (4                . (variable-pitch medium))
              (7                . (variable-pitch bold ))
              (8                . (variable-pitch bold ))
              (agenda-date      . (variable-pitch semibold 1.2))
              (agenda-structure . (variable-pitch semibold 1.1))
              (t                . (variable-pitch medium 1.0))))
      ) ; end-of gui

    (defun my-standard-themes-hl-todo-faces ()
      "Configure `hl-todo-keyword-faces' with Standard themes colors.
  The exact color values are taken from the active Standard theme."
      (standard-themes-with-colors
        (setq hl-todo-keyword-faces
              `(("HOLD" . ,yellow)
                ("TODO" . ,red)
                ("NEXT" . ,blue)
                ("THEM" . ,magenta)
                ("PROG" . ,cyan-warmer)
                ("OKAY" . ,green-warmer)
                ("DONT" . ,yellow-warmer)
                ("FAIL" . ,red-warmer)
                ("BUG" . ,red-warmer)
                ("DONE" . ,green)
                ("NOTE" . ,blue-warmer)
                ("KLUDGE" . ,cyan)
                ("HACK" . ,cyan)
                ("TEMP" . ,red)
                ("FIXME" . ,red-warmer)
                ("XXX+" . ,red-warmer)
                ("REVIEW" . ,red)
                ("DEPRECATED" . ,yellow)))))

    (add-hook 'standard-themes-post-load-hook #'my-standard-themes-hl-todo-faces)

    (defun my-standard-themes-mode-line ()
      "Tweak the style of the mode lines."
      (standard-themes-with-colors
        (custom-set-faces
         `(tab-bar ((,c :inherit standard-themes-ui-variable-pitch :background ,bg-tab)))
         `(tab-line ((,c :inherit standard-themes-ui-variable-pitch :background ,bg-tab :height 0.9)))
         ;; `(mode-line ((,c :background ,bg-active :foreground ,fg-main)))
         ;; `(mode-line-inactive ((,c :background ,bg-alt :foreground ,fg-dim)))
         ;; `(powerline-active2 ((,c :inherit mode-line-active)))
         `(org-mode-line-clock ((,c :inherit bold :foreground ,modeline-info)))
         `(org-mode-line-clock-overrun ((,c :inherit bold :foreground ,modeline-err)))
         ;; `(wcheck-default-face ((,c :foreground ,red-cooler :underline
         ;;                            (:color foreground-color :style wave :position nil))))
         )))
    (add-hook 'standard-themes-post-load-hook #'my-standard-themes-mode-line)
    )
  )
```


#### modus-themes {#modus-themes}

<span class="timestamp-wrapper"><span class="timestamp">[2022-11-19 Sat 06:29]</span></span>
오 마이갓. 찰지게 테마가 나오는구나. 완벽해졌네.
<https://christiantietze.de/posts/2023/01/modus-themes-v4-changes/>
4.0 설정을 적용한다. minemacs 참고함.
vterm, term, ansi color 설정이 Spacemacs 와 문제가 있는듯 -&gt; 해결

```elisp
;; TODO 다시 테스트 해보고 정말 필요하면 다른 방법 찾아라.
;; (defun jh-visual/init-vterm ()
;;   (use-package vterm :ensure t) ; 미리 로딩 된 상태야 face 를 설정할 수 있다.
;;   )

(defun jh-visual/init-modus-themes ()
  (use-package modus-themes
    :demand t
    :init
    ;; Load the theme of your choice.
    ;; modus 테마 로더를 사용해야 위에 후크가 호출 된다.
    (setq modus-themes-to-toggle (let ((hr (nth 2 (decode-time))))
                                   (if (or (< hr 7) (< 20 hr))           ; between 8 PM and 7 AM
                                       '(modus-vivendi-tinted modus-operandi-tinted) ; load dark theme first
                                     '(modus-operandi-tinted modus-vivendi-tinted))))
    :config
    (require 'modus-themes)
    ;; Load the theme of your choice.
    ;; Modus Toggle 로 불러올 때 아래 Hook 이 호출 된다.
    (defun my-modus-themes-colors ()
      (modus-themes-with-colors
       (custom-set-faces
        `(vterm-color-black ((,c :background "gray25" :foreground "gray25")))
        `(vterm-color-yellow ((,c :background ,yellow-intense :foreground ,yellow-intense)))
        ;; `(mode-line ((,c :inherit modus-themes-ui-variable-pitch
        ;;                   :background ,bg-mode-line-active
        ;;                   :foreground ,fg-mode-line-active)))
        ;; `(mode-line-inactive ((,c :inherit modus-themes-ui-variable-pitch
        ;;                            :background ,bg-mode-line-inactive
        ;;                            :foreground ,fg-mode-line-inactive)))
        `(powerline-active2 ((,c :inherit mode-line-active))) ; 전체 통일
        `(org-mode-line-clock ((,c :inherit bold :foreground ,modeline-info)))
        `(org-mode-line-clock-overrun ((,c :inherit bold :foreground ,modeline-err)))
         `(tab-bar ((,c :inherit modus-themes-ui-variable-pitch :background ,bg-tab-bar)))
         `(tab-line ((,c :inherit modus-themes-ui-variable-pitch :background ,bg-tab-bar :height 0.95)))
        ;; `(wcheck-default-face ((,c :foreground ,red-cooler :underline
        ;;                            (:color foreground-color :style wave :position nil))))
        )))

    (setq modus-themes-italic-constructs nil
          modus-themes-bold-constructs t
          modus-themes-custom-auto-reload t
          modus-themes-disable-other-themes t ; default t
          ;; gray-background,'tinted-background
          modus-themes-org-blocks 'gray-background

          ;; Options for `modus-themes-prompts' are either nil (the
          ;; default), or a list of properties that may include any of those
          ;; symbols: `italic', `WEIGHT'
          modus-themes-prompts '(bold)

          ;; The `modus-themes-completions' is an alist that reads two
          ;; keys: `matches', `selection'.  Each accepts a nil value (or
          ;; empty list) or a list of properties that can include any of
          ;; the following (for WEIGHT read further below):
          ;; `matches'   :: `underline', `italic', `WEIGHT'
          ;; `selection' :: `underline', `italic', `WEIGHT'
          modus-themes-completions
          '((matches   . (semibold))
            (selection . (semibold text-also)))
          )

    ;; 'M-x' modus-themes-preview-colors-current
    (setq modus-themes-common-palette-overrides
          `(
            ;; Customize the mode-line colors
            (fg-mode-line-active fg-main) ; Black
            ;; (bg-mode-line-active bg-blue-intense)

            ;; "Make the mode line borderless"
            (border-mode-line-active unspecified)
            (border-mode-line-inactive unspecified)

            ;; "Make matching parenthesis more or less intense"
            (bg-paren-match bg-magenta-intense)
            (underline-paren-match unspecified)

            ;; Links
            (underline-link border)
            (underline-link-visited border)
            (underline-link-symbolic border)

            ;; Comments are yellow, strings are green
            (comment yellow-cooler)
            (string green-warmer)

            ;; Intense magenta background combined with the main foreground
            (bg-region bg-magenta-subtle)
            (fg-region fg-main)

            ;; background for headings
            ;; (bg-heading-0 bg-dim) ; title
            ;; (bg-heading-1 bg-dim) ; heading
            ;; (bg-heading-2 bg-yellow-nuanced) ; bg-lavender
            ;; (bg-heading-3 bg-blue-nuanced) ; bg-lavender
            ;; (bg-heading-4 bg-magenta-nuanced) ; 어둡게 하는게 좋겠다.

            ;; overline for headings
            ;; (overline-heading-2 fg-heading-2)
            ;; (overline-heading-3 fg-heading-3)
            ;; (overline-heading-4 fg-heading-4)
            ;; (overline-heading-5 fg-heading-5)

            ;; And expand the preset here. Note that the ,@ works because we use
            ;; the backtick for this list, instead of a straight quote.
            ;; 현재 설정에 faint, intense 컬러 세트를 덮어쓰고 싶다면
            ;; ,@modus-themes-preset-overrides-faint
            ;; ,@modus-themes-preset-overrides-intense
            )
          )

    (when (display-graphic-p) ;
      ;; Users may need to explicitly configure the font family of
      ;; fixed-pitch in order to get a consistent experience with their
      ;; typography (also check the fontaine package on GNU ELPA (by
      ;; Protesilaos)).
      (setq modus-themes-mixed-fonts nil)

      ;; In all of the following, WEIGHT is a symbol such as `semibold',
      ;; `light', `bold', or anything mentioned in `modus-themes-weights'.
      (setq modus-themes-variable-pitch-ui t)

      ;; The `modus-themes-headings' is an alist: read the manual's
      ;; node about it or its doc string. Basically, it supports
      ;; per-level configurations for the optional use of
      ;; `variable-pitch' typography, a height value as a multiple of
      ;; the base font size (e.g. 1.5), and a `WEIGHT'.
      (setq modus-themes-headings
            '(
              (0                . (variable-pitch bold 1.3))
              (1                . (variable-pitch bold 1.2))
              (2                . (variable-pitch semibold 1.05))
              (3                . (variable-pitch semibold ))
              (4                . (variable-pitch medium ))
              (7                . (variable-pitch bold ))
              (8                . (variable-pitch bold ))
              (agenda-date      . (variable-pitch bold 1.2))
              (agenda-structure . (variable-pitch bold 1.1))
              (t                . (variable-pitch medium 1.0))))
      ) ; end-of gui-mode

    (add-hook 'modus-themes-after-load-theme-hook #'my-modus-themes-colors)
    ) ; end-of use-package
  ) ; end-of defun

;; (add-hook 'spacemacs-post-user-config-hook #'modus-themes-toggle 80)
```


### Fonts functions {#fonts-functions}




#### korean-hangul modal states {#korean-hangul-modal-states}

pA0k.su 님의 korean-layer 리포를 가져와서 파일 하나로 만들었다.
이게 관리하기가 이게 편하다.
/home/junghan/spacemacs/elpa/29.0/develop/unicode-fonts-20220713.1837/unicode-fonts.el

```elisp
  ;; 입력 모드에서만 한영 변환 가능!
  (defun jh-visual/pre-init-evil ()
    (spacemacs|use-package-add-hook evil
      :post-config
      (advice-add 'evil-normal-state :before #'jh-visual//turn-off-input-method)
      (mapc (lambda (mode)
              (let ((keymap (intern (format "evil-%s-state-map" mode))))
                (define-key (symbol-value keymap) [?\S- ]
                            #'(lambda () (interactive)
                                (message
                                 (format "Input method is disabled in %s state." evil-state))))))
            '(motion normal visual)))
    )
```

```org
  +------------+------------+
  | 일이삼사오 | 일이삼사오 |
  +------------+------------+
  | ABCDEFGHIJ | ABCDEFGHIJ |
  +------------+------------+
  | 1234567890 | 1234567890 |
  +------------+------------+
  | 일이삼사오 | 일이삼사오 |
  | abcdefghij | abcdefghij |
  +------------+------------+
```


### hl-todo only for prog-mode {#hl-todo-only-for-prog-mode}

magit todo 에 의존성이 있기에 hl-todo 를 사용한다. 다만 prog-mode 에만
활용하면 된다. 좋은 정책이다.

```elisp
;; Highlight TODO, FIXME....
(defun jh-visual/init-hl-todo ()
  (use-package hl-todo
    ;; :hook (after-init . global-hl-todo-mode)
    :init
    (setq hl-todo-keyword-faces
          '(("HOLD" . "#d0bf8f")
            ("TODO" . "#cc9393")
            ("NEXT" . "#dca3a3")
            ("THEM" . "#dc8cc3")
            ("PROG" . "#7cb8bb")
            ("OKAY" . "#7cb8bb")
            ("DONT" . "#5f7f5f")
            ("FAIL" . "#8c5353")
            ("DONE" . "#afd8af")
            ("NOTE" . "#d0bf8f")
            ("KLUDGE" . "#d0bf8f")
            ("HACK" . "#d0bf8f")
            ("TEMP" . "#d0bf8f")
            ("FIXME" . "#cc9393")
            ("XXXX*" . "#cc9393")
            ("BUG" . "#ee5555")
            ("PROJ" . "#447f44")
            ("IDEA" . "#0fa050")
            ("INFO" . "#0e9030")
            ("TWEAK" . "#fe9030")
            ("PERF" . "#e09030")
            ("REVIEW" . "#8c5353")
            ("DEPRECATED" . "#e09030")))
    :config
    (message "global-hl-todo-mode")
    (global-hl-todo-mode)
    ))
```


### Icons {#icons}




#### nerd-icons {#nerd-icons}



```elisp
(defun jh-visual/init-nerd-icons ()
  (use-package nerd-icons
    ;; :unless window-system ; terminal
    :ensure
    :custom
    ;; (nerd-icons-font-family "Symbols NF")
    (nerd-icons-font-family "Sarasa Term K Nerd Font")
    ))

(defun jh-visual/init-nerd-icons-completion ()
  (use-package nerd-icons-completion
    ;; :unless window-system
    :ensure
    :after (marginalia nerd-icons)
    :config
    (nerd-icons-completion-mode)))

(defun jh-visual/init-nerd-icons-dired ()
  (use-package nerd-icons-dired
    ;; :unless window-system
    :after (nerd-icons)
    :hook (dired-mode . nerd-icons-dired-mode)))
```


#### `kind-icon` {#kind-icon}

기본 설정을 이용한다. 다만, 아이콘이 나타나지 않는 경우는 왜?

```elisp
(defun jh-visual/init-kind-icon ()
  (use-package kind-icon
    :ensure
    :after corfu nerd-icons
    :custom
    (kind-icon-default-face 'corfu-default) ; Have background color be the same as `corfu' face background
    :config
    (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
    (setq kind-icon-default-style '(:padding 0 :stroke 0 :margin 0 :radius 0 :height 0.9 :scale 0.9))
    ;; (add-hook 'spacemacs-post-theme-change-hook 'kind-icon-reset-cache) ; move to fontaine
    (unless (display-graphic-p) ; terminal
      (setq kind-icon-use-icons nil))
    ))
```


### popup {#popup}



```elisp
(defun jh-visual/init-popup ()
  (use-package popup
    :config
    (define-key popup-menu-keymap (kbd "C-j") 'popup-next)
    (define-key popup-menu-keymap (kbd "C-k") 'popup-previous)
    (define-key popup-menu-keymap (kbd "C-n") 'popup-next)
    (define-key popup-menu-keymap (kbd "C-p") 'popup-previous)
    ))
```


### <kbd>Advanced</kbd> Managing `Popup` windows {#advanced-managing-popup-windows}




#### Customizing `popwin` {#customizing-popwin}

home/junghan/spacemacs/layers/+spacemacs/spacemacs-visual/packages.el
여기 보면 좀 정리할 필요가 있다.
이런 식으로 간단하게 등록할 수 있게 되어있다. 빼든가 바꾸든가 하면 된다.

```elisp
(defun jh-visual/pre-init-popwin ()
  (spacemacs|use-package-add-hook popwin
    :post-config
    ;; (push '("\\*-vterm-\\*" :dedicated t :position right :stick t :noselect nil :width 70) popwin:special-display-config)
    ;; (push '(dired-mode :dedicated t :position left :stick t :noselect nil :width 65) popwin:special-display-config)
    ;; (push '("*Keyboard layout*" :dedicated t :position bottom :stick t :noselect t :height 13) popwin:special-display-config)
    ;; (push '("*Ilist*" :dedicated t :position right :stick t :noselect t :width 80) popwin:special-display-config)
    (push '("*org-roam*" :dedicated t :position right :stick t :noselect t :width 82) popwin:special-display-config)
    (push '(telega-chat-mode :dedicated t :position right :stick t :noselect t :width 60) popwin:special-display-config)
    (push '(telega-root-mode :dedicated t :position bottom :stick t :noselect t :height 0.4) popwin:special-display-config)
    ;; (push '(org-agenda-mode :dedicated t :position right :stick t :noselect nil :width 80) popwin:special-display-config)

    ;; bottom and popper
    ;; (push '(flymake-diagnostics-buffer-mode :dedicated t :position bottom :stick t :noselect t :width 0.3 :height 0.3) popwin:special-display-config)
    ;; (push '("\\*Async-native-compile-log\\*" :dedicated t :position bottom :stick t :noselect t) popwin:special-display-config)
    ;; (push '("^\\*EGLOT" :dedicated t :position bottom :stick t :noselect t :height 0.4) popwin:special-display-config)
    ;; (push '(helpful-mode :dedicated t :position bottom :stick t :noselect t :height 0.4) popwin:special-display-config)
    ;; (push '("*info*" :dedicated t :position bottom :stick t :noselect t :height 0.4) popwin:special-display-config)
    ;; (push '("*command-log*" :dedicated t :position bottom :stick t :noselect t :height 0.4) popwin:special-display-config)
    ;; (push '("*eldoc*" :dedicated t :position bottom :stick t :noselect t :height 0.4) popwin:special-display-config)
    )
  )
```


#### Popper {#popper}

-   [GitHub - karthink/popper: Emacs minor-mode to summon and ...](https://github.com/karthink/popper)

`Popper` is a minor-mode to tame the flood of ephemeral windows Emacs
produces, while still keeping them within arm's reach. Designate any
buffer to "popup" status, and it will stay out of your way. Disimss
or summon it easily with one key. Cycle through all your "popups" or
just the ones relevant to your current buffer. Useful for many
things, including toggling display of REPLs, documentation,
compilation or shell output, etc.

-   Popup placement controlled using display-buffer-alist or shackle.el:

If you already have rules in place for how various buffers should be displayed,
such as by customizing display-buffer-alist or with shackle.el, popper will
respect them once you set popper-display-control to nil:

-   2023-05-04 popwin 과 popper 의 상생 모델을 만들었다
    shackle 은 레이아웃 관리 역할이다. 이건 popwin 이 할 수 있다.
    popwin 으로 다 규칙을 잡자. 그리고 버퍼의 관리만 popper 가 하는 것이다.
    버퍼를 보고 지우고 하는 것은 아주 편리하다. 그리고 강력하다.

    이렇게 되면 기존 Spacemacs 의 방식을 고수하면서 버퍼를 조금 더
    효과적으로 관리할 수 있다. 일단 이렇게 해보고 안되면 지우면 된다.
    기본은 살려두는 거니까. 문제 될 게 없다.

<!--listend-->

```elisp
(defun jh-visual/init-popper ()
  (use-package popper
    :ensure t
    :config
    (setq popper-echo-dispatch-keys '("a" "s" "d" "f" "g"))
    (setq popper-mode-line '(:eval (propertize " POP " 'face 'mode-line-emphasis))) ; emphasis
    (setq popper-display-control nil) ; use popwin and display-buffer-alist
    (setq popper-reference-buffers
          '("\\*Messages\\*"
            '(("^\\*Warnings\\*$" . hide)
              ("^\\*Compile-Log\\*$" . hide)
              "^\\*Matlab Help.*\\*$"
              ;; "^\\*Messages\\*$"
              "^\\*Backtrace\\*"
              "^\\*evil-registers\\*"
              "^\\*Apropos"
              "^Calc:"
              "^\\*eldoc\\*"
              "^\\*TeX errors\\*"
              "^\\*ielm\\*"
              "^\\*TeX Help\\*"
              "^\\*ChatGPT\\*"
              "^\\*gptel-quick\\*"
              "\\*Shell Command Output\\*"
              ("\\*Async Shell Command\\*" . hide)
              "\\*Completions\\*"
              "[Oo]utput\\*")
            ;; "Output\\*$"
            "\\*Async-native-compile-log\\*" ; JH
            "^\\*EGLOT" ; JH
            "^\\*Flycheck.+\\*$" ; JH
            "*info*" ; JH
            "*Ilist*" ; JH
            ;; "*command-log*" ; JH
            ;; treemacs-mode ; JH
            "*Go-Translate*" ; JH
            help-mode
            telega-chat-mode
            helpful-mode
            compilation-mode
            process-menu-mode
            special-mode
            flymake-diagnostics-buffer-mode))
    (global-set-key (kbd "C-`") 'popper-toggle-latest)
    (global-set-key (kbd "C-~") 'popper-kill-latest-popup)
    (global-set-key (kbd "M-`") 'popper-cycle)
    (global-set-key (kbd "C-M-`") 'popper-toggle-type)
    (popper-mode +1)
    (popper-echo-mode +1)
    ))
```


## Funcs {#funcs}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
```


### line-spacing toggle {#line-spacing-toggle}



-   int : pixels

<!--listend-->

```elisp
(defun my/toggle-line-spacing ()
  "Toggle line spacing between no extra space to extra half line height.
  URL `http://ergoemacs.org/emacs/emacs_toggle_line_spacing.html'
  Version 2015-12-17"
  (interactive)
  (if (null line-spacing)
      ;; (setq line-spacing 0.5) ; add 0.5 height between lines
      (setq line-spacing 1) ; add 0.5 height between lines
    (setq line-spacing nil)   ; no extra heigh between lines
    )
  (redraw-frame (selected-frame)))
```


### embiggen text {#embiggen-text}

```elisp
(defun embiggen-text ()
  (interactive)
  (text-scale-increase 1)
  )
(defun ensmallen-text ()
  (interactive)
  (text-scale-decrease 1)
  )
```


## Configs {#configs}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
```


### Base {#base}

```elisp
(defvar show-keyboard-layout nil
  "If non nil, show keyboard layout in special buffer.")

(setq default-input-method "korean-hangul")
(set-language-environment "Korean")
(set-keyboard-coding-system 'utf-8)
(setq locale-coding-system  'utf-8)
(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8-unix)
(unless (spacemacs/system-is-mswindows)
  (set-selection-coding-system 'utf-8))

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; terminal-mode is nil
(setq-default line-spacing 2) ; 3

;; 날짜 표시를 영어로한다. org mode에서 time stamp 날짜에 영향을 준다.
(setq system-time-locale "C")
;; (setenv "LANG" "en_US.UTF-8")
;; (setenv "LC_ALL" "en_US.UTF-8")

(setq input-method-verbose-flag nil
      input-method-highlight-flag nil)
```


### Emoji and Symbol {#emoji-and-symbol}



```elisp
(defun jh-visual/emoji-set-font ()
  (set-fontset-font t 'emoji (font-spec :family "Apple Color Emoji") nil 'prepend)
  (set-fontset-font t 'emoji (font-spec :family "Noto Color Emoji") nil 'prepend) ; Top
  (set-fontset-font t 'symbol (font-spec :family "Symbola") nil 'prepend)
  (set-fontset-font t 'symbol (font-spec :family "Noto Sans Symbols 2") nil 'prepend)
  (set-fontset-font t 'symbol (font-spec :family "Noto Sans Symbols") nil 'prepend)
  (set-fontset-font t 'symbol (font-spec :family "Noto Color Emoji") nil 'prepend)) ; Top
(add-hook 'after-init-hook #'jh-visual/emoji-set-font)
;; (add-hook 'spacemacs-post-user-config-hook #'jh-visual/korean-set-font)
```


### Themes Tweaks {#themes-tweaks}



```elisp
(defun jh-visual//theme--tweaks-h (&optional _)
  (interactive)
  "Use smaller font (90% of the default) for line numbers in graphic mode."
  (when (display-graphic-p)
    (set-face-attribute
     'line-number nil
     :background (face-attribute 'default :background)
     :height (truncate (* 0.90 (face-attribute 'default :height)))
     :weight 'semi-light)
    (set-face-attribute
     'line-number-current-line nil
     :height (truncate (* 0.90 (face-attribute 'default :height)))
     :weight 'bold)))

(spacemacs|do-after-display-system-init
 (jh-visual//theme--tweaks-h))
(add-hook 'spacemacs-post-theme-change-hook #'jh-visual//theme--tweaks-h)

;; (add-hook 'after-init-hook #'+theme--tweaks-h) ; not work on spacemacs
;; (add-hook 'enable-theme-functions #'+theme--tweaks-h)
;; copy from 'asok-dot-spacemacs/.spacemacs:975'
(defadvice load-theme
    (before theme-dont-propagate activate)
  (mapc #'disable-theme custom-enabled-themes))
```


### Time-format and world-clock {#time-format-and-world-clock}

```elisp
;; (setq display-time-format "|W%U|%y-%m-%d|%H:%M|")
(setq display-time-format " | %a %e %b, %H:%M | ")
;; Covered by `display-time-format'
;; (setq display-time-24hr-format t)
;; (setq display-time-day-and-date t)
(setq display-time-interval 5) ; 60
(setq display-time-default-load-average nil)
;; NOTE 2022-09-21: For all those, I have implemented my own solution
;; that also shows the number of new items, although it depends on
;; notmuch: the `notmuch-indicator' package.
(setq display-time-mail-directory nil)
(setq display-time-mail-function nil)
(setq display-time-use-mail-icon nil)
(setq display-time-mail-string nil)
(setq display-time-mail-face nil)

;; World clock
(setq zoneinfo-style-world-list
      '(("America/Los_Angeles" "Los Angeles")
        ("America/Chicago" "Chicago")
        ("Brazil/Acre" "Rio Branco")
        ("America/New_York" "New York")
        ("Brazil/East" "Brasília")
        ("Europe/Lisbon" "Lisbon")
        ("Europe/Brussels" "Brussels")
        ("Europe/Athens" "Athens")
        ("Asia/Tbilisi" "Tbilisi")
        ("Asia/Yekaterinburg" "Yekaterinburg")
        ("Asia/Shanghai" "Shanghai")
        ("Asia/Seoul" "Seoul")
        ("Asia/Vladivostok" "Vladivostok")))

;; All of the following variables are for Emacs 28
(setq world-clock-list t)
(setq world-clock-time-format "%R %z  %A %d %B")
(setq world-clock-buffer-name "*world-clock*") ; Placement handled by `display-buffer-alist'
(setq world-clock-timer-enable t)
(setq world-clock-timer-second 60)
```


### Goto-address-mode {#goto-address-mode}



```elisp
(setq goto-address-url-face 'link
      goto-address-url-mouse-face 'highlight
      goto-address-mail-face nil
      goto-address-mail-mouse-face 'highlight)
```


### Buffered window `display-buffer-alist` {#buffered-window-display-buffer-alist}

popwin 으로 Org-Select 가 제어가 안된다. 빌트인으로 해볼까?

-   [X] Org-Select for `org-capture`
-   [X] Embark Actions
-   [X] Output, Register Preview
-   [X] Calendar and ...

    shackle 로 통합해야 함

<!--listend-->

```elisp
;; /prot-dotfiles/emacs/.emacs.d/prot-emacs-modules/prot-emacs-window.el:55
(add-to-list 'display-buffer-alist
             ;; bottom side window
             `("\\*Org Select\\*" ; the `org-capture' key selection
               (display-buffer-in-side-window)
               (dedicated . t)
               (side . bottom)
               (slot . 0)
               (window-parameters . ((mode-line-format . none)))))
(add-to-list 'display-buffer-alist
             `("\\*Embark Actions\\*"
               (display-buffer-reuse-mode-window display-buffer-at-bottom)
               (window-height . fit-window-to-buffer)
               (window-parameters . ((no-other-window . t)
                                     (mode-line-format . none)))))
(add-to-list 'display-buffer-alist
             `("\\*\\(Output\\|Register Preview\\).*"
               (display-buffer-reuse-mode-window display-buffer-at-bottom)))
(add-to-list 'display-buffer-alist
             `("\\*\\(Calendar\\|Bookmark Annotation\\|Buffer List\\).*"
               (display-buffer-reuse-mode-window display-buffer-below-selected)
               (window-height . fit-window-to-buffer)))
```


## Keybindings {#keybindings}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
```


### basics {#basics}

```elisp
;; (global-set-key [?\C-\\] 'jh-visual//change-input-method)
(global-set-key (kbd "<S-SPC>") 'toggle-input-method)
;; (global-set-key (kbd "<Alt_R>") 'toggle-input-method)
(global-set-key (kbd "<Hangul>") 'toggle-input-method)
;; (global-unset-key (kbd "S-SPC"))

(spacemacs/set-leader-keys "ii" 'insert-char)
(when (> emacs-major-version 28) ; emacs 29
  (spacemacs/set-leader-keys "ie" #'emoji-search))

(spacemacs/set-leader-keys "T," 'ef-themes-load-random-light)
(spacemacs/set-leader-keys "T." 'ef-themes-load-random-dark)
(spacemacs/set-leader-keys "T/" 'modus-themes-toggle)
(spacemacs/set-leader-keys "T?" 'standard-themes-toggle)

(spacemacs/set-leader-keys "Tl" 'my/toggle-line-spacing)
```


### embiggen text {#embiggen-text}

```elisp
(global-set-key (kbd "C-+") 'embiggen-text)
(global-set-key (kbd "C-_") 'ensmallen-text)
```


### popup {#popup}



```elisp
(spacemacs/set-leader-keys ";" 'popper-toggle-latest)
(spacemacs/set-leader-keys ":" 'popper-kill-latest-popup)
```
