+++
title = "jh-editing layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:50:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-editing
{{< /hint >}}

<!--more-->


## Goals {#goals}

편집은 쓰고, 찾고, 수정하고, 나아가 퍼블리시까지 포함한다. 단계를 나눠서
정리하면 좋겠다. 퍼블은 지식 관리자에서 한다

-   spacemacs-editing
-   spacemacs-editing-visual
-   spacemacs-evil
-   evil-snipe
-   multi-cursors
-   copy-as-format


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
   copy-as-format

   ;; `g r' menu in Emacs normal state
   ;; 'evil-mc' vs. 'mc'
   (multiple-cursors :variables
                     multiple-cursors-backend 'mc
                     mc/cmds-to-run-once '(upcase-region))

   (xclipboard :variables xclipboard-enable-cliphist t)

   (spacemacs-editing
    ;; not  password-generator drag-stuff undo-tree
    :packages
    (aggressive-indent dired-quick-sort editorconfig eval-sexp-fu
                       smartparens spacemacs-whitespace-cleanup pcre2el
                       string-edit-at-point uuidgen evil-easymotion
                       expand-region hexl ws-butler unkillable-scratch
                       hungry-delete persistent-scratch string-inflection
                       avy link-hint lorem-ipsum evil-swap-keys
                       ))

   (spacemacs-editing-visual
    :packages (hide-comnt
               rainbow-delimiters
               volatile-highlights
               writeroom-mode
               term-cursor
               ))

   (spacemacs-evil
    :packages (evil-anzu evil-args evil-collection evil-escape
                         evil-exchange evil-iedit-state evil-indent-plus evil-lion
                         evil-nerd-commenter evil-matchit
                         evil-numbers evil-surround evil-textobj-line evil-unimpaired
                         evil-visual-mark-mode evil-visualstar evil-tutor
                         ;; evil-lisp-state evil-cleverparens
                         ;; evil-goggles
                         eldoc hs-minor-mode)
    :variables
    spacemacs-evil-collection-allowed-list
    '(dired wdired quickrun ediff  ; delete 'eww'
            xref eglot flymake tar-mode speedbar
            tab-bar man outline dashboard shortdoc info
            tar-mode thread ;; BUILT-IN
            devdocs corfu youtube-dl rg deadgrep leetcode
            dired-sidebar disk-usage ;; wgrep
            emms ebuku ))

   (evil-snipe :variables evil-snipe-enable-alternate-f-and-t-behaviors t)

   ;; vim-empty-lines ; Never!
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
(defconst jh-editing-packages
  '(
    ;; 재정의 패키지
    xref
    evil-escape
    ;; evil-visualstar

    ;; 새로 등록하는 패키지
    visual-regexp
    rg ; ripgrep tool with wgrep
    affe ; async fuzzy finder
    deadgrep ; ripgrep tool
    find-file-in-project
    unfill
    undo-fu
    puni
    ;; fd-dired
    ;; undo-fu-session
    ;; vundo
    ;; (holymotion :location (recipe :fecther github :repo "Overdr0ne/holymotion"))
    ;; evil-multiedit
    ;; pulsar
    ;; paren-face
    ))
```


### xref  built-in {#xref-built-in}

```elisp
(defun jh-editing/post-init-xref ()
  (setq xref-file-name-display 'project-relative)
  (setq xref-search-program 'ripgrep)) ; default grep
```


### Undo-fu and Vundo {#undo-fu-and-vundo}

<span class="timestamp-wrapper"><span class="timestamp">[2022-12-14 Wed 09:37]</span></span>
undo-tree 가 성능의 문제를 주기에 undo-fu 를 기본으로 하고 undo-fu-session 을 고려
하고자 한다.

-   built-in undo/redo (28 ~)
-   undo-fu
-   undo-tree

<!--listend-->

```elisp
(defun jh-editing/init-undo-fu ()
  ;; Increase undo history limits even more
  (use-package undo-fu
    :ensure t
    :config
    ;; C-r 은 isearch-backward 가 기본
    (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
    (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo)

    ;; Undo-fu customization options
    ;; Undoing with a selection will use undo within that region.
    (setq undo-fu-allow-undo-in-region t)
    ;; Use the `undo-fu-disable-checkpoint' command instead of Ctrl-G `keyboard-quit' for non-linear behavior.
    (setq undo-fu-ignore-keyboard-quit t)
    ;; By default while in insert all changes are one big blob. Be more granular
    (setq evil-want-fine-undo t)
    )
  )

;; (use-package undo-fu-session :after undo-fu
;;     :functions undo-fu-session-global-mode
;;     :config (undo-fu-session-global-mode))

;; visualize undo-tree
;; (use-package vundo
;;   :defer t
;;   :init
;;   (defconst +vundo-unicode-symbols
;;     '((selected-node   . ?●)
;;       (node            . ?○)
;;       (vertical-stem   . ?│)
;;       (branch          . ?├)
;;       (last-branch     . ?╰)
;;       (horizontal-stem . ?─)))
;;   :config
;;   (setq vundo-glyph-alist +vundo-unicode-symbols
;;         vundo-compact-display t
;;         vundo-window-max-height 6)
;;   (spacemacs/set-leader-keys "tV" 'vundo)
;;   )
```


### Let's Be Evil {#let-s-be-evil}

수정해보자.  <span class="timestamp-wrapper"><span class="timestamp">[2022-12-16 Fri 07:26]</span></span>

```elisp
(defun jh-editing/init-unfill ()
  (require 'unfill)
  (global-set-key (kbd "C-M-q") 'unfill-paragraph))

;; DONE isearch minibuffer 에서 이동할 방법이 없어서 끈다.
;; Emacs 기본 C-f/b forward-char backward-char 가 가능한지 검토 바람
;; copy from DW
;; (defun dw/dont-arrow-me-bro ()
;;   (interactive)
;;   (message "Arrow keys are bad, you know?"))
;; ;; Disable arrow keys in normal and visual modes
;; (define-key evil-normal-state-map (kbd "<left>") 'dw/dont-arrow-me-bro)
;; (define-key evil-normal-state-map (kbd "<right>") 'dw/dont-arrow-me-bro)
;; (define-key evil-normal-state-map (kbd "<down>") 'dw/dont-arrow-me-bro)
;; (define-key evil-normal-state-map (kbd "<up>") 'dw/dont-arrow-me-bro)
;; (evil-global-set-key 'motion (kbd "<left>") 'dw/dont-arrow-me-bro)
;; (evil-global-set-key 'motion (kbd "<right>") 'dw/dont-arrow-me-bro)
;; (evil-global-set-key 'motion (kbd "<down>") 'dw/dont-arrow-me-bro)
;; (evil-global-set-key 'motion (kbd "<up>") 'dw/dont-arrow-me-bro)

;; C-g 기본 함수는 keyboard-quit
;; C-g back to normal state
;; (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
```


### evil-escape {#evil-escape}

```elisp
(defun jh-editing/post-init-evil-escape ()
  ;; evil-escape - switch between insert and normal state
  ;; fd는 ㄹㅇ일 때 적용이 안되니 ,.을 입력 시 escape하도록 바꿈.
  ;; unordered로 해보니 minor-mode를 열기도 해서 아예 논란이 없도록 바꿈.
  (setq-default evil-escape-key-sequence ",.")
  (setq-default evil-escape-unordered-key-sequence nil)
  (setq-default evil-escape-delay 1.0) ;; 0.5, default 0.1
  ;; (setq-default evil-escape-inhibit-functions nil)
  (evil-escape-mode)
  ;; (add-to-list 'evil-escape-excluded-major-modes 'code-review-mode)
  )
```


### Search/Symbol {#search-symbol}


#### `rg` ripgrep and wgrep {#rg-ripgrep-and-wgrep}

URL: <https://github.com/dajva/rg.el>
[Usage — rg.el 2.3.0 documentation](https://rgel.readthedocs.io/en/latest/usage.html#installation)

설정은 간단하게

```elisp
;;;;; ripgrep + wgrep
(defun jh-editing/init-rg ()
  (use-package rg
    :after consult
    :config
    (rg-enable-default-bindings) ;; use =C-c s=
    (global-set-key (kbd "M-s r") 'rg-menu)
    (global-set-key (kbd "M-s g") 'consult-ripgrep)
    (spacemacs/set-leader-keys "sr" 'rg-menu)
    (spacemacs/set-leader-keys "sg" 'consult-ripgrep)
    ))
```

<!--list-separator-->

-  READ Usages

    메뉴로 가서 따라 해본다. -h 입력하면 hidden 폴더 검색한다.
    .emacs.d 는 hidden 폴더니까 옵션 없으면 검색 안된다. .git 폴더는
    기본 제외 된다. 옵션이 있다.

    ```text
    -*- mode: rg; default-directory: "~/sync/man/dotsamples/vanilla/" -*-
    rg started at Wed Apr 19 17:46:19

    /usr/bin/rg --color=always --colors=match:fg:red --colors=path:fg:magenta --colors=line:fg:green --colors=column:none -n --column -i --hidden --heading --no-config --type=elisp -e ekg

    File: ahyatt-dotfiles/.emacs.d/init.el
     430  30   (pretty-hydra-define hydra-ekg ()
     432  12      (("t" ekg-show-notes-for-today "today" :exit t)
     433  12       ("g" ekg-show-notes-with-tag "tag" :exit t)
     434  12       ("r" ekg-show-notes-latest-captured "latest" :exit t)
     435  12       ("b" ekg-embedding-show-similar-to-current-buffer "similar to buffer" :exit t)
     436  12       ("s" ekg-embedding-search "search" :exit t))
     438  12      (("c" ekg-capture)
     516  18       ("k" hydra-ekg/body "ekg" :exit t)
     828  14 (use-package ekg
     829  15   :straight '(ekg :type git :host github :repo "ahyatt/ekg")
     831  13   ("<f11>" 'ekg-capture)
     835   6     (ekg-capture-url (ash/get-current-url) (ash/get-current-title))))
    1147  24   (tab-bar-rename-tab "ekg" 2)

    rg finished (15 matches found) at Wed Apr 19 17:46:19
    ```

<!--list-separator-->

-  Edit and apply (wgrep)

    <span class="timestamp-wrapper"><span class="timestamp">[2023-05-03 Wed 14:02]</span></span>
    rg 로 검색한 다음에 수정을 어떻게 하는가?

    `C-c C-p` wgrep-mode 로 바꿔주고나서 수정하고 `Z Z` 입력하면 적용된다.
    엄청난 팁이다. 아마도 Embark 등 시나리오에서도 가능할 것 같다.
    개념을 몰라서 못했던 것이다.

    Edit and apply (wgrep)
    : The results buffer supports inline editing via the
        wgrep package. This is setup automatically when rg is loaded. e
        (wgrep-change-to-wgrep-mode) Make the search results editable by enabling
        wgrep mode. When done press C-c C-c to commit your changes to the underlying
        files or C-c C-k to drop the changes.


#### deadgrep {#deadgrep}

보다 커스텀이 가능한 ripgrep 이 필요하다.
예를 들어 . 폴더를 제외하거나 특정 폴더를 제외하는 검색이 되어야 한다.

```elisp
(defun jh-editing/init-deadgrep ()
  (use-package deadgrep
    :after consult
    :config
    (spacemacs/set-leader-keys "sR" 'deadgrep)
    (global-set-key (kbd "M-s R") 'deadgrep))
  )
```


#### find-file-in-project {#find-file-in-project}

find files with 'fd'

```elisp
(defun jh-editing/init-find-file-in-project ()
  ;; In emacs, run M-x find-file-in-project-by-selected to find matching files.
  ;; Alternatively, run M-x find-file-in-project to list all available files in
  ;; the project.
  (require 'find-file-in-project)
  (setq ffip-use-rust-fd t)
  (spacemacs/declare-prefix "sP"  "find-file✩")
  (spacemacs/set-leader-keys "sPc" 'find-file-in-current-directory-by-selected)
  (spacemacs/set-leader-keys "sPp" 'find-file-in-project-by-selected)
  )
```


#### affe {#affe}

```elisp
;;;;;; async fuzzy finder

(defun jh-editing/init-affe ()
  (use-package affe
    :after consult orderless
    :demand t
    :config
    ;; Use orderless to compile regexps
    (defun +affe-orderless-regexp-compiler (input _type _ignorecase)
      (setq input (orderless-pattern-compiler input))
      (cons input (lambda (str) (orderless--highlight input str))))

    (setq affe-regexp-compiler #'+affe-orderless-regexp-compiler)

    (global-set-key (kbd "M-s a") 'affe-grep)
    (global-set-key (kbd "M-s A") 'affe-find)
    (spacemacs/set-leader-keys "sa" 'affe-grep)
    (spacemacs/set-leader-keys "sA" 'affe-find)

    ;; Manual preview keys
    (consult-customize affe-grep affe-find
                       :preview-key '("M-n" "M-p"))
    ))
```


### Visual regexp {#visual-regexp}

정규식 관련 패키지. 연습하라!
[Regex Search and Replace in Emacs | Irreal](https://irreal.org/blog/?p=11041&utm_source=pocket_reader)
위 글을 보고 고민하던 차에 추가해놓는다.
(참고 영상) [Learn two ways to perform a string replacement with visual feedback - YouTube](https://youtu.be/Zm0XjD1sA_Q)

-   visual-regexp

[GitHub - benma/visual-regexp.el: A regexp/replace command for Emacs with inte...](https://github.com/benma/visual-regexp.el)

-   visual-regexp-steroids

[GitHub - benma/visual-regexp-steroids.el: Extends visual-regexp to support ot...](https://github.com/benma/visual-regexp-steroids.el/)

-   helm-regex : 설치되어 있네?!
-   35.3 Regular Expressions (EMACS Manual)
    [Regular Expressions (GNU Emacs Lisp Reference Manual)](https://www.gnu.org/software/emacs/manual/html_node/elisp/Regular-Expressions.html)

<!--listend-->

```elisp
(defun jh-editing/init-visual-regexp ()
  ;; EMACS-style regex support
  (require 'visual-regexp)
  (define-key global-map (kbd "C-c v r") 'vr/replace)
  (define-key global-map (kbd "C-c v q") 'vr/query-replace)
  )
;; (setq vr/match-separator-use-custom-face t)
;; if you use multiple-cursors, this is for you:
;; (define-key global-map (kbd "C-c v m") 'vr/mc-mark)
;; C-M-r isearch-backward-regexp : default binding
;; C-M-s isearch-forward-regexp
```


### `puni`  for replacing `smartparens` {#puni-for-replacing-smartparens}


#### Puni Configurations {#puni-configurations}

There’s a lot of really good editing tools. Puni is a more simple and modern
approach to structured editing, so let's use that. I used to use `smartparens`,
but it had a lot of issues where expressions becoming unbalanced in strict mode,
which is annoying, because then you have to get out of strict-mode to fix it.

```elisp
(defun jh-editing/init-puni ()
  (use-package puni
    :demand
    :diminish ""
    :hook (((calc-mode term-mode vterm-mode) . puni-disable-puni-mode) ; org-mode
           (puni-mode  . electric-pair-mode))
    :init
    ;; The default `puni-mode-map' respects "Emacs conventions".  We don't, so
    ;; it's better to simply clear and rewrite it.
    (setcdr puni-mode-map nil)

    (bind-keys
     :map puni-mode-map
     ("C-M-a" . puni-beginning-of-sexp)
     ("C-M-e" . puni-end-of-sexp)

     ;; ("C-" . sp-down-sexp)
     ;; ("C-"   . sp-up-sexp)
     ;; ("M-" . sp-backward-down-sexp)
     ;; ("M-"   . sp-backward-up-sexp)

     ("C-M-f" . puni-forward-sexp)
     ("C-M-b" . puni-backward-sexp)

     ;; ("C-M-n" . sp-next-sexp)
     ;; ("C-M-p" . sp-previous-sexp)

     ;; ("C-S-f" . sp-forward-symbol)
     ;; ("C-S-b" . sp-backward-symbol)

     ("C-<right>"  .  puni-slurp-forward)
     ("C-M-<right>" . puni-slurp-backward)
     ("C-<left>" . puni-barf-forward)
     ("C-M-<left>" .  puni-barf-backward)

     ("C-M-?" . puni-convolute)

     ;; puni-transpose
     ("C-M-t" . transpose-sexp)
     ;; ("C-x C-t" . sp-transpose-hybrid-sexp)

     ("C-M-k" . kill-sexp)
     ("M-k"   . backward-kill-sexp)
     ;; ("C-" . puni-backward-kill-word)

     ("M-)" . puni-syntactic-forward-punct)
     ("M-(" . puni-syntactic-backward-punct)

     ;; splicing
     ("C-M-<delete>" . puni-splice-killing-forward)
     ("C-M-<backspace>" . puni-splice-killing-backword)

     ("C-c DEL" . puni-force-delete)
     ;; ("C-M-d" . puni-forward-delete-char)
     ;; ("C-M-k" . puni-kill-line)
     ;; ("C-M-K" . puni-backward-kill-line)
     ;;  ("C-M-w" . puni-kill-region)

     ;; ("C-M-w" . sp-copy-sexp)
     ;; ("C-M-d" . delete-sexp)

     ;; ([remap puni-backward-kill-word] . backward-kill-word)

     ("C-M-z" . puni-squeeze) ; unwrap

     ("C-c (" . puni-wrap-round)
     ("C-c [" . puni-wrap-square)
     ("C-c {" . puni-wrap-curly)
     )
    :config
    (puni-global-mode t)
    )
  )

;;   :config
;;   (defun puni-kill-thing-at-point (&optional arg)
;;     "Kill the next puni based thing at point"
;;     (interactive)
;;     (unless buffer-read-only
;;       (puni-expand-region)
;;       (kill-region (region-beginning) (region-end))))

;;   (defun puni-clone-thing-at-point (&optional arg)
;;     "Clone the next puni based thing at point"
;;     (interactive)
;;     (save-excursion
;;       (puni-expand-region)
;;       (kill-ring-save (region-beginning) (region-end)))
;;     (yank)
;;     (default-indent-new-line))

;; ;;;; Better Killing And Yanking
;;   (setq rectangle-mark-mode nil)
;;   (setq *last-kill-was-rectangle* rectangle-mark-mode)

;;   (defun remember-last-kill-type (&rest d)
;;     (setq *last-kill-was-rectangle* rectangle-mark-mode))

;;   ;; (advice-add 'kill-region :before #'remember-last-kill-type)
;;   ;; (advice-add 'kill-ring-save :before #'remember-last-kill-type)
;;   ;; (advice-add 'kill-rectangle :before #'remember-last-kill-type)

;;   (defun my/kill-region (BEG END &optional REGION)
;;     (interactive (list (mark) (point) 'region))
;;     (cond
;;      (rectangle-mark-mode (kill-rectangle
;;                            (region-beginning) (region-end)))
;;      (mark-active (kill-region
;;                    (region-beginning) (region-end)))
;;      (t (backward-kill-sexp 1))))

;;   (defun my/yank (&optional arg) (interactive)
;;          (if *last-kill-was-rectangle*
;;              (yank-rectangle)
;;            (yank arg)))
;; Avoid terminal binding conflict
;; (unless my/is-termux
;;   (bind-key (kbd "M-[") #'puni-splice 'puni-mode-map)
;;   (bind-key (kbd "M-]") #'puni-split 'puni-mode-map))
```


## Keybindings {#keybindings}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
```


### Redefine `global-key` {#redefine-global-key}

```elisp
;; Info 모드 Node 이동
;; (evil-define-key '(motion normal visual) Info-mode-map
;;   "^" 'Info-up
;;   "C-n" 'Info-prev
;;   "C-p" 'Info-next
;;   "M-n" 'Info-forward-node
;;   "M-p" 'Info-backward-node
;;   )

;; o :: ace-link-info 이거면 충분하다.

;; /home/junghan/sync/man/dotsamples/spacemacs/spacemacs-thanhvg/doc/DOCUMENTATION.org
;; (define-key evil-insert-state-map (kbd "C-]") 'forward-char)

;; Replace Emacs Tabs key bindings with Workspace key bindings
(with-eval-after-load 'evil-maps
  ;; 편집 창 포커스 이동을 간단하게
  (define-key evil-normal-state-map (kbd "<SPC> <right> ") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "<SPC> <left> ") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "<SPC> <up> ") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "<SPC> <down> ") 'evil-window-down)

  ;; replace "." search with consul-line in Evil normal state
  ;; use default "/" evil search
  (evil-global-set-key 'normal "." 'consult-line)
  ;; (evil-global-set-key 'normal "." 'spacemacs/consult-line)

  ;; TODO disable evil-mc key-binding with meta
  ;; 내 커스텀 키로 이용한다. evil-mc 를 어떻게 할지 고민
  ;; (with-eval-after-load 'evil-mc
  ;;   (evil-define-key '(insert normal visual) evil-mc-key-map (kbd "M-n") nil)
  ;;   (evil-define-key '(insert normal visual) evil-mc-key-map (kbd "M-p") nil)
  ;;   (evil-define-key '(normal visual) evil-mc-key-map (kbd "C-n") nil)
  ;;   (evil-define-key '(normal visual) evil-mc-key-map (kbd "C-p") nil)
  ;;   (evil-define-key '(normal visual) evil-mc-key-map (kbd "C-t") nil)
  ;;   (evil-define-key '(normal visual) evil-mc-key-map (kbd "C-M-j") nil)
  ;;   (evil-define-key '(normal visual) evil-mc-key-map (kbd "C-M-k") nil)
  ;; )

  (define-key evil-normal-state-map (kbd "C-a") 'evil-beginning-of-line)
  (define-key evil-normal-state-map (kbd "C-e") 'evil-end-of-line-or-visual-line)
  (define-key evil-insert-state-map (kbd "C-a") 'evil-beginning-of-line)
  (define-key evil-insert-state-map (kbd "C-e") 'evil-end-of-line-or-visual-line)
  ;; =C-w= 'insert 'evil-delete-backward-word
  ;; =C-w= 'visual 'evil-window-map
  )
```


### Rebind C-u {#rebind-c-u}

<span class="timestamp-wrapper"><span class="timestamp">[2022-12-16 Fri 07:23]</span></span>
Since I let `evil-mode` take over `C-u` for buffer
scrolling, I need to re-bind the `universal-argument` command to another key
sequence. I'm choosing `C-M-u` for this purpose.

```elisp
(global-set-key (kbd "C-M-u") 'universal-argument)
```


### <span class="org-todo todo TODO">TODO</span> Xref keybindings {#xref-keybindings}

[Xref (GNU Emacs Manual)](https://www.gnu.org/software/emacs/manual/html_node/emacs/Xref.html)
From a development perspective, moving to core allows us to work on Eglot in
tandem with other related packages already in Emacs, such as Flymake, ElDoc,
Xref, Project. <span class="timestamp-wrapper"><span class="timestamp">[2022-12-27 Tue 15:03]</span></span>

위는 eglot 리포에서 가져온 것이다. 이 부분도 파악이 필요하다.

```elisp
;; (spacemacs/set-leader-keys "jd" 'xref-find-definitions)
;; (spacemacs/set-leader-keys "jD" 'xref-pop-marker-stack)
;; (spacemacs/set-leader-keys "j?" 'xref-find-references)
```
