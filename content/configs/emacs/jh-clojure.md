+++
title = "jh-clojure layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:54:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-clojure
{{< /hint >}}

<!--more-->


## Goals {#goals}

clojure layer


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
   ;; https://develop.spacemacs.org/layers/+lang/clojure/README.html
   ;; clj-kondo를 flycheck로 쓰고 싶다면 아래를 활성화 한다.
   ;; 물론, 그럴 필요가 없다. clojure-lsp가 기본으로 clj-kondo를 사용하고,
   ;; lsp-mode는 이 정보를 받기에 굳이 clj-kondo를 flycheck로 쓸 필요가 없다.
   ;; pracicalli에서 제공하는 clojure-edn과 clojure-lsp repo를 ~/.config에 포크하고
   ;; 버전 및 필요한 기능을 관리하면 된다. clj-kondo 버전도 edn에 명시되어 있기에
   ;; 따로 clj-kondo를 설치할 필요도 없다. 궁합이 잘 맞는 버전을 설정해 놨을 터이니
   ;; 그냥 쓰면 된다. 집중할 것은 lsp-mode, lsp-ui 설정이다.
   ;; 개인의 취향과 실력에 따라서 lsp 설정을 하기에 존의 minimal ui 설정은
   ;; 초보자에게는 부족할 수가 있다. 그냥 따를 것이 아니라 내가 결정해야 한다.
   ;; /home/junghan/.emacs.d/layers/+lang/clojure/packages.el:24
   ;; (cider :location elpa :min-version "1.5.0")
   ;; (clojure-mode :location elpa :min-version "5.16.0")
   (clojure
    :variables
                                        ; clojure-backend 'cider               ;; use cider and disable lsp
                                        ; clojure-enable-linters 'clj-kondo    ;; clj-kondo included in lsp

    ;; for layer
    clojure-enable-kaocha-runner t          ;; enable Kaocha test runner
    ;; clojure-enable-clj-refactor nil ; default nil
    ;; clojure-enable-sayid nil ; default nil

    ;; for clojure-mode
    ;; clojure-indent-style 'align-arguments ; user-config
    ;; clojure-align-forms-automatically t ; user-config
    clojure-toplevel-inside-comment-form t  ;; evaluate expressions in comment as top level

                           ;;; for cider
    ;; cider-repl-pop-to-buffer-on-connect nil ; REPL buffer shown at starup
    ;; cider-repl-display-help-banner nil      ; disable help banner
    ;; cider-print-fn 'puget                   ; pretty printing with sorted keys / set values
    ;; cider-result-overlay-position 'at-point ; results shown right after expression
    cider-overlays-use-font-lock t
    cider-repl-buffer-size-limit 500        ; limit lines shown in REPL buffer
    ;; cider-repl-history-size 42 ; default 500
    cider-preferred-build-tool 'clojure-cli
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

(defconst jh-clojure-packages
  '(
    ;; 재정의 패키지
    clojure-mode
    cider

    ;; clojure-essential-ref
    ;; clojars
    ;; walkclj
    ))
```


### clojure-mode {#clojure-mode}


#### clojure-mode {#clojure-mode}

```elisp
(defun jh-clojure/post-init-clojure-mode ()
  ;; copy from corgi
  (add-to-list 'auto-mode-alist '("\\.endl$" . clojure-mode))
  (add-to-list 'magic-mode-alist '("^#![^\n]*/\\(clj\\|clojure\\|bb\\|lumo\\)" . clojure-mode))
  ;; Because of CIDER's insistence to send forms to all linked REPLs, we
  ;; *have* to be able to switch cljc buffer to clj/cljs mode without
  ;; cider complaining.
  ;; (setq clojure-verify-major-mode nil) ; 나중에 해보고

  ;; Do not indent single ; comment characters
  (add-hook 'clojure-mode-hook (lambda () (setq-local comment-column 0)))

  ;; Indentation of function forms
  ;; https://github.com/clojure-emacs/clojure-mode#indentation-of-function-forms
  (setq clojure-indent-style 'align-arguments)
  ;; Vertically align s-expressions
  ;; https://github.com/clojure-emacs/clojure-mode#vertical-alignment
  (setq clojure-align-forms-automatically t)

  ;; Auto-indent code automatically
  ;; WARNING - really conflicts with LSP formatting - set lsp-enable-on-type-formatting to nil in lsp layer
  ;; https://emacsredux.com/blog/2016/02/07/auto-indent-your-code-with-aggressive-indent-mode/
  (add-hook 'clojure-mode-hook 'aggressive-indent-mode)

  ;; auto flycheck-mode off
  ;; (add-hook 'clojure-mode-hook 'flycheck-mode)

  ;; Lookup functions in Clojure - The Essentail Reference book
  ;; https://github.com/p3r7/clojure-essential-ref
  ;; (spacemacs/set-leader-keys "oh" 'clojure-essential-ref)

  ;; Safe structural editing for all major modes
  ;; (spacemacs/toggle-evil-safe-lisp-structural-editing-on-register-hooks)
  ;; for clojure layer only (comment out line above)
  (add-hook 'spacemacs-post-user-config-hook #'spacemacs/toggle-evil-safe-lisp-structural-editing-on-register-hook-clojure-mode)
```


#### func {#func}

```elisp
;; toggle reader macro sexp comment
;; toggles the #_ characters at the start of an expression
(defun clojure-toggle-reader-comment-sexp ()
  (interactive)
  (let* ((point-pos1 (point)))
    (evil-insert-line 0)
    (let* ((point-pos2 (point))
           (cmtstr "#_")
           (cmtstr-len (length cmtstr))
           (line-start (buffer-substring-no-properties point-pos2 (+ point-pos2 cmtstr-len)))
           (point-movement (if (string= cmtstr line-start) -2 2))
           (ending-point-pos (+ point-pos1 point-movement 1)))
      (if (string= cmtstr line-start)
          (delete-char cmtstr-len)
        (insert cmtstr))
      (goto-char ending-point-pos)))
  (evil-normal-state))
;;
;; Assign keybinding to the toggle-reader-comment-sexp function
(define-key global-map (kbd "C-#") 'clojure-toggle-reader-comment-sexp)
;;
;; Toggle view of a clojure `(comment ,,,) block'
(defun clojure-hack/toggle-comment-block (arg)
  "Close all top level (comment) forms. With universal arg, open all."
  (interactive "P")
  (save-excursion
    (goto-char (point-min))
    (while (search-forward-regexp "^(comment\\>" nil 'noerror)
      (call-interactively
       (if arg 'evil-open-fold
         'evil-close-fold)))))

(evil-define-key 'normal clojure-mode-map
  "zC" 'clojure-hack/toggle-comment-block
  "zO" (lambda () (interactive) (clojure-hack/toggle-comment-block 'open)))
```


#### end {#end}

```elisp
)
```


### Cider {#cider}

john's doom 을 보면 아래와 같이 popup-rule 이 잡혀있다.
둠에서는 이렇게 쉽다니 스맥스도 어렵지 않다.
shackle, poppler 와 같은 패키지를 이야기하지만 배포판을 쓰는 경우라면
해당 배포판의 룰을 따르는게 맞다. 아니면 Emacs 기본 함수를 메뉴얼보고
사용하면 된다. 다행히 popwin 을 설정하면 된다. 아래와 같이 설정해야 한다.
regexp t 를 설정 안하면 인식이 안된다. 이 정도면 충분하다. 그리고 stick nil 을
설정했다. 이건 상황 보면서 바꾸면 된다. 아무튼 popwin 을 쓰게 되어 다행이다.

```elisp
(defun jh-clojure/post-init-cider ()
       ;;; Clojure (clojure-mode and accoutrements)
  ;; NOTE 2022-11-21: for the linter (clj-kondo), refer to the Flymake
  ;; NOTE 2022-11-23: This is not final.  I will iterate on it over
  ;; time as I become more familiar with the requirements.
  (setq cider-repl-result-prefix ";; => "
        cider-eval-result-prefix ""
        cider-connection-message-fn nil ; cute, but no!
        cider-repl-prompt-function #'my/cider-repl-prompt
        cider-use-overlays nil ; echo area is fine
        cider-repl-display-help-banner nil)

  (defun my/cider-repl-prompt (namespace)
    "Return a prompt string that mentions NAMESPACE."
    (format "%s🦄 " (cider-abbreviate-ns namespace)))
  )
```


### cider corfu  bugfix {#cider-corfu-bugfix}

```elisp
(with-eval-after-load 'cider
  ;; Spacemacs bug fix
  (evil-define-key 'insert cider-repl-mode-map
    (kbd "C-j") 'corfu-next
    (kbd "C-k") 'corfu-previous)
  )
```


#### <span class="org-todo done OFF">OFF</span> cider company  bugfix {#cider-company-bugfix}

```elisp
;; (with-eval-after-load 'cider
;;   ;; Spacemacs bug fix
;;   (evil-define-key 'insert cider-repl-mode-map
;;     (kbd "C-j") 'company-select-next
;;     (kbd "C-k") 'company-select-previous)
;;   )
```
