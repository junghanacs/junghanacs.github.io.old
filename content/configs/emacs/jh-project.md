+++
title = "Emacs: jh-project layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
keywords = ["draft", "configs"]
draft = false
+++

{{< hint info >}}
스페이스맥스의 Git, Version-Control, Spacemacs-Project 를 기반으로 레이어 구성.
{{< /hint >}}

<!--more-->


## Goals {#goals}


### Git {#git}

This layers adds extensive support for [git](http://git-scm.com/) to Spacemacs.

Features:

-   git repository management the indispensable [magit](http://magit.vc/) package
-   [forge](https://github.com/magit/forge/) add-on for magit.
-   [git-flow](https://github.com/jtatarik/magit-gitflow) add-on for magit.
-   quick in buffer history browsing with [git-timemachine](https://melpa.org/#/git-timemachine).
-   quick in buffer last commit message per line with [git-messenger](https://github.com/syohex/emacs-git-messenger)
-   colorize buffer line by age of commit with [smeargle](https://github.com/syohex/emacs-smeargle)
-   git grep with [helm-git-grep](https://github.com/yasuyk/helm-git-grep)
-   org integration with magit via [orgit](https://github.com/magit/orgit)

New to Magit? Checkout the [official intro](https://magit.vc/about/) and [Practicalli Spacemacs](https://practical.li/spacemacs/source-control/)
guide to configuring and using the Git and version control layers.


### Version-Control {#version-control}

This layers adds general configuration for [Emacs VC](http://www.gnu.org/software/emacs/manual/html_node/emacs/Version-Control.html).
It should work with all VC backends such as Git, Mercurial, Bazaar, SVN, etc...

Features:

-   highlights uncommitted changes in the fringe or margin with [diff-hl](https://github.com/dgutov/diff-hl), [git-gutter](https://github.com/syohex/emacs-git-gutter), or [git-gutter+](https://github.com/nonsequitur/git-gutter-plus)
-   adds vcs transient-state <kbd>SPC g.</kbd> to allow quick navigation and modification of buffer hunks.


### Spacemacs-project {#spacemacs-project}

This layer tweaks `projectile` to integrate nicely into Spacemacs.

Features:

-   Setup of `projectile` key bindings, including functions for project search, switching, version control and compilation.
-   Additional path helper functions, to copy the location of a buffer relative to the project root.


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
   ;;
   ;; SPC g s opens Magit git client full screen (q restores previous layout)
   ;; show word-granularity differences in current diff hunk
   ;;      git-enable-magit-gitflow-plugin t
   (git :variables
        magit-diff-refine-hunk t
        git-enable-magit-delta-plugin t
        git-enable-magit-todos-plugin t)

   ;; Highlight changes in buffers
   ;; SPC g . transient state for navigating changes
   (version-control
    :variables
    ;;  version-control-diff-tool 'diff-hl ; never! too slow!
    version-control-diff-tool 'git-gutter ; simple makes perfect
    ;; 아래에 margin 을 켜야 diff-tool이 mode 활성화 된다
    version-control-global-margin t)

   spacemacs-project ; projectile
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
(defconst jh-project-packages
  '(
    magit
    forge
    git-commit
    git-timemachine

    ;; additional packages
    magit-imerge
    sideline-blame
    consult-git-log-grep
    consult-projectile
    ))
```


### consult-log-grep {#consult-log-grep}

projectile 쓰고 싶은데 기능이 너무 많아서 엄두가 안 나더라.
아래는 기본 키 바인딩이다.
which-key-max-description-length

```elisp
;; 프로젝트 prefix p
;; f find :: projectile-find-file
;; p switch project :: projectile-switch-project
;; k kill buffers :: projectile-kill-buffers
;; s search in project :: counsel-git-grep ==> consult-git-grep
;; S consult-git-log-grep
;; b switch to project buffer :: projectile-switch-to-buffer

(defun jh-project/init-consult-git-log-grep ()
  (use-package consult-git-log-grep :defer ))

;; (defun jh-project/post-init-projectile ()
;;   (require 'consult-git-log-grep)
;;   (require 'consult-projectile)
;;   )

```


### Magit {#magit}

magit - forge configuration
git 레이어에 대한 추가 설정

[Difftastic diffing with Magit](https://tsdh.org/posts/2022-08-01-difftastic-diffing-with-magit.html) 를 반영하여 my-magit.el 추가

```elisp
(defun jh-project/post-init-magit ()
  ;; (require 'my-magit)
  ;; Version Control configuration - Git, etc
  ;; ;; Load in magithub features after magit package has loaded
  ;; ;; (use-package magithub
  ;; ;;   :after magit
  ;; ;;   :config (magithub-feature-autoinject t))
  ;;
  ;; Set locations of all your Git repositories
  ;; with a number to define how many sub-directories to search
  ;; `SPC g L' - list all Git repositories in the defined paths,
  (setq magit-repository-directories
        '(("~/.spacemacs.d/" . 0)
          ("~/mydotfiles/" . 0)
          ("~/sync/code/" . 2)
          ("~/sync/obsd/" . 0)
          ("~/sync/org/" . 0)))
  )
  ;;;; l and h are for navigating. even in magit
;;   (evil-define-key 'normal magit-mode-map "l" 'evil-forward-char)
;;   (evil-define-key 'normal magit-mode-map (kbd "M-l") 'magit-log)
;;   (evil-define-key 'normal magit-mode-map "h" 'evil-backward-char)
;;   (evil-define-key 'normal magit-mode-map (kbd "M-h") 'magit-dispatch)
;;   (evil-define-key 'normal magit-mode-map (kbd "<escape>") nil)
;;   (evil-define-key 'normal magit-revision-mode-map "q" 'magit-log-bury-buffer))
```


### git-commit {#git-commit}

<span class="timestamp-wrapper"><span class="timestamp">[2023-06-12 Mon 15:28]</span></span>
conventional commit support

```elisp
;; Enforce git commit conventions.
;; See: chris.beams.io/posts/git-commit/
;; Use Spacemacs as the $EDITOR
;; (or $GIT_EDITOR) for git commits messages when using git commit on the command
;; line
(defun jh-project/post-init-git-commit ()
  (use-package git-commit
    :after magit
    :demand t
    :hook (git-commit-mode . +git-gommit--set-fill-column-h)
    :hook (git-commit-setup . +git-commit--enter-evil-insert-state-maybe-h)
    :custom
    (git-commit-summary-max-length 50)
    (git-commit-style-convention-checks '(overlong-summary-line non-empty-second-line))
    :config
    (defun +git-gommit--set-fill-column-h ()
      (setq-local fill-column 72))

    ;; Enter evil-insert-state for new commits (hooked to `git-commit-setup-hook')
    (defun +git-commit--enter-evil-insert-state-maybe-h ()
      (when (and (bound-and-true-p evil-mode)
                 (not (evil-emacs-state-p))
                 (bobp)
                 (eolp))
        (evil-insert-state)))

    (global-git-commit-mode 1))
  )
```


### git-timemachine {#git-timemachine}



```elisp
(defun jh-project/post-init-git-timemachine ()
  (setq git-timemachine-show-minibuffer-details t))
```


### forge {#forge}



```elisp
(defun jh-project/post-init-forge ()

  (when (> emacs-major-version 28) ; Emacs-29 use builtin pkgs
    (setq forge-database-connector 'sqlite-builtin))

  ;; Configure number of topics show, open and closed
  ;; use negative number to toggle the view of closed topics
  ;; using `SPC SPC forge-toggle-closed-visibility'
  (setq  forge-topic-list-limit '(100 . -10))
  ;; set closed to 0 to never show closed issues
  ;; (setq  forge-topic-list-limit '(100 . 0))

  ;; GitHub user and organization accounts owned
  ;; used by @ c f  to create a fork
  (setq forge-owned-accounts
        '(("junghan0611")))
  ;;       '(("practicalli" "practicalli-john"
  ;;          "reclojure")))

  ;; ;; To blacklist specific accounts,
  ;; ;; over-riding forge-owned-accounts
  ;; ;; (setq forge-owned-blacklist
  ;; ;;       '(("bad-hacks" "really-bad-hacks")))
  )
```


### magit-imerge {#magit-imerge}



```elisp
(defun jh-project/init-magit-imerge ()
  (use-package magit-imerge :defer t))
```


### sideline-blame {#sideline-blame}

[GitHub - emacs-sideline/sideline-blame: Show blame messag...](https://github.com/emacs-sideline/sideline-blame)

```elisp
(defun jh-project/init-sideline-blame ()
  (use-package sideline-blame
    :after sideline
    :defer 10
    :init
    (setq sideline-blame-uncommitted-author-name "Me"
          sideline-blame-uncommitted-message "Uncommitted changes")
    (setq sideline-blame-author-format "|%.8s.|")
    (setq sideline-blame-datetime-format " |%y-%m-%d| ")
    (setq sideline-blame-commit-format "%.20s.|")
    (setq sideline-backends-left '((sideline-blame . down)))))
```


### consult-projectile {#consult-projectile}

jeremyf

```elisp
(defun jh-project/init-consult-projectile ()
  (use-package consult-projectile
    ;; package provides a function I use everyday: ~M-x consult-projectile~.  When
    ;; I invoke ~consult-projectile~, I have the file completion for the current
    ;; project.  I can also type =b= + =SPACE= to narrow my initial search to open
    ;; buffers in the project.  Or =p= + =space= to narrow to other projects; and
    ;; then select a file within that project.
    :after consult projectile
    :commands (consult-projectile)
    ;; This overwrite `ns-open-file-using-panel'; the operating system's "Finder"
    ;; ("C-c o" . consult-projectile)
    ))
```


### <span class="org-todo done OFF">OFF</span> `blamer.el` <span class="tag"><span class="OFF">OFF</span></span> {#blamer-dot-el}

<span class="timestamp-wrapper"><span class="timestamp">[2023-04-27 Thu 09:15]</span></span>
[GitHub - Artawower/blamer.el: A git blame plugin for emac...](https://github.com/Artawower/blamer.el)
A git blame plugin for emacs inspired by VS Code’s GitLens plugin and Vim plugin

```elisp
;; (defun jh-project/init-blamer ()
;;   (use-package blamer
;;     :ensure t
;;     :defer 20
;;     :custom
;;     (blamer-idle-time 0.5)
;;     (blamer-min-offset 70)
;;     (blamer-force-truncate-long-line nil) ; t
;;     (blamer-show-avatar-p nil)
;;     (blamer-prettify-time-p t)
;;     ;; (blamer-view 'overlay)
;;     :custom-face
;;     (blamer-face ((t :foreground "#7a88cf"
;;                      :height 1.0
;;                      :italic t)))
;;     :config
;;     (global-blamer-mode 1)
;;     ))
```


## Funcs {#funcs}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
```


## Keybindings {#keybindings}


### Global Bindings {#global-bindings}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
(global-set-key (kbd "C-x g") 'magit-status)
```


### Spacemacs Bindings {#spacemacs-bindings}

```elisp
;; git vc
(spacemacs/set-leader-keys "gg" 'consult-git-grep)
(spacemacs/set-leader-keys "gG" 'consult-git-log-grep)
```
