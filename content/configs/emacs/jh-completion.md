+++
title = "jh-completion layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-21T10:28:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-completion
{{< /hint >}}

<!--more-->


## Goals {#goals}

-   [X] compleseus layer
-   [X] corfu
-   [X] misc
-   [X] reload emacs and test


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
   ;; auto-yasnippet yasnippet yasnippet-snippets
   (auto-completion :packages (hippie-exp smartparens yasnippet))
   (compleseus :variables
               compleseus-engine 'vertico
               vertico-resize 'grow-only
               marginalia-align 'left
               completion-ignore-case nil ; default nil
               read-file-name-completion-ignore-case nil ; default nil
               )
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

;;;; Package Lists

(defconst jh-completion-packages
  '(
    ;; 재정의 패키지
    embark
    consult

    ;; 새로 등록하는 패키지
    ;; consult-eglot
    ;; consult-dir

    corfu
    cape
    tempel
    (cape-yasnippet :location (recipe :fetcher github
                                      :repo "elken/cape-yasnippet"))
    ;; (tabnine-capf :location (recipe :fetcher github
    ;;                                 :repo "50ways2sayhard/tabnine-capf"
    ;;                                 :files ("*.el" "*.sh")))

    ;; (vertico-buffer
    ;;   :location (recipe :fetcher url
    ;;                     :url "https://raw.githubusercontent.com/minad/vertico/main/extensions/vertico-buffer.el"))
    ;; (mini-popup :location (recipe :fetcher github :repo "minad/mini-popup"))
    ;; (vertico-posframe :location (recipe :fetcher github :repo "tumashu/vertico-posframe"))
    ;; (vertico-multiform
    ;;  :location (recipe :fetcher url
    ;;                    :url "https://raw.githubusercontent.com/minad/vertico/main/extensions/vertico-multiform.el"))

    ))
```


### <kbd>Compleseus Layer</kbd> vectico with orderless and marginalia {#compleseus-layer-vectico-with-orderless-and-marginalia}

이거 모르면 자동완성 덕분에(?) 애먹는다. 자동완성 무시하고 입력 값만 사용!
`M-RET`          vertico-exit-input

Compleseus 레이어 문서를 보면 vectico 패밀리 패키지가 잘 정리되어 있다. 몇 가지
수정 사항만 여기에 다룬다.

[GitHub - minad/vertico: vertico.el - VERTical Interactive COmpletion](https://github.com/minad/vertico)
이만한 패키지가 어디 있겠나!

-   vertico-buffer: vertico-buffer-mode to display Vertico in a separate buffer.
-   vertico-directory: Commands for Ido-like directory navigation.
-   vertico-indexed: vertico-indexed-mode to select indexed candidates with prefix arguments.
-   vertico-mouse: vertico-mouse-mode to support for scrolling and candidate selection.
-   vertico-multiform: Configure Vertico modes per command or completion category.
-   vertico-quick: Commands to select using Avy-style quick keys.
-   vertico-repeat: The command vertico-repeat repeats the last completion session.
-   vertico-reverse: vertico-reverse-mode to reverse the display.
-   vertico-unobtrusive: vertico-unobtrusive-mode displays only the topmost candidate.
-   vertico-flat: vertico-flat-mode to enable a flat, horizontal display.
-   vertico-grid: vertico-grid-mode to enable a grid display.


#### Actions via <kbd>embark</kbd> {#actions-via-embark}

```elisp
;;;; Embark

(defun jh-completion/post-init-embark ()
  (require 'embark)
  ;; By default, embark doesn't know how to handle org-links.  Let's provide a way.
  (defun ash/org-link ()
    "Get the link from an org-link."
    (require 's)
    (let ((context (org-element-context)))
      (cond ((and (eq (car context) 'link)
                  (equal (plist-get (cadr context) :type) "file"))
             (cons 'file (plist-get (cadr context) :path)))
            ((and (eq (car context) 'link)
                  (member (plist-get (cadr context) :type) '("http" "https")))
             (cons 'url (concat (plist-get (cadr context) :type) ":" (s-trim-right (plist-get (cadr context) :path)))))
            (t nil))))
  (add-to-list 'embark-target-finders 'ash/org-link)
  )
```


### <kbd>Corfu</kbd> Completion UI {#corfu-completion-ui}

2023-05-04 전체적으로 튜닝
/home/junghan/sync/man/dotsamples/vanilla/chrisbarrett-dotfiles/config.org

```elisp
;;;; Corfu

(defun jh-completion/init-corfu ()
  (use-package corfu
    :after evil-collection
    :demand t
    :bind (:map corfu-map
                ("M-." . corfu-move-to-minibuffer)
                ;; ("M-d" . corfu-show-documentation)
                ("M-l" . 'corfu-show-location)
                )
    :custom
    (corfu-auto t) ; Enable auto completion
    (corfu-cycle t)            ;; Enable cycling for `corfu-next/previous'
    ;; (corfu-min-width 25) ; default 15

    (corfu-auto-prefix 1)
    (corfu-auto-delay 0.20)

    ;; (corfu-count 14)
    ;; (corfu-scroll-margin 4)
    ;; Also here to be extra-safe that this is set when `corfu-popupinfo' is
    ;; loaded. I do not want documentation shown in both the echo area and in
    ;; the `corfu-popupinfo' popup.
    ;; (corfu-echo-documentation nil)

    ;; (corfu-bar-width 0.5)
    ;; /home/junghan/sync/man/dotsamples/vanilla/jwiegley-dot-files/init.org
    ;; (corfu-separator ?\s)          ;; Orderless field separator : SPC
    ;; ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
    ;; ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
    ;; (corfu-quit-no-match 'separator) ;; or t
    ;; ;; (corfu-preview-current nil)    ;; Disable current candidate preview
    ;; ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
    ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
    :init
    ;; TAB cycle if there are only few candidates
    ;; (setq completion-cycle-threshold 3)
    (setq completion-cycle-threshold nil)      ; Always show candidates in menu
    ;; Enable indentation+completion using the TAB key.
    ;; `completion-at-point' is often bound to M-TAB.
    (setq tab-always-indent 'complete)

    ;; (setq completion-ignore-case t)
    ;; (setq read-buffer-completion-ignore-case t)
    ;; (setq read-file-name-completion-ignore-case t)
    ;; (setq-default case-fold-search t)   ; For general regexp
    (setq read-file-name-completion-ignore-case t)

    (require 'corfu-history)
    (require 'corfu-popupinfo)

    (set-face-attribute 'corfu-popupinfo nil :height 0.95)
    ;; (setq corfu-echo-documentation nil)

    (setq corfu-popupinfo-delay 0.2) ; 0.5
    ;; (setq corfu-popupinfo-max-width 70)
    ;; (setq corfu-popupinfo-max-height 20)

    :config
    (with-eval-after-load 'evil
      (define-key corfu-map (kbd "C-j") 'corfu-next)
      (define-key corfu-map (kbd "C-k") 'corfu-previous)
      ;; C-n and C-p are defaults next/previous

      (define-key corfu-map (kbd "M-n") 'corfu-popupinfo-scroll-up)
      (define-key corfu-map (kbd "M-p")  'corfu-popupinfo-scroll-down)

      (define-key corfu-map (kbd "M-h") 'corfu-popupinfo-toggle)

      (define-key corfu-map (kbd "C-SPC") 'corfu-insert-separator) ; also use M-SPC
      (define-key corfu-map (kbd "C-g") 'corfu-quit)

      (define-key corfu-popupinfo-map (kbd "C-v") 'corfu-popupinfo-scroll-up)
      (define-key corfu-popupinfo-map (kbd "M-v") 'corfu-popupinfo-scroll-down)
      )

    (evil-define-key 'insert corfu-map
      (kbd "C-v") 'corfu-popupinfo-scroll-up ; remap
      (kbd "M-v") 'corfu-popupinfo-scroll-down
      )

    ;; (defun corfu-move-to-minibuffer ()
    ;;   (interactive)
    ;;   (let (completion-cycle-threshold completion-cycling)
    ;;     (apply #'consult-completion-in-region completion-in-region--data)))

    ;; (defun corfu-enable-in-minibuffer ()
    ;;   "Enable Corfu in the minibuffer if `completion-at-point' is bound."
    ;;   (when (where-is-internal #'completion-at-point (list (current-local-map)))
    ;;     ;; (setq-local corfu-auto nil) Enable/disable auto completion
    ;;     (corfu-mode 1)))
    ;; (add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)

    ;; Show "eldoc" documentation immediately after the user confirms a candidate
                                        ; with "corfu" https://github.com/minad/corfu/issues/80
    (with-eval-after-load 'eldoc
      (eldoc-add-command #'corfu-insert)
      )

    (global-corfu-mode)
    (corfu-history-mode 1)

    ;; define @ jh-base.org / pre-init-savehist
    ;; (add-to-list 'savehist-additional-variables 'corfu-history)

    (corfu-popupinfo-mode)

    ;; (with-eval-after-load 'evil-collection
    ;;   (advice-add 'evil-collection-corfu-setup :after
    ;;               (defun resert-corfu-esc ()
    ;;                 (general-def 'insert corfu-map "<escape>" 'nil))))
    )
  )

;; Setup lsp to use corfu for lsp completion
;;   (defun kb/corfu-setup-lsp ()
;;     "Use orderless completion style with lsp-capf instead of the
;; default lsp-passthrough."
;;     (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
;;           '(orderless)))
;; (add-hook 'lsp-completion-mode-hook #'kb/corfu-setup-lsp) ; use corfu for lsp completion
```


### <kbd>Cape</kbd> Completion At Point Extensions {#cape-completion-at-point-extensions}

<span class="timestamp-wrapper"><span class="timestamp">[2023-02-13 Mon 02:48]</span></span>
work with company backend
[GitHub - minad/cape: 🦸cape.el - Completion At Point Exten...](https://github.com/minad/cape#company-adapter)

2023-05-05 동작한다.
2023-05-04 여기에 사전 다루는게 다 들어 있다.
/agzam-dot-doom/modules/custom/completion/autoload/minad-capf.el
/agzam-dot-doom/modules/custom/completion/config.el

```elisp
;;;; CAPE : Completion At Point Extensions

(defun jh-completion/init-cape-yasnippet ()
  (use-package cape-yasnippet)
  )

(defun jh-completion/init-cape ()
  (use-package cape
    :demand t
    :config
    (require 'cape-yasnippet)

    ;; Enhances speed on large projects, for which many buffers may be open.
    ;; (setq cape-dabbrev-check-other-buffers nil) ; default t
    (setq cape-dabbrev-min-length 3)

    ;; 최소한으로 열어 두고 필요할 때 호출해서 확인한다.
    ;; Add `completion-at-point-functions', used by `completion-at-point'.
    ;; (add-to-list 'completion-at-point-functions #'cape-line) ; useless
    ;; (add-to-list 'completion-at-point-functions #'cape-abbrev)

    (defun cape-common-setup ()
      (add-to-list 'completion-at-point-functions #'cape-dabbrev)
      (add-to-list 'completion-at-point-functions #'cape-file)
      (add-to-list 'completion-at-point-functions #'cape-history)
      (add-to-list 'completion-at-point-functions #'cape-yasnippet)
      )

    (defun cape-text-mode-setup ()
      (add-to-list 'completion-at-point-functions #'cape-ispell)
      ;; (add-to-list 'completion-at-point-functions #'cape-dict) ; useless
      )

    (defun cape-prog-mode-setup ()
      (add-to-list 'completion-at-point-functions #'cape-symbol)
      (add-to-list 'completion-at-point-functions #'cape-keyword)
      )

    ;; 2023-05-05 로컬 후크가 아니라 바로 모드 훅으로 잡아 놔야 한다.
    (dolist (mode-hook '(prog-mode-hook text-mode-hook conf-mode-hook))
      (add-hook mode-hook #'cape-common-setup))

    (add-hook 'text-mode-hook 'cape-text-mode-setup)
    (add-hook 'prog-mode-hook 'cape-prog-mode-setup)

    (define-prefix-command 'my-cape-map)
    (define-key global-map (kbd "M-c") 'my-cape-map)
    (let ((map my-cape-map))
      (define-key map (kbd "p") 'completion-at-point)
      (define-key map (kbd "t") 'complete-tag)
      (define-key map (kbd "d") 'cape-dabbrev)
      (define-key map (kbd "e") 'hippie-expand)
      (define-key map (kbd "h") 'cape-history)
      (define-key map (kbd "y") 'cape-yasnippet)
      (define-key map (kbd "f") 'cape-file)
      (define-key map (kbd "k") 'cape-keyword)
      (define-key map (kbd "s") 'cape-symbol)
      (define-key map (kbd "a") 'cape-abbrev)
      (define-key map (kbd "l") 'cape-line)
      (define-key map (kbd "w") 'cape-dict)
      (define-key map (kbd "r") 'cape-rfc1345)
      (define-key map (kbd "\\") 'cape-tex)
      )

     ;;;; https://github.com/minad/cape#company-adapter

    ;; The advices are only needed on Emacs 28 and older.
    (when (< emacs-major-version 29) ; emacs 28
      ;; Silence the pcomplete capf, no errors or messages!
      (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
      ;; Ensure that pcomplete does not write to the buffer
      ;; and behaves as a pure `completion-at-point-function'.
      (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify))
    )
  )
```


#### <span class="org-todo todo TODO">TODO</span> `cape-yasnippet` {#cape-yasnippet}

| <kbd>M-/</kbd>     | Expand a snippet if text before point ... |
|--------------------|-------------------------------------------|
| <kbd>SPC i s</kbd> | List all current yasnippets               |

스니펫이 제대로 동작하는가 확인해봐라.
_yasnippet-snippets-1.0_
_clojure-snippets-20220914.950_

`auto-coimpletion` 레이어에 스니펫을 다 빼고 따로 넣어야 한다.
그리고 Tempel 로 넘어가자.

Deprecate in favour of tempel.

```elisp
  ;; yasnippet globally on and check yas-snippet-dirs
  ;; ("/home/junghan/.spacemacs.d/snippets"
  ;; "/home/junghan/spacemacs/core/../private/snippets/"
  ;; "/home/junghan/spacemacs/layers/+completion/auto-completion/local/snippets"
  ;; "/home/junghan/spacemacs/elpa/29.0/develop/clojure-snippets-20220914.950/snippets"
  ;; yasnippet-snippets-dir)

  ;; (use-package yasnippet
  ;;   :config
  ;;   (yas-reload-all)
  ;;   (add-to-list 'yas-snippet-dirs "~/.config/emacs-vanilla/snippets")
  ;;   (yas-global-mode 1))

  (defun jh-completion/init-cape-yasnippet ()
    (use-package cape-yasnippet
      :after cape yasnippet
      :config

      (defun cape-yasnippet-setup-capf ()
        ;; Add the Tempel Capf to `completion-at-point-functions'.
        ;; `tempel-expand' only triggers on exact matches. Alternatively use
        ;; `tempel-complete' if you want to see all matches, but then you
        ;; should also configure `tempel-trigger-prefix', such that Tempel
        ;; does not trigger too often when you don't expect it. NOTE: We add
        ;; `tempel-expand' *before* the main programming mode Capf, such
        ;; that it will be tried first.

        ;; Tempel Capf를 `completion-at-point-functions'에 추가하십시오. `tempel-expand'는
        ;; 정확히 일치하는 경우에만 트리거됩니다. 또는 모든 일치 항목을 보려면
        ;; `tempel-complete'를 사용하지만 예상하지 못한 경우 Tempel이 너무 자주 트리거되지
        ;; 않도록 `tempel-trigger-prefix'도 구성해야 합니다. 참고: 기본 프로그래밍 모드인
        ;; Capf *앞에* `tempel-expand'를 추가하여 먼저 시도되도록 합니다.
        (setq-local completion-at-point-functions
                    (cons #'cape-yasnippet
                          completion-at-point-functions)))
      ;; Setup completion at point - 먼저 실행 되게 해야하는구나. 끈다.
      ;; (defun tempel-setup-capf ()
      ;;   (add-to-list 'completion-at-point-functions #'tempel-expand))

      (add-hook 'text-mode-hook 'cape-yasnippet-setup-capf)
      (add-hook 'prog-mode-hook 'cape-yasnippet-setup-capf)
      ))

  ;; To avoid auto-expanding snippets
  ;; (plist-put cape-yasnippet--properties :exit-function #'always)
  ;; (defun +cape-yasnippet--setup-h ()
  ;;   (when (and (bound-and-true-p yas-minor-mode))
  ;;     (add-to-list 'completion-at-point-functions #'cape-yasnippet t)))
  ;; (dolist (mode-hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  ;;   (add-hook mode-hook #'+cape-yasnippet--setup-h)))
```


### <kbd>Tempel</kbd> Simple templates for Emacs {#tempel-simple-templates-for-emacs}

재미있는 템플릿 활용법을 알게되었다.
[GitHub - minad/tempel: TempEl - Simple templates for Emacs](https://github.com/minad/tempel)

```elisp
;;;; Tempel

;; Template-based in-buffer completion (tempel.el)
;; NOTE 2023-01-19: Check the `templates'

(defun jh-completion/init-tempel ()
  (use-package tempel
    :after cape
    :bind (("M-+" . tempel-complete) ;; Alternative tempel-expand
           ("M-*" . tempel-insert))
    :init
    ;; (setq tempel-trigger-prefix "<") ; conflits with evil-shift
    (setq tempel-path (expand-file-name "tempel-templates.eld" dotspacemacs-directory))

    :config
    ;; Setup completion at point
    (defun tempel-setup-capf ()
      ;; Add the Tempel Capf to `completion-at-point-functions'.
      ;; `tempel-expand' only triggers on exact matches. Alternatively use
      ;; `tempel-complete' if you want to see all matches, but then you
      ;; should also configure `tempel-trigger-prefix', such that Tempel
      ;; does not trigger too often when you don't expect it. NOTE: We add
      ;; `tempel-expand' *before* the main programming mode Capf, such
      ;; that it will be tried first.

      ;; Tempel Capf를 `completion-at-point-functions'에 추가하십시오. `tempel-expand'는
      ;; 정확히 일치하는 경우에만 트리거됩니다. 또는 모든 일치 항목을 보려면
      ;; `tempel-complete'를 사용하지만 예상하지 못한 경우 Tempel이 너무 자주 트리거되지
      ;; 않도록 `tempel-trigger-prefix'도 구성해야 합니다. 참고: 기본 프로그래밍 모드인
      ;; Capf *앞에* `tempel-expand'를 추가하여 먼저 시도되도록 합니다.
      (setq-local completion-at-point-functions
                  (cons #'tempel-expand
                        completion-at-point-functions)))

    ;; Setup completion at point - 먼저 실행 되게 해야하는구나. 끈다.
    ;; (defun tempel-setup-capf ()
    ;;   (add-to-list 'completion-at-point-functions #'tempel-expand))

    (add-hook 'text-mode-hook 'tempel-setup-capf)
    (add-hook 'prog-mode-hook 'tempel-setup-capf)

    (defun tempel-hippie-try-expand (old)
      "Integrate with hippie expand.
    Just put this function in `hippie-expand-try-functions-list'."
      (if (not old)
          (tempel-expand t)
        (undo 1)))
    (add-to-list 'hippie-expand-try-functions-list #'tempel-hippie-try-expand t)

    ;; Use concrete keys because of org mode
    ;; "M-RET" #'tempel-done
    ;; "M-{" #'tempel-previous
    ;; "M-}" #'tempel-next
    ;; "M-<up>" #'tempel-previous
    ;; "M-<down>" #'tempel-next
    (define-key tempel-map (kbd "RET") #'tempel-done)
    (define-key tempel-map (kbd "C-j") #'tempel-next)
    (define-key tempel-map (kbd "C-k") #'tempel-previous)
    )
  )
```


### Turn off <kbd>Auto-preview</kbd> using Consult {#turn-off-auto-preview-using-consult}

preview 설정을 변경하려고 한다. 애용하는 consult-line 의 경우
자동 preview 때문에 반응이 늦다. preview-key 를 누를 경우만 보이도록 하자.
다음 키를 이용하면 훨씬 효율적으로 탐색할 수 있다.

2023-02-01 consult-preview 엄청난 문제가 있었다. invalid-key 가
발생하는데 해결은 minad 패키지를 모두 gnu 버전으로 pinned 했다.
업데이트 자주 하는 게 정답이 아니다.

2023-02-08 버전 업을 하면 문제가 발생했다. 아래 키 바인딩이 문제였다.
아래와 같이 설정해서 해결했다.

2023-03-06 compleseus 설정이 바뀌었다. 나의 키바인딩이 더 나은 것 같다.
아래와 같이 일부 수정한다.

2023-04-30 커스텀을 바쿤다. 기본으로

```elisp
;;;; Consult

(defun jh-completion/pre-init-consult ()
  (spacemacs|use-package-add-hook consult
    :post-config
    (consult-customize
     consult-theme
     :preview-key '("M-." "C-SPC"
                    :debounce 3.0 any) ; 2 seconds

     ;; For `consult-line' change the prompt and specify multiple preview
     ;; keybindings. Note that you should bind <S-up> and <S-down> in the
     ;; `minibuffer-local-completion-map' or `vertico-map' to the commands which
     ;; select the previous or next candidate.
     consult-buffer
     consult-ripgrep consult-git-grep consult-grep

     consult-bookmark consult-yank-pop

     ;; add more consult functions
     consult-recent-file consult-xref
     consult-org-heading
     consult-outline ; 2023-05-23

     ;; consult--source-recent-file consult--source-project-recent-file consult--source-bookmark
     spacemacs/compleseus-search-auto
     spacemacs/compleseus-search-dir
     spacemacs/compleseus-find-file ; 2023-05-14 추가
     ;; spacemacs/compleseus-search-project-el ; 2023-05-23
     ;; spacemacs/compleseus-search-project-el-auto ; 2023-05-23
     spacemacs/embark-preview ; 2023-05-23
     spacemacs/compleseus-search-default
     consult-line ; :prompt "Consult-line: "
     :preview-key '("M-." "C-SPC"
                    ;; :debounce 0.3 "C-M-j" "C-M-k" ; conflict puni
                    :debounce 0.3 "<up>" "<down>" "C-n" "C-p"
                    ))
    )
  )
```
