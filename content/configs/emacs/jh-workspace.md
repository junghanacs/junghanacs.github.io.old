+++
title = "jh-workspace layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:50:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-workspace
{{< /hint >}}

<!--more-->


## Goals {#goals}

jh-workspace


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
   ;; Grouping buffers with ibuffer
   ;; ibuffer :: SPC b I, C-x C-b
   ;; refresh :: g r, fliter group :: g j/k, ][, TAB/S-TAB, M-n/p
   (ibuffer
    :variables
    ibuffer-old-time 8 ; buffer considered old after that many hours
    ibuffer-show-empty-filter-groups nil
    ibuffer-group-buffers-by 'projects)

   ;; (tabs :variables
   ;;       tabs-auto-hide nil
   ;;       tabs-icons t
   ;;       centaur-tabs-plain-icons t
   ;;       centaur-tabs-set-close-button nil
   ;;       centaur-tabs-style "bar"
   ;;       tabs-headline-match t
   ;;       tabs-selected-tab-bar 'under
   ;;       ;; centaur-tabs-label-fixed-length 8
   ;;       centaur-tabs-enable-key-bindings t
   ;;       ;; centaur-tabs-modified-marker "*"
   ;;       tabs-group-by-project t
   ;;       )

   ;; SPC TAB restricted to current layout buffers
   ;; Kill buffers when killing layer - SPC l x
   ;; eyebrowse persp-mode consult spaceline
   ;; 2023-04-07 persp-mode + tab-bar 로 해보려고 한다. 간단하게 해보자.
   ;; 2023-04-21 보름전에 이렇게 써놨다니. 헐.
   (spacemacs-layouts :variables
                      spacemacs-layouts-restrict-spc-tab t
                      persp-autokill-buffer-on-remove 'kill-weak)

   ;; 23/01/02--15:53 :: only use spacemacs-visual (popwin)
   ;; 23/01/09--14:27 :: need robust window-purposed
   ;; 2023-04-21 persp-mode + tab-bar 로 커버가 될 것 같은데?
   ;; 2023-04-28 다시 시도해보자
   ;; 2023-05-04 끈다. poppe+shackle 로 가볍게 가보려고 한다. popwin 내릴꺼다.
   ;; 2023-05-04 아니다, 다시 켠다. 공생하는 방법을 찾아보자.
   spacemacs-purpose
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
(defconst jh-workspace-packages
  '(
    ;; built-ins
    tab-bar
    persp-mode
    ;; centaur-tabs

    ;; 새로 등록하는 패키지
    keycast

    bufler

    ;; (tabspaces :location (recipe :fetcher github :repo "mclear-tools/tabspaces")
    ;;           ;; :toggle (version< "29.0.50" emacs-version)
    ;;            )
    ;; beframe
    ))
```


### Built-in `iBuffer` with Spacemacs {#built-in-ibuffer-with-spacemacs}

버퍼 관리가 워크셋 관리이자 프로젝트 관리이다.
ibuffer layer 와 bufler 가 동일한 기능을 제공하는 것 같다. 뭐가 더 특별한가?
없으면 레이어 기본을 쓰는게 옳은 선택이 된다.

굉장히 어려운 주제가 아닐까 싶다.

결국 버퍼 관리가 시작과 끝이다. 아래에 보면
버퍼 관리하는 패키지가 엄청 나게 많다. 사실 ibuffer 를 제외하면
이래저래 중복이 아니겠는가? 왜 필요하고 어떻게 추려야 하는가?
결국 사용자의 워크플로우에 따라서 결정할 일이다. 정리해보자.

-   [ ] ibuffer (using Spacemacs layer)
-   [ ] Tabspace
-   [ ] beframe
-   [ ] bufler

ibuffer 레이어를 활성화하면 된다. 그 전에 ibuffer 는 빌트인인데
뭐 더 특별한게 있는가? bufler 가 커버하는 부분이 아니던가?


### Informative `Tab-bar` with `Keycast` {#informative-tab-bar-with-keycast}


#### `Keycast` Show cmds and bindings {#keycast-show-cmds-and-bindings}

```elisp
(defun jh-workspace/init-keycast ()
  (use-package keycast
    :ensure
    :config
    (setq keycast-tab-bar-minimal-width 30)
    ;; (setq keycast-tab-bar-format "%20s%k%c%r")

    (dolist (input '(self-insert-command
                     org-self-insert-command))
      ;; (add-to-list 'keycast-substitute-alist `(,input "." "Typing…")))
      (add-to-list 'keycast-substitute-alist `(,input ">>>>>>>>>>" "Typing.....")))
    (dolist (event '(mouse-event-p
                     mouse-movement-p
                     mwheel-scroll))
      (add-to-list 'keycast-substitute-alist `(,event nil)))
    ))
```


#### Lovely `Tab-bar` {#lovely-tab-bar}

탭바는 여러모로 유용하다. 워크 스페이스라고 생각하고 관리하면 편하다.
컨트롤 메타 숫자키는 따로 사용하는게 없으니 이동도 편하다.
23/01/06--15:53 :: 탭바 숫자를 서클 타입으로 바꿈.
23/01/07--19:02 :: Prot 탭바를 가져옴.

서클을 사용하려면 hint 를 켜야 한다.

```elisp
(defun jh-workspace/init-tab-bar ()
  (use-package tab-bar
    :after keycast
    :ensure t
    :config
    (when (display-graphic-p) ; gui
      ;; https://christiantietze.de/posts/2022/02/emacs-tab-bar-numbered-tabs/
      (defvar ct/circle-numbers-alist
        '((0 . "⓪")
          (1 . "①")
          (2 . "②")
          (3 . "③")
          (4 . "④")
          (5 . "⑤")
          (6 . "⑥")
          (7 . "⑦")
          (8 . "⑧")
          (9 . "⑨"))
        "Alist of integers to strings of circled unicode numbers.")

      (defun ct/tab-bar-tab-name-format-default (tab i)
        (let ((current-p (eq (car tab) 'current-tab))
              (tab-num (if (and tab-bar-tab-hints (< i 10))
                           (alist-get i ct/circle-numbers-alist) "")))
          (propertize
           (concat tab-num
                   " "
                   (alist-get 'name tab)
                   (or (and tab-bar-close-button-show
                            (not (eq tab-bar-close-button-show
                                     (if current-p 'non-selected 'selected)))
                            tab-bar-close-button)
                       "")
                   " ")
           'face (funcall tab-bar-tab-face-function tab))))

      (setq tab-bar-tab-name-format-function #'ct/tab-bar-tab-name-format-default)
      ) ; end-of display-graphic-p

    ;;; Custom layout
    ;; =C-M-<number>
    (setq tab-bar-select-tab-modifiers '(control meta))
    (setq tab-bar-new-tab-choice "*scratch*")

    ;; Tabs for window layouts (tab-bar.el and prot-tab.el)
    (setq tab-bar-close-button-show nil)
    (setq tab-bar-close-last-tab-choice nil)
    (setq tab-bar-close-tab-select 'recent)
    (setq tab-bar-new-tab-to 'right)
    (setq tab-bar-position nil)
    (setq tab-bar-show nil)
    ;; (setq tab-bar-separator nil)
    (setq tab-bar-tab-hints t) ; for tab-bar-circle-number
    (setq tab-bar-auto-width-max '(220 . 120)) ; Emacs 29

    ;; (setq tab-bar-tab-name-function 'tab-bar-tab-name-current)
    (setq tab-bar-tab-name-function #'+tab-bar-name-fn)

    ;;;###autoload
    (defun +tab-bar-name-fn ()
      (let* ((project-name (projectile-project-name))
             (buf-fname (buffer-file-name))
             (buf-name (buffer-name))
             (buf-dir (when buf-fname (file-name-directory buf-fname))))
        (cond
         ((member major-mode '(gh-notify-mode)) buf-name)

         ;; project.el
         ((and project-name
               (not (string-equal "-" project-name)))
          project-name)

         ((eq 'dired-mode major-mode)
          (projectile-project-name (projectile-project-root default-directory)))

         ((and buf-dir (projectile-project-p buf-dir))
          (projectile-project-name (projectile-project-root buf-dir)))

         (buf-dir buf-dir)

         ((not (string-match-p "\\*Minibuf" buf-name))
          buf-name))))

    (when (> emacs-major-version 28) ; emacs 29
      (setq tab-bar-auto-width t)
      (setq auto-resize-tab-bars t)) ;; 필요하다

    (setq tab-bar-format                    ; Emacs 28
          '(tab-bar-format-tabs-groups
            tab-bar-format-align-right
            tab-bar-format-global
            ))

    ;; C-x t 에 바인딩 되어 있다.
    ;; (defun tab-bar-switch-to-tab@override (name)
    ;;   "Like `tab-bar-switch-to-tab', but allow for the creation of a new, named tab on the fly."
    ;;   (interactive
    ;;    (let* ((recent-tabs (mapcar (lambda (tab)
    ;;                                  (alist-get 'name tab))
    ;;                                (tab-bar--tabs-recent))))
    ;;      (list (completing-read (format-prompt "Switch to tab by name"
    ;;                                            (car recent-tabs))
    ;;                             recent-tabs nil nil nil nil recent-tabs))))
    ;;   (if-let ((tab-number (tab-bar--tab-index-by-name name)))
    ;;       (tab-bar-select-tab (1+ tab-number))
    ;;     (tab-bar-new-tab)
    ;;     (tab-bar-rename-tab name)))
    ;; (advice-add #'tab-bar-switch-to-tab :override #'tab-bar-switch-to-tab@override)

    ;; (defun my/project-open-in-tab (project)
    ;;   (interactive (list (project-prompt-project-dir)))
    ;;   (if-let ((tab-number (tab-bar--tab-index-by-name
    ;;                         (file-name-nondirectory (directory-file-name project)))))
    ;;       (tab-bar-select-tab (1+ tab-number))
    ;;     (tab-bar-new-tab)
    ;;     (project-switch-project project)
    ;;     (tab-bar-rename-tab (file-name-nondirectory (directory-file-name project)))))

    (require 'keycast)
    (defun my/reload-tab-bar ()
      (interactive)
      (setq tab-bar-show nil)
      (tab-bar-history-mode -1)
      (display-time-mode -1)
      (keycast-tab-bar-mode -1)
      (tab-bar-mode -1)

      ;; (tabspaces-mode 1) ; tabspaces

      (setq tab-bar-show t)
      (tab-bar-history-mode 1)
      (display-time-mode 1)
      (keycast-tab-bar-mode 1)
      (tab-bar-mode 1)

      ;; (tab-new)
      ;; (tab-bar-select-tab 1)
      ;; finally turn on centaur-tabs
      ;; (centaur-tabs-mode t)
      )
    )

    ;;;; Enable Hook
  ;; explicitly re-enable the cat for the first GUI client
  ;; 순서 상으로 먼저 탭바를 로드하고 테마를 로딩하는게 맞다.
  ;; (when (> emacs-major-version 28) ; emacs 29
  (add-hook 'after-init-hook #'my/reload-tab-bar)
  ;; )

  ) ; end-of tab-bar
```


### persp-mode with tab-bar {#persp-mode-with-tab-bar}

<span class="timestamp-wrapper"><span class="timestamp">[2023-06-01 Thu]</span></span>
탭바와 통합을 하려고 한다.

```elisp
;; https://github.com/Bad-ptr/persp-mode.el/issues/122
(defun jh-workspace/post-init-persp-mode ()
  (require 'tab-bar)

  ;; Tab Bar maintains window layouts (with optional names). In this, it is
  ;; similar to Perspective. Unlike Perspective, it does not support buffer
  ;; lists. Using Perspective and Tab Bar at the same time is not recommended at
  ;; this time, since the tab list is global (i.e., will show up in all
  ;; perspectives) and is likely to cause confusion. It would be an interesting
  ;; future feature for ?Perspective to adopt the tab bar and allow keeping a
  ;; distinct set of tabs per-perspective.

  (add-hook
   'persp-before-deactivate-functions
   (defun +workspaces-save-tab-bar-data-h (_)
     (when (get-current-persp)
       (set-persp-parameter
        'tab-bar-tabs (tab-bar-tabs)))))

  (add-hook
   'persp-activated-functions
   (defun +workspaces-load-tab-bar-data-h (_)
     (tab-bar-tabs-set (persp-parameter 'tab-bar-tabs))
     (tab-bar--update-tab-bar-lines t)))

  )

;; The snippet saves the configuration of tab-bar to files:
;; (add-hook
;;  'persp-before-save-state-to-file-functions
;;  (defun +workspaces-save-tab-bar-data-to-file-h (&rest _)
;;    (when (get-current-persp)
;;      (set-persp-parameter 'tab-bar-tabs (frameset-filter-tabs (tab-bar-tabs) nil nil t))
;;      )
;;    )
```


### Advanced Group-buffer `Bufler` {#advanced-group-buffer-bufler}

2023-04-20 ibuffer persp grouping 하고 이건 끄자.
ibuffer 레이어가 있지만 bufler 를 사용하기로 한다. 상세한 설정은 DW 님 닷에서 가져옴
세팅을 use-packge 로 하고 bind, init 에 아래와 같이 키바인딩을 넣어야
기존 키 바인딩을 뒤 엎고 처리가 된다. 허어.

```elisp
(defun jh-workspace/init-bufler ()
  (use-package bufler
    :demand
    :commands (bufler bufler-list)
    :init
    (global-set-key (kbd "C-x B") 'bufler-list)

    ;; M-m 누르면 Spacemacs Root 키바인딩 -> b B 누르면 된다. 이게 더 분류상 편하다.
    ;; (spacemacs/set-leader-keys "bB" 'consult-buffer)
    (spacemacs/set-leader-keys "bf" 'bufler-list)
    (spacemacs/set-leader-keys "bF" 'bufler-switch-buffer) ; I -> S
    ;; (spacemacs/set-leader-keys "bK" 'bufler-workspace-frame-set)

    (evil-define-key '(motion normal visual) bufler-list-mode-map
      (kbd "RET") 'bufler-list-buffer-switch
      (kbd "M-RET") 'bufler-list-buffer-peek
      (kbd "D") 'bufler-list-buffer-kill
      )

    ;; (evil-collection-define-key 'normal 'bufler-list-mode-map
    ;;  (kbd "RET") 'bufler-list-buffer-switch
    ;;  (kbd "M-RET") 'bufler-list-buffer-peek
    ;;  "D" 'bufler-list-buffer-kill)
    :config
    (setf bufler-groups
          (bufler-defgroups
            ;; Subgroup collecting all named workspaces.
            (group (auto-workspace))
            ;; Subgroup collecting buffers in a projectile project.
            (group (auto-projectile))
            (group
             ;; Subgroup collecting all `help-mode' and `info-mode' buffers.
             (group-or "Help/Info"
                       (mode-match "*Help*" (rx bos (or "help-" "helpful-")))
                       (mode-match "*Helpful*" (rx bos "helpful-"))
                       (mode-match "*Info*" (rx bos "info-"))))
            (group
             ;; Subgroup collecting all special buffers (i.e. ones that are not
             ;; file-backed), except `magit-status-mode' buffers (which are allowed to fall
             ;; through to other groups, so they end up grouped with their project buffers).
             (group-and "*Special*"
                        (name-match "**Special**"
                                    (rx bos "*" (or "Messages" "Warnings" "scratch" "Backtrace" "Pinentry") "*"))
                        (lambda (buffer)
                          (unless (or (funcall (mode-match "Magit" (rx bos "magit-status"))
                                               buffer)
                                      (funcall (mode-match "Dired" (rx bos "dired"))
                                               buffer)
                                      (funcall (auto-file) buffer))
                            "*Special*"))))
            ;; Group remaining buffers by major mode.
            (auto-mode)))
    )
  )
```


## Keybindings {#keybindings}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
```


### tab-bar next / previous {#tab-bar-next-previous}

```elisp
;; Replace Emacs Tabs key bindings with Workspace key bindings
(when (> emacs-major-version 28) ; emacs 29
  (with-eval-after-load 'evil-maps
    (when (featurep 'tab-bar)
      ;; vim-style tab switching
      (define-key evil-motion-state-map "gt" 'tab-next)
      (define-key evil-motion-state-map "gT" 'tab-previous)
      (define-key evil-normal-state-map "gt" 'tab-next)
      (define-key evil-normal-state-map "gT" 'tab-previous)
      ))
  )
```


### <span class="org-todo done OFF">OFF</span> buffer management {#buffer-management}

```elisp
;; Persp grouping
;; (global-set-key (kbd "C-x C-b") #'(lambda (arg) (interactive "P") (with-persp-buffer-list () (ibuffer arg))))
```
