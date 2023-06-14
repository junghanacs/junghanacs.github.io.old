+++
title = "jh-javascript layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:54:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-javascript
{{< /hint >}}

<!--more-->


## Goals {#goals}

javascript, typescript, react 관련 설정.


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
   (javascript
    :packages (not counsel-gtags company web-beautify)
    :variables
    js2-mode-show-strict-warnings nil
    javascript-repl 'nodejs
    javascript-import-tool 'import-js
    ;; javascript-fmt-tool 'prettier
    ;; javascript-fmt-on-save t
    javascript-backend 'lsp
    js2-basic-offset 2
    js-indent-level 2
    js2-include-node-externs t
    javascript-lsp-linter nil)

   (typescript :variables
               typescript-backend 'lsp)

   react
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

(defconst jh-javascript-packages
  '(
    ;; 재정의 패키지
    ))
```


## Config {#config}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-

(setq org-babel-js-function-wrapper
      "process.stdout.write(require('util').inspect(function(){\n%s\n}(), { maxArrayLength: null, maxStringLength: null, breakLength: Infinity, compact: true }))")
```
