+++
title = "jh-python layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:54:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-python
{{< /hint >}}

<!--more-->


## Goals {#goals}

Spacemacs 레이어를 그냥 사용한다.


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
   (python
    :packages (not company counsel-gtags helm-cscope helm-pydoc
                   anaconda-mode company-anaconda lsp-python-ms)
    :variables
    python-backend 'lsp
    python-lsp-server 'pyright ; for compatibility with eglot
    python-test-runner 'pytest
    python-poetry-activate t
    python-formatter 'yapf ; 'lsp
    ;; python-format-on-save t ; default nil
    ;; python-save-before-test nil
    ;; python-fill-column 99 ; default 79
    ;; python-tab-width 4 ; default 4
    ;; python-sort-imports-on-save t
    )

   ;; django
   ;; ipython-notebook
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

(defconst jh-python-packages
  '(
    ;; 재정의 패키지
    ;; python
    ;; lsp-pyright ; need to tunning
    ;; eglot
    ))
```
