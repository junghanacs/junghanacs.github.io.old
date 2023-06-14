+++
title = "jh-utility layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:52:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-utility
{{< /hint >}}

<!--more-->


## Goals {#goals}

debug, docker, dap, lsp 등 utility layer 등록.


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
   debug
   docker
   import-js

   dap

   ;; Language server protocol with minimal visual impact
   ;; https://practical.li/spacemacs/install-spacemacs/clojure-lsp/
   (lsp
    :packages (not helm-lsp lsp-ivy) ; lsp-treemacs lsp-origami
    :variables
    lsp-headerline-breadcrumb-enable t              ; Breadcrumb trail
    lsp-headerline-breadcrumb-segments '(projects)   ; namespace & symbols, no file path
    lsp-ui-peek-enable t                            ; popups for refs, errors, symbols, etc.
    lsp-semantic-tokens-enable t                    ; enhance syntax highlight
    lsp-treemacs-error-list-current-project-only t  ; limit errors to current project
    lsp-idle-delay 0.2                              ; smooth LSP features response
    ;; lsp-modeline-code-actions-segments '(count icon)
    lsp-eldoc-enable-hover nil                      ; disable all hover actions
    lsp-ui-doc-enable nil                           ; doc hover popups
    lsp-ui-sideline-enable t                     ; sidebar code actions visual indicator
    treemacs-space-between-root-nodes nil           ; spacing in treemacs views
    lsp-log-io t                                    ; Log client-server json communication

    lsp-navigation 'both ; default 'both ; 'simple or 'peek
    ;; lsp-modeline-diagnostics-enable nil ; default t
    ;; lsp-modeline-code-actions-enable nil ; default t
    lsp-enable-on-type-formatting t ; clojure-mode conflicts
    )

   node
   pandoc

   ;; prettier ; never!

   ;; (command-log :packages (command-log-mode)) ; never!

   (restclient :packages (not company-restclient))

   prodigy
   ;; protobuf

   (shell
    :packages (not multi-vterm) ; multi-vterm depanes on project.el
    :variables
    shell-default-shell 'vterm
    shell-default-term-shell "/usr/bin/zsh" ; /bin/bash
    spacemacs-vterm-history-file-location "~/.config/zsh/.zsh_history"
    shell-default-full-span nil ; default t
    shell-default-position 'bottom
    shell-default-height 30
    )

   ;; tmux
   ;; kubernetes

   ;;  (gtags :variables gtags-enable-by-default t)

   ;; systemd
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

(defconst jh-utility-packages
  '(
    lsp-mode

    ;; additional packages
    dogears
    tmr
    prodigy

    ;; crux
    ;; consult-ag
    ;; ssh-deploy
    ;; dwim-shell-command
    ;; (unpackaged :location (recipe :fetcher github :repo "alphapapa/unpackaged"))

    ;; (deno-bridge :location (recipe :fetcher github :repo "manateelazycat/deno-bridge"
    ;;                                :files ("*.el" "*.md" "example")))
    ;; (insert-translated-name :location (recipe :fetcher github :repo "manateelazycat/insert-translated-name"
    ;;                                           :files ("*.el" "*.ts" "*.md")))
    ))
```


### lsp-mode :: `lsp` layer {#lsp-mode-lsp-layer}

lsp layer 를 활성화 한다. 거기에 해당 설정을 한다. 가볍게.

```elisp
(defun jh-utility/post-init-lsp-mode ()
  ;; Without it lsp flycheck is not working
  (require 'lsp-headerline)
  (require 'lsp-diagnostics))
```


### prodigy services {#prodigy-services}



```elisp
(defun jh-utility/post-init-prodigy ()
  (progn
    ;; define service
    ;; -D, --buildDrafts                include content marked as draft
    ;; -E, --buildExpired               include expired content
    ;; -F, --buildFuture                include content with publishdate in the future

    (prodigy-define-service
      :name "Hugo Server"
      :command "hugo"
      ;; :args '("server" "-D")
      :args '("server" "-D")
      :cwd blog-admin-dir
      :tags '(hugo server)
      :kill-signal 'sigkill
      :kill-process-buffer-on-stop t)
    ))
```


### `TMR` May Ring Timer {#tmr-may-ring-timer}

[My Lesser Sung Packages of Emacs // Take on Rules](https://takeonrules.com/2023/02/25/my-lesser-sung-packages-of-emacs/)

```elisp
;;;;; TMR May Ring (tmr is used to set timers)
;; Read the manual: <https://protesilaos.com/emacs/tmr>.

(defun jh-utility/init-tmr ()
  (use-package tmr
    :ensure
    :defer 5
    :after embark
    :config
    (setq tmr-sound-file "/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga"
          tmr-notification-urgency 'normal
          tmr-description-list 'tmr-description-history)

    (let ((map global-map))
      (define-key map (kbd "C-c T t") #'tmr)
      (define-key map (kbd "C-c T T") #'tmr-with-description)
      (define-key map (kbd "C-c T l") #'tmr-tabulated-view) ; "list timers" mnemonic
      (define-key map (kbd "C-c T c") #'tmr-clone)
      (define-key map (kbd "C-c T k") #'tmr-cancel)
      (define-key map (kbd "C-c T s") #'tmr-reschedule)
      (define-key map (kbd "C-c T e") #'tmr-edit-description)
      (define-key map (kbd "C-c T r") #'tmr-remove)
      (define-key map (kbd "C-c T R") #'tmr-remove-finished)

      ;; 'C-c T' work with tmr
      (global-set-key (kbd "C-c T d") 'gts-do-translate)
      (global-set-key (kbd "C-c T i") 'google-translate-paragraphs-insert)
      (global-set-key (kbd "C-c T h") 'org-hyperscheduler-open)
      )

    (defvar tmr-action-map
      (let ((map (make-sparse-keymap)))
        (define-key map "k" #'tmr-remove)
        (define-key map "r" #'tmr-remove)
        (define-key map "R" #'tmr-remove-finished)
        (define-key map "c" #'tmr-clone)
        (define-key map "e" #'tmr-edit-description)
        (define-key map "s" #'tmr-reschedule)
        map))

    (with-eval-after-load 'embark
      (add-to-list 'embark-keymap-alist '(tmr-timer . tmr-action-map))
      (cl-loop
       for cmd the key-bindings of tmr-action-map
       if (commandp cmd) do
       (add-to-list 'embark-post-action-hooks (list cmd 'embark--restart))))
    )
  )
```


### PlaceSaver `dogears` {#placesaver-dogears}

The dogears idle timer runs (after 5 seconds idle, by default).
One of the dogears-hooks is run (only including imenu-after-jump-hook by default).
One of the functions listed in dogears-functions is called (none, by default).

```elisp
(defun jh-utility/init-dogears ()
  (use-package dogears
    :ensure
    :defer 10
    :init
    ;; (setq dogears-idle 5)  ; default 5 seconds
    ;; These bindings are optional, of course:
    :bind (:map global-map
                ("M-g d" . dogears-go)
                ("M-g M-b" . dogears-back)
                ("M-g M-f" . dogears-forward)
                ("M-g M-d" . dogears-list)
                ("M-g M-D" . dogears-sidebar))
    :config
    (dogears-mode)
    ))
```
