+++
title = "jh-navigation layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:50:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-navigation
{{< /hint >}}

<!--more-->


## Goals {#goals}

Spacemacs-navigation 을 수정하며 몇 가지 추가 레이어 구성 및 패키지 추가


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
   spacemacs-navigation

   fasd

   ;; evil-better-jumper

   imenu-list

   ;; outshine ; DONE replaced by 'outli'

   (treemacs
    :variables
    treemacs-position 'left
    treemacs-width 40
    treemacs-use-filewatch-mode t
    treemacs-use-follow-mode t
    treemacs-lock-width t
    treemacs-indentation 1

    treemacs-use-all-the-icons-theme nil
    treemacs-use-icons-dired nil
    )

   (ranger :variables
           ranger-show-preview t
           ranger-show-hidden t
           ranger-cleanup-eagerly t
           ranger-cleanup-on-disable t
           ranger-ignored-extensions '("mkv" "flv" "iso" "mp4"))
   )
 )
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
(defconst jh-navigation-packages
  '(
    ;; reconfigure packages
    winum
    imenu-list
    dumb-jump
    goto-last-change

    ;; additional packages
    outline
    (outli :location (recipe :fetcher github :repo "jdtsmith/outli"))

    (loccur :location (recipe :fetcher github :repo "thanhvg/loccur"))

    burly

    dired-subtree
    dired-open
    dired-git-info
    dired-du
    dired-posframe
    dired-sidebar
    dired-narrow
    ;; diredfl
    ;; dired-recent
    ;; dired-rsync

    ;; (hydra-posframe :location (recipe :fetcher github :repo "Ladicle/hydra-posframe"))
    )
  )
```


### <kbd>README</kbd> spacemacs-navigation layer {#readme-spacemacs-navigation-layer}

Spacemacs 네비게이션 레이어에서 제공하는 패키지들을 잘 파악해야 한다.
 ace-link, ace-window, auto-highlight-symbol, centered-cursor-mode
 compile, doc-view, view, golden-ratio, grep, info+, restart-emacs
 smooth-scrolling, symbol-overlay, winum

물론 추가로 필요한 패키지들을 정의할 필요가 있다.

-   M-s (search-map) and M-g (goto-map) bindings
-   evil-easymotion


### Winum {#winum}

spacemacs-navigation layer 에 winum 이 들어있지만 설정이 부족하다.
특히, 바닐라 모드 라인에 번호가 있었으면 한다.

```elisp
(defun jh-navigation/post-init-winum ()
  (defun my/winum-assign-custom ()
    (cond
     ;; 0 treemacs, 9 goto minibuffer
     ((equal (buffer-name) "*Flycheck errors*") 7)
     ((equal (buffer-name) "*Calculator*") 6))
    )

  (set-face-attribute 'winum-face nil :weight 'bold)
  (add-to-list 'winum-assign-functions #'my/winum-assign-custom)

  (define-key winum-keymap
              [remap winum-select-window-9] #'spacemacs/switch-to-minibuffer-window)

  (setq winum-scope                      'frame-local
        winum-auto-assign-0-to-minibuffer nil
        winum-reverse-frame-list          nil)
  (winum-mode 1)
  )
```


### imenu-list {#imenu-list}



```elisp
(defun jh-navigation/post-init-imenu-list ()
  (setq imenu-list-auto-resize nil)
  (setq imenu-list-size 45)
  )
```


### Goto-last-change and Evil-goto {#goto-last-change-and-evil-goto}

```elisp
(defun jh-navigation/init-goto-last-change ()
  (require 'goto-last-change)
  (global-unset-key (kbd "C-x ;")) ; default - comment-set-column
  (global-set-key (kbd "C-x ,") 'goto-last-change)
  (global-set-key (kbd "C-x ;") 'goto-last-change-reverse)
  )

;; goto-chg 패키지에서 아래 함수 제공
;; evil-goto-last-change-reverse (g ,)
;; evil-goto-last-change (g ;)
```


### dumb-jump {#dumb-jump}

코지 이맥스의 설정을 확인하라. consult 로 대체되면 빼고.

```elisp
(defun jh-navigation/init-dumb-jump ()
  (use-package dumb-jump
    :commands (dumb-jump-hydra/body)
    :custom  (dumb-jump-selector 'completing-read)
    :init
    ;; Use as xref backend
    (with-eval-after-load 'xref
      (add-hook 'xref-backend-functions #'dumb-jump-xref-activate 101))
    (global-set-key (kbd "M-g j") 'dumb-jump-hydra/body)
    (spacemacs/set-leader-keys "j/" 'dumb-jump-hydra/body)
    :config
    ;; Define Hydra keybinding (from the repo's examples)
    (defhydra dumb-jump-hydra (:color amaranth :columns 3)
      "Dumb Jump."
      ("j" dumb-jump-go "Go")
      ("o" dumb-jump-go-other-window "Other window")
      ("e" dumb-jump-go-prefer-external "Go external")
      ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
      ("i" dumb-jump-go-prompt "Prompt")
      ("l" dumb-jump-quick-look "Quick look")
      ("b" dumb-jump-back "Back")
      ("q" nil "Quit" :color blue))
    ))
```


### `Burly` Frame/window Bookmark {#burly-frame-window-bookmark}

북마크 관리 차원에서 어떻게 할지 만들자.
[GitHub - alphapapa/burly.el: Save and restore frames and windows with their b...](https://github.com/alphapapa/burly.el)

```elisp
(defun jh-navigation/init-burly ()
  (use-package burly
    :after bookmark
    :demand
    :defer 5
    :init
    (setq burly-tabs-mode nil)
    :config
    ;; M-m 누르면 Spacemacs Root 키바인딩 -- b I 누르면 된다. 이게 더 분류상 편하다.
    (spacemacs/declare-prefix "bM"  "burly-bookmark-map")
    (spacemacs/set-leader-keys "bMw" 'burly-bookmark-windows)
    (spacemacs/set-leader-keys "bMo" 'burly-open-bookmark)
    (spacemacs/set-leader-keys "bMl" 'burly-open-last-bookmark)
    ))
```


### <span class="org-todo todo TODO">TODO</span> `loccur` {#loccur}

테스트 필요하다.

```elisp
;;;;; loccur

(defun jh-navigation/init-loccur ()
  (use-package loccur
    :defer t
    :config
    (spacemacs/declare-prefix "sv"  "loccur")
    (spacemacs/set-leader-keys
      "svv" 'loccur-current
      "svl" 'loccur-previous-match
      "svo" 'loccur)
    )
  )
```


### Extra Power `Dired` {#extra-power-dired}

파일 매니저는 Dired 로 충분하다만... 아래와 같은 패키지들은 도움이 된다.


#### dired-subtree {#dired-subtree}

[dired-subtree](https://github.com/Fuco1/dired-hacks#dired-subtree) is a package that enables managing Dired buffers in a tree-like
manner. By default `evil-collection` maps `dired-subtree-toggle` to `TAB`.

```elisp
(defun jh-navigation/init-dired-subtree ()
  (use-package dired-subtree
    :demand
    :after dired
    :config
    (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
    )

  (defun my/dired-create-empty-file-subtree ()
    (interactive)
    (let ((default-directory (dired-current-directory)))
      (dired-create-empty-file
       (read-file-name "Create empty file: "))))
  )
```


#### dired-open {#dired-open}

```elisp
(defun jh-navigation/init-dired-open ()
  (use-package dired-open
    :demand
    :after dired
    :commands (dired-open-xdg)
    :config
    (setq dired-open-extensions '(("png" . "feh")
                                  ("mkv" . "mpv")))
    ))
```


#### dired-git-info {#dired-git-info}

Display git info, such as the last commit for file and stuff. It's pretty
useful but also slows down Dired a bit, hence I don't turn it out by default.

```elisp
(defun jh-navigation/init-dired-git-info ()
  (use-package dired-git-info
    :if (not my/slow-ssh)
    :demand
    :after dired
    :config
    ;; show git information
    (spacemacs/set-leader-keys-for-major-mode 'dired-mode
      "I" 'dired-git-info-mode)
    (define-key dired-mode-map ")" 'dired-git-info-mode)
    ;; disabled by performance issues
    ;; (add-hook 'dired-after-readin-hook 'dired-git-info-auto-enable)
    ))
```


#### dired-du {#dired-du}

[dired-du](https://elpa.gnu.org/packages/dired-du.html) is a package that shows directory sizes

```elisp
(defun jh-navigation/init-dired-du ()
  (use-package dired-du
    :demand
    :after dired
    :commands (dired-du-mode)
    :config
    (setq dired-du-size-format t)
    (spacemacs/set-leader-keys-for-major-mode 'dired-mode
      "D" 'dired-du-mode)
    ))
```


#### dired-posframe {#dired-posframe}

```elisp
(defun jh-navigation/init-dired-posframe ()
  (use-package dired-posframe
    :demand
    :after dired
    :config
    ;; show current file with posframe
    ;; (add-hook 'dired-mode-hook 'dired-posframe-mode)
    (spacemacs/set-leader-keys-for-major-mode 'dired-mode
      "P" 'dired-posframe-mode)
    ;; (define-key dired-mode-map (kbd "C-*") 'dired-posframe-show) ; not working
    ))
```


#### dired-narrow {#dired-narrow}

vifm-like filter

```elisp
(defun jh-navigation/init-dired-narrow ()
  (use-package dired-narrow
    :demand
    :after dired
    :commands dired-narrow
    :config
    (bind-key "<escape>" #'keyboard-quit dired-narrow-map)
    ))
```


#### dired-sidebar {#dired-sidebar}

[dired-sidebar](https://github.com/jojojames/dired-sidebar) enables opening Dired in sidebar. For me, with dired-subtree this
makes dired a better option than Treemacs.

```elisp
(defun jh-navigation/init-dired-sidebar ()
  (use-package dired-sidebar
    :after dired
    :demand
    :commands dired-sidebar-toggle-sidebar
    :init
    (add-hook 'dired-sidebar-mode-hook
              (lambda ()
                (unless (file-remote-p default-directory)
                  (auto-revert-mode))))
    :config
    ;; (setq dired-sidebar-width 40)
    (setq dired-sidebar-theme 'nerd) ;; ascii

    ;; ----------------------
    (setq dired-sidebar-use-custom-modeline nil) ; never !!
    (setq dired-sidebar-use-custom-font nil)
    ;; ----------------------

    (setq dired-sidebar-use-magit-integration nil) ; default t

    (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
    (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

    (setq dired-sidebar-subtree-line-prefix "__")
    (setq dired-sidebar-use-term-integration t)
    ;; (setq dired-sidebar-follow-file-at-point-on-toggle-open nil)

    (spacemacs/set-leader-keys-for-major-mode 'dired-mode
      "S" 'dired-sidebar-toggle-sidebar)
    (spacemacs/set-leader-keys "oS" 'dired-sidebar-toggle-sidebar)

    (global-set-key (kbd "M-g s") 'dired-sidebar-toggle-sidebar)

    (define-key dired-sidebar-mode-map "l" 'dired-sidebar-find-file)
    (define-key dired-sidebar-mode-map "h" 'dired-sidebar-up-directory)
    (define-key dired-sidebar-mode-map "=" 'dired-narrow)
    )
  )

  ;; (with-eval-after-load 'winum
  ;;   (define-key winum-keymap
  ;;               [remap winum-select-window-8] #'my/dired-sidebar-toggle)
  ;;   (define-key winum-keymap
  ;;               [remap winum-select-window-9] #'spacemacs/treemacs-project-toggle))
```


### `Outline-Mode` {#outline-mode}




#### Outline mode (built-in) {#outline-mode--built-in}

```elisp
(defun jh-navigation/init-outline ()
  (use-package outline
    :demand
    :init
    (setq outline-minor-mode-highlight nil) ; emacs28
    (setq outline-minor-mode-cycle t)       ; emacs28
    (setq outline-minor-mode-use-buttons nil) ; emacs29---bless you for the nil option!
    ;; (setq outline-minor-mode-use-margins nil) ; as above
    ;; (define-key global-map (kbd "<f10>") #'outline-minor-mode)
    )
  )
```


#### `Outli` - Simple outline mode {#outli-simple-outline-mode}

[GitHub - jdtsmith/outli: Simple comment-based outlines fo...](https://github.com/jdtsmith/outli)

<kbd>outshine</kbd> 보다는 빌트인을 활용한 심플한 패키지를 선호한다.
대체해도 문제가 없다.

```elisp
(defun jh-navigation/init-outli ()
  (use-package outli
    :after outline
    :defer 10
    ;; :after lispy ; only if you use lispy; it also sets speed keys on headers!
    :bind (:map outli-mode-map ; convenience key to get back to containing heading
                ("C-c o" . (lambda () (interactive) (outline-back-to-heading))))
    :hook ((prog-mode text-mode) . outli-mode)) ; or whichever modes you prefer
  )
```


## Keybindings {#keybindings}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-

;; evil-jump or better-jumper
(spacemacs/set-leader-keys "j." 'evil-jump-forward)
(spacemacs/set-leader-keys "j," 'evil-jump-backward)
(global-set-key (kbd "<f7>") 'imenu-list-smart-toggle)
```
