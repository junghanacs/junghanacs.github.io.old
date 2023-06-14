+++
title = "jh-org layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:52:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
jh-org
{{< /hint >}}

<!--more-->


## Goals {#goals}

org 관련 패키지들 모듬. 워크플로우는 별도로 파일 관리함.


## Layers {#layers}

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
   (spacemacs-org :packages (default-org-config)) ; done

   (org
    ;; evil-org org-present
    ;; evil-surround gnuplot htmlize ob org-contrib org-download org-mime
    ;; org-pomodoro org-cliplink org-rich-yank org-epub
    ;; org-twbs org-gfm ox-hugo org-sticky-header
    ;; org-roam org-roam-ui ox-asciidoc org-journal
    :packages (not helm helm-org-rifle emoji-cheat-sheet-plus company company-emoji persp-mode)
    :variables
    org-enable-hugo-support t
    org-enable-roam-support t
    org-enable-roam-protocol t
    org-enable-roam-ui t
    org-enable-org-journal-support t
    org-want-todo-bindings t ; use evil-binding (t, T, M-t)
    org-enable-github-support t ; gfm markdown support
    org-enable-epub-support t
    org-enable-transclusion-support t
    org-enable-reveal-js-support t
    org-enable-asciidoc-support t
    org-enable-org-contacts-support t
    org-enable-modern-support t

    org-enable-appear-support t
    org-appear-trigger 'manual ; for evil editing

    ;; should be nil
    org-enable-sticky-header nil ; replace with my breadcrumbs
    org-todo-dependencies-strategy nil ; 'naive-auto
    org-enable-valign nil ; performance issue, should be nil
    org-enable-trello-support nil ; should be nil

    ;; TODO 디렉토리 패스는 환경 변수 이용 할 것!
    org-directory "~/sync/org/"
    ;; org-directory (file-truename "~/sync/org/")
    org-roam-directory (concat org-directory "roam/")
    org-note-directory (concat org-directory "roam/")

    org-user-agenda-files (list (concat org-directory "workflow/"))
    org-agenda-files  org-user-agenda-files

    org-workflow-directory (concat org-directory "workflow/")
    org-contacts-files (list (concat org-directory "workflow/contacts.org"))

    org-inbox-file (concat org-directory "workflow/inbox.org")
    org-default-notes-file org-inbox-file

    org-log-file (concat org-directory "workflow/log.org")
    org-agenda-diary-file org-log-file

    org-projectile-file (concat org-directory "workflow/project.org")

    ;; org-download
    org-download-method 'directory
    org-download-heading-lvl nil
    org-download-timestamp "%Y%m%d-%H%M-"
    org-download-image-dir "imgs"
    org-download-image-org-width 640

    ;; org-cliplink-max-length 60 ; 80
    )
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

(defconst jh-org-packages
  '(
    org-journal ; TODO 삭제할 것!
    citar
    citar-embark

    ;; Additional Packages
    org-modern
    (org-modern-indent
     :location (recipe :fetcher github :repo "jdtsmith/org-modern-indent"))

    (org-remoteimg :location (recipe :fetcher github :repo "gaoDean/org-remoteimg"))
    orglink

    org-gcal ; sync google-calendar
    ;; org-hyperscheduler
    org-super-agenda

    ob-translate
    ob-mermaid
    org-make-toc
    ;; toc-org

    org-auto-tangle
    ;; org-tree-slide

    ;; (org-tufte :location (recipe :fetcher github :repo "Zilong-Li/org-tufte"))
    org-remark

    ;; org-reverse-datetree

    org-drill
    ;; (org-fc :location (recipe :fetcher github :repo "l3kn/org-fc"))

    (org-web-tools :location (recipe :fetcher github :repo "alphapapa/org-web-tools"
                                     :files ("*.el" "*.org")))
    ;; org-kanban

    (org-glossary :location (recipe :fetcher github :repo "tecosaur/org-glossary"
                                    :files ("*.el" "*.org" "*.texi")))

    (org-pandoc-import :location (recipe :fetcher github :repo "tecosaur/org-pandoc-import"
                                         :files ("*.el" "*.org" "filters" "preprocessors")))

    ;; titlecase
    ;; (pdftotext :location (recipe :fetcher github :repo "tecosaur/pdftotext.el"
    ;;                              :files ("*.el" "*.org")))
    ;; (orgdiff :location (recipe :fetcher github :repo "tecosaur/orgdiff"
    ;;                            :files ("*.el" "*.org")))
    ;; (org-link-base :location (recipe
    ;;                           :fetcher github :repo "cashpw/org-link-base"))
    ))
```


### <span class="org-todo todo TODO">TODO</span> org-journal {#org-journal}

오랫동안 사귀었던 정든 내 친구야. 이제 안녕!

```elisp
  (defun jh-org/post-init-org-journal ()
    (setq org-journal-dir (expand-file-name "~/sync/org/logseq/journals"))
    (setq org-journal-find-file 'find-file-at-point) ; default 'find-file-other-window
    (setq org-journal-file-format "%Y_%m_%d.org")
    (setq org-journal-date-format "%Y-Week-%U %y-%m-%d (%A)")
    ;; org-journal-tag-alist ; default nil
    ;; (setq org-journal-file-header
    ;;       ":PROPERTIES:\n:SUBTITLE:\n:END:\n\n") ; default ""
    ;; (setq org-journal-follow-mode t)
    (setq org-journal-time-prefix "** ")

    (defun my/daily-fortune()
      (when (executable-find "fortune")
        (insert "\n")
        (insert (string-join
                 (mapcar (lambda (l) (concat " " l))
                         (string-lines (shell-command-to-string "fortune")))
                 "\n")))
      )

    (add-hook 'org-journal-after-header-create-hook 'my/daily-fortune)
    ;; (setq org-journal-time-format "")
    )
```


### org-glossary {#org-glossary}

<https://github.com/tecosaur/org-glossary/blob/master/org-glossary.org>
문서를 읽고 사용해보세요

Other than hooking this to `org-mode`, we also want to set a collection root and
improve the LaTeX usage references with `cleveref`'s <kbd>\labelcpageref</kbd> command.

```elisp
  (defun jh-org/init-org-glossary ()
    (use-package org-glossary
      :ensure
      :after org
      :config
      (setq org-glossary-collection-root "~/sync/org/roam/terms/")
      (add-hook 'org-mode-hook 'org-glossary-mode)
      ))

  ;; sample from tecosaur/org-glossary
  ;; (defun +org-glossary--latex-cdef (backend info term-entry form &optional ref-index plural-p capitalized-p extra-parameters)
  ;;   (org-glossary--export-template
  ;;    (if (plist-get term-entry :uses)
  ;;        "*%d*\\emsp{}%v\\ensp{}@@latex:\\labelcpageref{@@%b@@latex:}@@\n"
  ;;      "*%d*\\emsp{}%v\n")
  ;;    backend info term-entry ref-index
  ;;    plural-p capitalized-p extra-parameters))
  ;; (org-glossary-set-export-spec
  ;;  'latex t
  ;;  :backref "gls-%K-use-%r"
  ;;  :backref-seperator ","
  ;;  :definition-structure #'+org-glossary--latex-cdef)
```


### org-drill {#org-drill}

```elisp
(defun jh-org/init-org-drill ()
  (use-package org-drill :after org :defer 20))
```


### Utility {#utility}


#### org-remoteimg {#org-remoteimg}

GUI 모드에서만 동작한다. 터미널에서는 kitty 그래픽 프로토콜을 이용하는 방법도 있다.

```elisp
(defun jh-org/init-org-remoteimg ()
  (use-package org-remoteimg
    :if window-system
    :after org
    :config
    ;; optional: set this to wherever you want the cache to be stored
    ;; (setq url-cache-directory "~/.cache/emacs/url")
    (setq org-display-remote-inline-images 'cache) ;; enable caching
    ;; or this if you don't want caching
    ;; (setq org-display-remote-inline-images 'download)
    ;; or this if you want to disable this plugin
    ;; (setq org-display-remote-inline-images 'skip)

    ;; this is a emacs built-in feature
    ;; (setq url-automatic-caching t)
    ))
```


#### orglink {#orglink}

<span class="timestamp-wrapper"><span class="timestamp">[2023-04-19 Wed 21:31]</span></span>
This library implements support for some Org Mode link types in
other major modes.  Links can be opened and edited like in Org
Mode.

To use enable \`global-orglink-mode' and customize
\`orglink-activate-in-modes'.  Or use the buffer local
\`orglink-mode'.  Do the latter now to linkify these examples:

```elisp
(defun jh-org/init-orglink ()
  (use-package orglink
    :after org
    :config
    (add-hook 'spacemacs-post-user-config-hook #'global-orglink-mode)
    ))
```


#### org-remark {#org-remark}

hightlight and annotating

```elisp
(defun jh-org/init-org-remark ()
  (use-package org-remark))
```


#### org-web-tools {#org-web-tools}

org-web-tools
: url
    <https://github.com/alphapapa/org-web-tools>

org-protocol-capture-html : clipboard
    [GitHub - alphapapa/org-protocol-capture-html: Capture HTML from the browser s...](https://github.com/alphapapa/org-protocol-capture-html#selection-grabbing-function)

[alphapapa/org-web-tools#45 handling same-page relative links, such as footnotes](https://github.com/alphapapa/org-web-tools/issues/45)

위의 이슈를 확인한다. 코드 동작은 따로 확인해봐야 한다.

```elisp
(defun jh-org/init-org-web-tools ()
  (use-package org-web-tools
    :config
    ;; (require 'org-protocol-capture-html)
    ;; 클립보드에 복사 된 url 을 org 로 가져온다. footnote 는 개선 되야 한다.

    (defun org-web-tools--convert-fns-relative ()
      "Convert ^{n} format footnotes in document to org syntax."
      (interactive)
      (save-match-data
        (while (re-search-forward "\\^{\\([[:digit:]]+\\)}" nil t)
          (let ((match (match-string 1)))
            (replace-match (format "[fn:%s]" match))))))

    (defun org-web-tools--convert-fns-relative-alt ()
      "Convert [[#enN]][N]] format footnotes in document to org syntax."
      (interactive)
      (save-match-data
        (while (re-search-forward "\\[\\[#\\(en\\|fn\\)\\([[:digit:]]+\\)\\]\\[[[:digit:]\\|↩]+\\]\\]" nil t)
          ;; NB: 2 here not 1! cd also use (or) and test for first group containing digits
          (let ((match (match-string 2))
                (match-type (match-string 1)))
            (replace-match (format "[fn:%s]" match))
            ;; org-fns must be at bol to work:
            (when (and (equal match-type "fn") ;only for fns in footnotes section
                       (not (bolp)))
              (backward-sexp) ; move point to before org fn's "["
              (kill-line -0)))))) ; kill backward to bol
    ))
```


#### org-pandoc-import {#org-pandoc-import}



1.  The basic "get me out of here" ---
    <kbd>org-pandoc-import-{to,as}-org</kbd> allows you to easily convert supported non-org
    files to an org file/buffer with Pandoc
2.  "I don't even want to _see_ non-org files" --- <kbd>org-pandoc-import-transient-mode</kbd>
    is for you
    -   (via file handlers) intercepts requests for non-org files it knows it can convert
    -   uses <kbd>org-pandoc-import-to-org</kbd> to convert the file to a temporary org file
    -   opens this org file instead
    -   exports back to the original non-org file on save

<!--listend-->

```elisp
(defun jh-org/init-org-pandoc-import ()
  (use-package org-pandoc-import
    :defer t))
```


#### org-auto-tangles {#org-auto-tangles}

```elisp
(defun jh-org/init-org-auto-tangle ()
  (use-package org-auto-tangle
    :defer t
    :after org
    :hook (org-mode . org-auto-tangle-mode)
    :init
    (setq org-auto-tangle-default t)))
```


#### org-make-toc and toc-org {#org-make-toc-and-toc-org}

문서 상단에 프로퍼티로 TOC 를 포함하는 헤딩을 만들면 업데이트 해준다.
사용법은 여기에 <https://github.com/alphapapa/org-make-toc>
Hook 로 넣지 않고, 필요할 때 수동으로 호출 한다.

2023-03-31 toc-org 는 spacemacs-org 레이어에 있는데 따로 설정한다. 제대로
사용 못해봤다.

```elisp
  (defun jh-org/init-org-make-toc ()
    (use-package org-make-toc :defer t))
  ;; (add-hook 'org-mode-hook 'org-make-toc-mode) ; 수동으로 호출하자.

  ;; (defun jh-org/init-toc-org ()
  ;;   (use-package toc-org () :defer t))

  ;; (if (require 'toc-org nil t)
  ;;     (progn
  ;;       (setq toc-org-max-depth 5)
  ;;       ;; (add-hook 'org-mode-hook 'toc-org-mode)
  ;;       ;; (add-hook 'markdown-mode-hook 'toc-org-mode)
  ;;       ;; (define-key markdown-mode-map (kbd "\C-c\C-o") 'toc-org-markdown-follow-thing-at-point)
  ;;       )
  ;;   (warn "toc-org not found"))
```


#### org-babel {#org-babel}

<!--list-separator-->

-  ob-translate

    ```elisp
    (defun jh-org/init-ob-translate ()
      (use-package ob-translate
        :config
        (setq ob-translate:default-dest "ko")))
    ```

    ```translate
      Doom is a configuration framework for GNU Emacs tailored for Emacs bankruptcy veterans who want less framework in their frameworks, a modicum of stability (and reproducibility) from their package manager, and the performance of a hand rolled config (or better). It can be a foundation for your own config or a resource for Emacs enthusiasts to learn more about our favorite operating system.
    ```

<!--list-separator-->

-  ob-mermaid

    2023-03-23
    스페이스맥스에 restclient 레이어에 이미 있다.

    Mermaid is a tool for drawing systems diagrams.
    **NOTE**: The variable `ob-mermaid-cli-path` needs to be set in the config (because it will change from system to system).

    -   npm install -g @mermaid-js/mermaid-cli
    -   mmdc -i input.mmd -o output.svg

    <!--listend-->

    ```elisp
    (defun jh-org/init-ob-mermaid ()
      (use-package ob-mermaid
        :after org
        :init (add-to-list 'org-babel-load-languages '(mermaid . t))
        :config
        (setq ob-mermaid-cli-path "~/.asdf/shims/mmdc")
        )
      )
    ```


### org-modern {#org-modern}

2023-04-16 다시 한번 재확인. 쓰지 말자! 터미널 모드 호환 문제.
2023-04-30 GUI 모드에서만 사용하자

```elisp
(defun jh-org/post-init-org-modern ()

  (setq
   ;; Edit settings
   org-catch-invisible-edits 'show-and-error
   ;; org-special-ctrl-a/e t

   ;; Org styling, hide markup etc.
   org-hide-emphasis-markers t
   org-pretty-entities t ; nil
   )

  (setq org-modern-hide-stars nil) ; default -- 'leading
  (setq org-modern-label-border 'auto) ; 0.1 - 0.4 -- auto
  (setq org-modern-block-fringe 0) ; 0 - 16 - default 0
  (setq org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-horizontal-rule (make-string 36 ?─))

  (setq org-modern-statistics nil)
  (setq org-modern-tag nil)
  (setq org-modern-footnote nil)

  (setq org-modern-list
        '((?+ . "◦")
          (?- . "–")
          (?* . "★"))) ; BLACK STAR

  ;; (setq org-modern-checkbox nil) ; conflict org-pretty-symbol
  (setq org-modern-checkbox
        '((?X . "☒") ; completed
          ;; (?- . #("□–" 0 2 (composition ((2)))))
          (?- . "◩") ; progress
          (?\? . "▣") ; hold pause
          (?\s . "☐"))) ; todo

  (setq org-modern-todo nil)
  (setq org-modern-star nil)
  (setq org-modern-table nil)
  (setq org-modern-keyword nil)
  (setq org-modern-priority nil)
  (setq org-modern-block-name nil)
  (setq org-modern-timestamp nil)

  ;; I don't use those in documents anyway, and if I ever do I need to
  ;; remember what their standard looks are.
  (setq org-modern-internal-target nil)
  (setq org-modern-radio-target nil)

  (unless (display-graphic-p) ; disable on terminal
    (remove-hook 'org-mode-hook #'org-modern-mode))
  (remove-hook 'org-agenda-finalize-hook #'org-modern-agenda)
  )

(defun jh-org/init-org-modern-indent ()
  (use-package org-modern-indent
    :config
    (when (display-graphic-p) ; gui-mode
      (add-hook 'org-mode-hook #'org-modern-indent-mode 90) ; late hook
      )))
```


### citations with `citar` {#citations-with-citar}

[Citations in org-mode: Org-cite and Citar | Kristoffer Balintona](https://kristofferbalintona.me/posts/202206141852/)
Citations are built into org mode, but it's nice to have a way to complete them.

Citar 과 빌트인으로 다 커버한다.

```elisp
(defun jh-org/init-citar ()
  (use-package citar
    :ensure
    ;; :hook (org-mode . citar-capf-setup)
    :init
    (require 'oc)
    (setq config-bibfiles (list "~/sync/org/bib/zotero-biblatex.bib"))
    (setq citar-bibliography config-bibfiles)
    ;; use #+cite_export: csl apa.csl
    (setq org-cite-csl-styles-dir "~/sync/logseq/zotero/styles")
    (setq citar-notes-paths '("~/sync/org/roam/notes/"))

    (setq org-cite-global-bibliography config-bibfiles)
    (setq org-cite-insert-processor 'citar)
    (setq org-cite-follow-processor 'citar)
    (setq org-cite-activate-processor 'citar)

    (require 'all-the-icons)
    (setq citar-symbols
          `((file ,(all-the-icons-faicon "file-pdf-o" :face 'all-the-icons-green :v-adjust -0.1) . " ")
            (note ,(all-the-icons-material "speaker_notes" :face 'all-the-icons-blue :v-adjust -0.3) . " ")
            (link ,(all-the-icons-octicon "link" :face 'all-the-icons-orange :v-adjust 0.01) . " ")))
    (setq citar-symbol-separator "  ")
    )
  )

(defun jh-org/init-citar-embark ()
  (use-package citar-embark
    :after citar embark
    :ensure
    :config
    (citar-embark-mode 1)))
```


### org-super-agenda {#org-super-agenda}

활용 가능성이 많은데 여기 룰에 따라야 한다.

```elisp
(defun jh-org/init-org-super-agenda ()
  (use-package org-super-agenda
    :after org
    :demand)
  )
```


## Funcs {#funcs}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
```


### get-id-to-clipboard {#get-id-to-clipboard}

[Improving my Orgmode workflow | König von Haunstetten](https://koenig-haunstetten.de/2018/02/17/improving-my-orgmode-workflow/)
org-capture 는 work.org 로 모인다. 투두, 노트 뭐 등등 다 refile 파일로 모은다.
refile 에는 할일이 쌓인다. agenda 를 열면 한눈에 파악 할 수 있다. 오직 refile 만
일단 보는 것이다. 물론 일정기간(2 주) 뭐 등등 처리 못하는 일은 따로 분류 한다.
그리고 refile 에 글어온 TODO 는 org-journal 에 리스트로 남긴다.

거기에 복붙하고 처리하면 된다. ID 가 생성되면 좋은 점이 있다. caldav 가 가능하다는
점이다. 굳이 그럴 필요가 있나 싶지만. 헤딩만 똑같게 해주면 보는 것도 쉬울 것이다.

```elisp
(defun my/get-id-to-clipboard() "Copy an ID link with the
  headline to killring, if no ID is there then create a new unique
  ID.  This function works only in org-mode or org-agenda buffers.
  The purpose of this function is to easily construct id:-links to
  org-mode items. If its assigned to a key it saves you marking the
  text and copying to the killring."
       (interactive)
       (when (eq major-mode 'org-agenda-mode) ;switch to orgmode
         (org-agenda-show)
         (org-agenda-goto))
       (when (eq major-mode 'org-mode) ; do this only in org-mode buffers
         (setq mytmphead (nth 4 (org-heading-components)))
         (setq mytmpid (funcall 'org-id-get-create))
         (setq mytmplink (format "[[id:%s][%s]]" mytmpid mytmphead))
         (kill-new mytmplink)
         (message "Copied %s to killring (clipboard)" mytmplink)
         ))
(let ((map global-map))
  (define-key map (kbd "C-c j g") 'my/get-id-to-clipboard)
  )
```


### Split and indirect orgtree {#split-and-indirect-orgtree}

```elisp
  ;;;; copy from writers-dot-spacemaccs
(defun my/split-and-indirect-orgtree ()
  "Splits window to the right and opens an org tree section in it"
  (interactive)
  (split-window-right)
  (org-tree-to-indirect-buffer)
  (windmove-right))

(defun my/kill-and-unsplit-orgtree ()
  "Kills the cloned buffer and deletes the window."
  (interactive)
  (kill-this-buffer)
  (delete-window))
```


### org-toggle-markup {#org-toggle-markup}

```elisp
(defun my/org-toggle-markup ()
  (interactive)
  (setq org-hide-emphasis-markers (not org-hide-emphasis-markers))
  (font-lock-fontify-buffer :interactively))
```


### open org files {#open-org-files}

```elisp
;; (defun my/open-org-slipbox-file ()
;;   (interactive )
;;   (find-file org-slipbox-file))

(defun open-org-inbox-file ()
  "Open `org-inbox-file'"
  (interactive)
  (find-file org-inbox-file))

(defalias 'open-org-default-notes-file #'open-org-inbox-file
  "Open `org-default-notes-file'")

(defun org-note-files ()
  "Get the list of `org-mode' file in `org-note-directory'."
  (interactive)
  (find-lisp-find-files org-note-directory "\.org$"))

(defun org-workflow-files ()
  "Get the list of `org-mode' file in `org-note-directory'."
  (interactive)
  (find-lisp-find-files org-workflow-directory "\.org$"))

;; (defun org-super-agenda (&optional arg)
;;   (interactive "P")
;;   (org-agenda arg "o"))
```


### align-comments {#align-comments}

```elisp
(defun my/align-comments (beginning end)
  "Align comments in region."
  (interactive "*r")
  (align-regexp beginning end (concat "\\(\\s-*\\)"
                                      (regexp-quote comment-start)) nil 2))
```


### Indent-buffer {#indent-buffer}

```elisp
(defun my/indent-buffer ()
  "Indent buffer."
  (interactive)
  (indent-region (point-min) (point-max)))
```


### comment-or-uncomment-region {#comment-or-uncomment-region}

```elisp
(defun my/comment-or-uncomment-region ()
  "Comment or uncomment region with just a character (e.g. '/'). If a region is
active call comment-or-uncomment-region, otherwise just insert the given char."
  (interactive)
  (call-interactively (if (region-active-p)
                          'comment-or-uncomment-region
                        'self-insert-command)))
```


### org-indent-src-block {#org-indent-src-block}

```elisp
(defun my/org-indent-src-block ()
  (interactive)
  (org-edit-special)
  (my/indent-buffer)
  (org-edit-src-exit))
```


### org-sort-by-priority {#org-sort-by-priority}

```elisp
(defun my/org-sort-by-priority ()
  "Sort entries in level=2 by priority."
  (interactive)
  (org-map-entries (lambda () (condition-case nil
                                  (org-sort-entries nil ?p)
                                (error nil)))
                   "LEVEL=1")
  (org-set-startup-visibility))
```


### Easier file links {#easier-file-links}

While <kbd>org-insert-link</kbd> is all very well and good, a large portion of the time I
want to insert a file, and so it would be good to have a way to skip straight to
that and avoid the description prompt. Looking at <kbd>org-link-parameters</kbd>, we can
see that the `"file"` link type uses the completion function
<kbd>org-link-complete-file</kbd>, so let's use that to make a little file-link inserting
function.

```emacs-lisp
(defun org-insert-file-link ()
  "Insert a file link.  At the prompt, enter the filename."
  (interactive)
  (insert (format "[[%s]]" (org-link-complete-file))))
```


### Removing Links {#removing-links}

```elisp
(defun org-delete-link ()
  "Remove the link part of an org-mode link at point and keep
  only the description"
  (interactive)
  (let ((elem (org-element-context)))
    (when (eq (car elem) 'link)
      (let* ((content-begin (org-element-property :contents-begin elem))
             (content-end  (org-element-property :contents-end elem))
             (link-begin (org-element-property :begin elem))
             (link-end (org-element-property :end elem)))
        (when (and content-begin content-end)
          (let ((content (buffer-substring-no-properties content-begin content-end)))
            (delete-region link-begin link-end)
            (insert (concat content " "))))))))
```


### Previewing Info files {#previewing-info-files}

DW 설정인데 확인해볼 것!
I'm experimenting with generating `Texinfo` from Org
Mode files and I need a way to quickly preview the resulting `.info` files. This
`auto-mode-alist` entry automatically previews an `.info` file when visited with
`find-file`:

```elisp
  (add-to-list 'auto-mode-alist '("\\.info\\'" . Info-on-current-buffer))
```


## Configs {#configs}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
```


### Terminal-mode {#terminal-mode}

-   [X] org-heading
    현재 터미널 모드에서 heading 사이즈 조정을 다 제거한 상태라
    별도로 필요가 없다.
-   [X] disable org-appear

<!--listend-->

```elisp
(unless (display-graphic-p) ; terminal
  ;; (setq org-level-color-stars-only t)
  ;; (setq org-appear-trigger 'on-change) ; 'manual
  (setq org-hide-emphasis-markers nil)
  (remove-hook 'org-mode-hook 'org-appear-mode)
  )
```


## Keybindings {#keybindings}


### `Global` keybindings {#global-keybindings}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-

  ;; 파일 패스 복사 =SPC f y l=
  (global-set-key (kbd "C-c f") 'spacemacs/copy-file-path)
  ;; (global-set-key (kbd "C-c F") 'spacemacs/copy-file-path-with-line)
  (global-set-key (kbd "C-c F") 'spacemacs/projectile-copy-file-path)

  ;; search to narrow with heading and tag
  (global-set-key (kbd "C-c g") 'consult-org-heading)

  ;; Shortcuts to Interactive Functions
  ;; "C-x n" prefix
  (global-set-key (kbd "C-x n m") #'my/split-and-indirect-orgtree)
  (global-set-key (kbd "C-x n M") #'my/kill-and-unsplit-orgtree)
  (spacemacs/set-leader-keys "nm" #'my/split-and-indirect-orgtree)
  (spacemacs/set-leader-keys "nM" #'my/kill-and-unsplit-orgtree)

  (global-set-key (kbd "C-c j o t") 'org-make-toc)
  ;; (global-set-key (kbd "C-c j o s") 'open-org-slipbox-file)
  (global-set-key (kbd "C-c j o i") 'open-org-inbox-file)
  ;; (global-set-key (kbd "C-c j o r") 'open-org-refile-file)
  ;; (global-set-key (kbd "C-c j o p") 'open-org-project-file)
  (global-set-key (kbd "C-c j o n") 'org-note-files)
  (global-set-key (kbd "C-c j o w") 'org-workflow-files)

  (global-set-key (kbd "C-c j o S") 'org-gcal-sync)
```


### `Spacemacs` keybindings {#spacemacs-keybindings}

```elisp
(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "TM" 'my/org-toggle-markup)
(spacemacs/set-leader-keys "tM" #'my/org-toggle-markup)

(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "E" 'org-set-effort)
(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "D" 'org-deadline)
(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "S" 'org-schedule)

(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "g" 'consult-org-heading)
(spacemacs/set-leader-keys-for-major-mode 'org-journal-mode
  "g" 'consult-org-heading)

(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "\\" 'org-tags-sparse-tree)
(spacemacs/set-leader-keys-for-major-mode 'org-journal-mode
  "\\" 'org-tags-sparse-tree)

(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "Tm" 'org-toggle-item)
(spacemacs/set-leader-keys-for-major-mode 'org-journal-mode
  "Tm" 'org-toggle-item)

(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "TP" 'org-present)

;; (spacemacs/set-leader-keys-for-major-mode 'org-mode
;;   "ic" 'org-bibtex-create)
;; (spacemacs/set-leader-keys-for-major-mode 'org-mode
;;   "ec" 'org-bibtex)
```


### custom-functions {#custom-functions}

```elisp
(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "R" 'org-delete-link)
(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "F" 'org-insert-file-link)
```


### org-web-tools {#org-web-tools}



```elisp
;; Display and capture web content with Org-mode
(global-set-key (kbd "C-c w r") 'org-web-tools-read-url-as-org)
(spacemacs/declare-prefix "Cw"  "org-web-tools")
(spacemacs/set-leader-keys "Cwr" 'org-web-tools-read-url-as-org)
```


### Utilities {#utilities}



```elisp
(define-key org-mode-map (kbd "C-c y") 'org-cliplink)

(evil-define-key '(insert) org-mode-map (kbd "C-u") 'undo-fu-only-undo)
(evil-define-key '(insert) org-mode-map (kbd "C-r") 'undo-fu-only-redo)

;; (evil-define-key '(insert) org-mode-map (kbd "C-0") 'begginng-of-line)
;; (evil-define-key '(insert) org-mode-map (kbd "C-4") 'end-of-line)

;; flameshot 으로 스크린샷 한 뒤, 바로 붙여넣기
;; 22/10/04--15:18 :: flameshot 저장하면 자동으로 클립보드에
;; full-path가 복사된다. imglink 스니펫을 부르고 경로를 복사한다.
;; 스크린샷 및 이미지를 관리하기에 이러한 방법이 더 좋다.
(evil-define-key '(normal insert visual) org-mode-map (kbd "C-c M-y") 'org-download-clipboard)
;; (define-key map (kbd "C-c M-y") 'org-download-clipboard)
```
