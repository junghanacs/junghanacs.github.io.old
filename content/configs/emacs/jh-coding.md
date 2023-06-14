+++
title = "jh-coding layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:52:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-coding
{{< /hint >}}

<!--more-->


## Goals {#goals}

설정 파일 및 Emacs 활용에 필요한 코드 관련 레이어 및 패키지.


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
   (emacs-lisp
    :packages (not company counsel-gtags emr))

   ;; For common-lisp dev. work with slime
   ;; you should install latest stable 'sbcl' first
   ;; (common-lisp
   ;;  :packages (not helm counsel-gtags slime-company))

   csv ; Tools to work with comma separate values e.g. data science data

   graphviz ; graphviz - open-source graph declaration system

   (json :packages (not company))

   (yaml :variables
          yaml-enable-lsp nil)

   ;; semantic-web

   ;; linting, style checking, formatting supports
   (shell-scripts
    :packages (not counsel-gtags company company-shell fish-mode)
    :variables
    shell-scripts-format-on-save t
    shell-scripts-backend 'lsp)

   ;; (julia :variables
   ;;        ;; julia-mode-enable-ess t ; use 'ess' layer
   ;;        julia-backend 'lsp)

   ;; (ruby :variables
   ;;       ruby-backend 'robe ; default 'robe or 'lsp
   ;;       ruby-test-runner 'ruby-test ; default
   ;;       ruby-version-manager nil ; rbenv, rvm, chruby
   ;;       ruby-prettier-on-save t ; default nil
   ;;       )

   ;; (go :variables
   ;;     go-backend 'lsp
   ;;     go-format-before-save t
   ;;     go-tab-width 4)

   (html :packages (not company company-web)
         :variables
         ;; web-fmt-tool 'prettier
         web-mode-markup-indent-offset 2
         web-mode-css-indent-offset 2
         web-mode-code-indent-offset 2
         ;; css-indent-offset 2
         )

   ;; (rust :variables
   ;;       rust-format-on-save t
   ;;       rust-backend 'lsp)

   ;; sql
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

(defconst jh-coding-packages
  '(
    ;;;; 새로 등록하는 패키지

    ;; eglot
    ;; eldoc-box

    ;; xref
    ;; flymake
    ;; treesit

    treeview ; for inspector in emacs-lisp layer

    format-all
    ;; apheleia

    ;; scopeline

    ;;;; emacs 29

    (emacsql-sqlite-builtin :toggle (version< "29.0.50" emacs-version)) ;; Emacs 29
    ;;  emacsql-sqlite-builtin
    ;; treesit-auto
    ;; (treesit-auto :toggle (version<= "29.0.50" emacs-version))
    ;; (combobulate
    ;;  :toggle (version< "29.0.50" emacs-version)
    ;;  :location (recipe :fetcher github :repo "mickeynp/combobulate"))
    ;; (evil-ts
    ;;  :toggle (version< "29.0.50" emacs-version)
    ;;  :location (recipe :fetcher github :repo "foxfriday/evil-ts"))
    ))
```


### `emacs-lisp` layer <span class="tag"><span class="elisp">elisp</span></span> {#emacs-lisp-layer}

현재 설정 참고할 것 그리고 아래 가이드 문서 준수 할 것

-   elisp pkg dev -- alphapapa
-   disable `emr` on layer


### treeview {#treeview}

```elisp
(defun jh-coding/init-treeview ()
  (use-package treeview :defer t)
  )
```


### format-all {#format-all}



```elisp
(defun jh-coding/init-format-all ()
  (use-package format-all
    :ensure
    :defer 5
    :hook (
           (prog-mode . format-all-mode)
           (yaml-mode . format-all-mode)
           (format-all-mode . format-all-ensure-formatter))
    )
  )

;; (use-package apheleia
;;   :ensure
;;   :config
;;   ;; (setf (alist-get 'isort apheleia-formatter)
;;   ;;       '("isort" "--stdout" "-"))
;;   ;; (setf (alist-get 'python-mode apheleia-mode-alist)
;;   ;;       '(isort black))
;;   (apheleia-global-mode +1)
;;   )
```


### sqlite-builtin {#sqlite-builtin}

```elisp
(defun jh-coding/init-emacsql-sqlite-builtin ()
  (use-package emacsql-sqlite-builtin :ensure))
```


### <span class="org-todo todo TODO">TODO</span> Clue {#clue}

<span class="timestamp-wrapper"><span class="timestamp">[2023-05-29 Mon 07:51]</span></span>
<https://github.com/AmaiKinono/clue>

Clue is a tool for helping you take notes while reading code.
Code reading is all about finding connections between different locations in a
project. With clue, you can take notes about these connections in plain text (or
your favorite markup language), and insert links to take you to these locations.

코드를 읽으면서 메모를 남긴다. 이거 말고도 전통적인 방법이 있을 것 같은데?
그거 부터 찾아보았으면 한다. projectile 에 이미 있거나 붙어있는 기능으로
사용하면 좋겠다.
