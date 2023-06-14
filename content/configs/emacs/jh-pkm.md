+++
title = "jh-pkm layer"
author = ["Junghan Kim"]
date = 2023-06-12T00:00:00+09:00
lastmod = 2023-06-14T16:53:00+09:00
keywords = ["configs"]
draft = false
+++

{{< hint info >}}
PKM (Personal Knowledge Manager)
{{< /hint >}}

<!--more-->


## Goals {#goals}

org-roam 기반 제텔카스텐 지신 관리 시스템. 워크플로우와
나누어서 지식 관리 측면 만 다룬다. 같은 Org 모드를 사용하기에 섞어서 사용하기
쉽다. 그렇게 하면 꼬인다.


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
   deft
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

(defconst jh-pkm-packages
  '(
    org-roam
    deft

    citar-org-roam
    consult-org-roam

    ;; (delve :location (recipe :fetcher github
    ;;                          :repo "publicimageltd/delve"
    ;;                          :files ("*.el" "*.org")))

    ;; (triples :location (recipe :fetcher github :branch "main"
    ;;                            :repo "ahyatt/triples"
    ;;                            :files ("*.el" "*.org")))
    ;; (ekg :location (recipe :fetcher github :branch "main"
    ;;                        :repo "ahyatt/ekg"
    ;;                        :files ("*.el" "*.org" "doc/*.*"))) ; emacs knowledge graph
    ))
```


### `deft` browser {#deft-browser}

```elisp
;; deft layer configuration
;; https://github.com/jrblevin/deft
(defun jh-pkm/post-init-deft ()
  (global-set-key (kbd "C-x D") 'deft-find-file)
  ;; (global-set-key (kbd "<f2>") 'spacemacs/deft)
  (setq deft-directory (file-truename (concat org-directory "/logseq/")))
  ;; (setq deft-directory "~/sync/org/")
  (setq deft-recursive t)
  ;; auto-safe 를 꺼야 지겹게 저장 안된다. 아니면 시간을 넉넉하게 잡던가
  ;; 기본은 1초였다. 이게 말이되나! 0은 끄는 것!
  (setq deft-auto-save-interval 0) ;; must turn off auto-safe!!
  ;; (setq deft-file-naming-rules '((noslash . "_")))
  ;; (nospace . "-")
  ;; (case-fn . downcase))
  (setq deft-extensions '("org" "md"))
  (setq deft-use-filter-string-for-filename t)
  (setq deft-org-mode-title-prefix t)
  (setq deft-recursive-ignore-dir-regexp (regexp-opt '("." ".." "attic")))
  (setq deft-use-filename-as-title t)
  (setq deft-strip-summary-regexp
        (concat "\\("
                "[\n\t]" ;; blank
                "\\|^#\\+[[:upper:]_]+:.*$" ;; org-mode metadata
                "\\|^#\\+[[:alnum:]_]+:.*$" ;; org-mode metadata
                "\\)"))
  ;; (setq-default deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n"
  ;;               deft-use-filename-as-title t)
  )
```


### Citar-org-roam {#citar-org-roam}

<span class="timestamp-wrapper"><span class="timestamp">[2023-03-24 Fri 15:25] </span></span> The citar-open-notes and citar-open commands will work as
normal, but will use org-roam to open notes. To define a sub-file node as a
bibliographic note (ref node), use citar-org-roam-ref-add to add the ROAM_REF to
the node at point. Beyond that, the only interactive command this package
provides is: citar-org-roam-cited: presents a list of notes that cite the
selected references

```elisp
(defun jh-pkm/init-citar-org-roam ()
  (use-package citar-org-roam :after citar))
```


### <kbd>Custom</kbd> Org-roam {#custom-org-roam}


#### Start Configuration <span class="tag"><span class="donotmove">donotmove</span></span> {#start-configuration}

```elisp
;;;; Org-roam

(defun jh-pkm/post-init-org-roam ()
  (when (> emacs-major-version 28) ; Emacs-29 use builtin pkgs
    (setq org-roam-database-connector 'sqlite-builtin))

  ;; (setq org-roam-ui-open-on-start nil) ; default t

  (setq org-roam-index-file (concat org-roam-directory "index.org"))

  (org-roam-db-autosync-mode +1)

  ;; (setq org-hugo-base-dir (file-truename "~/git/blog/"))
  (setq org-hugo-base-dir blog-admin-dir)
  (setq org-roam-db-gc-threshold most-positive-fixnum)
  (setq org-roam-v2-ack t)

  ;; (setq org-roam-mode-sections
  ;;  (list #'org-roam-backlinks-section
  ;;        #'org-roam-reflinks-section
  ;;        #'org-roam-unlinked-references-section))

  (setq org-roam-mode-sections
        '((org-roam-backlinks-section :unique t)
          org-roam-reflinks-section))

  ;; 켜지면 입력 할 때 계속 Completion 리스트가 나타난다. 수동으로 하자.
  (setq org-roam-completion-everywhere nil)
```


#### Org-roam-node-type {#org-roam-node-type}

```elisp
;; https://jethrokuan.github.io/org-roam-guide/
;; (cl-defmethod org-roam-node-type ((node org-roam-node))
;;   "Return the TYPE of NODE."
;;   (condition-case nil
;;       (file-name-nondirectory
;;        (directory-file-name
;;         (file-name-directory
;;          (file-relative-name (org-roam-node-file node) org-roam-directory))))
;;     (error "")))

;; 모든 새로운 제텔에는 Draft 를 붙인다. HUGO_DRAFT 가 있는데 이게
;; 어떻게 활용 될 수 있나? 이미 보낸 글도 수정 할 수 있으니까
;; 그때는 draft 라고 하는게 맞겠다.
(defun  jethro/tag-new-node-as-draft ()
  (org-roam-tag-add  '("draft")))
(add-hook 'org-roam-capture-new-node-hook #'jethro/tag-new-node-as-draft)

(setq org-roam-node-display-template (concat
                                      (propertize "${directories:10} " 'face 'org-checkbox)
                                      (propertize "${hierarchy:80} " 'face 'org-roam-title)
                                      (propertize "${backlinkscount:5} " 'face 'org-formula)
                                      (propertize "${tags:40}" 'face 'org-tag))
      org-roam-node-annotation-function
      (lambda (node) (marginalia--time (org-roam-node-file-mtime node))))

;; https://github.com/org-roam/org-roam/wiki/User-contributed-Tricks#showing-node-hierarchy
(cl-defmethod org-roam-node-hierarchy ((node org-roam-node))
  (let ((level (org-roam-node-level node)))
    (concat
     (when (> level 0) (concat (org-roam-node-file-title node) " > "))
     (when (> level 1) (concat (string-join (org-roam-node-olp node) " > ") " > "))
     (org-roam-node-title node))))

(cl-defmethod org-roam-node-directories ((node org-roam-node))
  (if-let ((dirs (file-name-directory (file-relative-name (org-roam-node-file node) org-roam-directory))))
      (format "(%s)" (car (split-string dirs "/")))
    ""))

(cl-defmethod org-roam-node-backlinkscount ((node org-roam-node))
  (let* ((count (caar (org-roam-db-query
                       [:select (funcall count source)
                                :from links
                                :where (= dest $s1)
                                :and (= type "id")]
                       (org-roam-node-id node)))))
    (format "[%d]" count)))

(defun org-roam-open-refs ()
  "Open REFs of the node at point."
  (interactive)
  (save-excursion
    (goto-char (org-roam-node-point (org-roam-node-at-point 'assert)))
    (when-let* ((p (org-entry-get (point) "ROAM_REFS"))
                (refs (when p (split-string-and-unquote p)))
                (refs (if (length> refs 1)
                          (completing-read-multiple "Open: " refs)
                        refs))
                (user-error "No ROAM_REFS found"))

      (when-let ((oc-cites (seq-map
                            (lambda (ref) (substring ref 1))
                            (seq-filter (apply-partially #'string-prefix-p "@") refs))))
        (citar-run-default-action oc-cites))

      (dolist (ref refs)
        (unless (string-prefix-p "@" ref)
          (browse-url ref))))))

(defun force-org-rebuild-cache ()
  "Rebuild the `org-mode' and `org-roam' cache."
  (interactive)
  (org-id-update-id-locations)
  (org-roam-db-sync)
  (org-roam-update-org-id-locations))
```


#### Embark-org-roam {#embark-org-roam}



```elisp
(with-eval-after-load 'embark
  (defun org-roam-backlinks-query (node)
    "Gets the backlinks of NODE with `org-roam-db-query'."
    (org-roam-db-query
     [:select [source dest]
              :from links
              :where (= dest $s1)
              :and (= type "id")]
     (org-roam-node-id node)))

  (defun org-roam-backlinks-p (source node)
    "Predicate function that checks if NODE is a backlink of SOURCE."
    (let* ((source-id (org-roam-node-id source))
           (backlinks (org-roam-backlinks-query source))
           (id (org-roam-node-id node))
           (id-list (list id source-id)))
      (member id-list backlinks)))

  (defun org-roam-backlinks--read-node-backlinks (source)
    "Runs `org-roam-node-read' on the backlinks of SOURCE.
 The predicate used as `org-roam-node-read''s filter-fn is
 `org-roam-backlinks-p'."
    (org-roam-node-read nil (apply-partially #'org-roam-backlinks-p source)))

  (defun org-roam-backlinks-node-read (entry)
    "Read a NODE and run `org-roam-backlinks--read-node-backlinks'."
    (let* ((node (get-text-property 0 'node entry))
           (backlink (org-roam-backlinks--read-node-backlinks node)))
      (find-file (org-roam-node-file backlink))))

  (defvar-keymap embark-org-roam-map
    :doc "Keymap for Embark org roam node actions."
    :parent embark-general-map
    "i" #'org-roam-node-insert
    "b" #'org-roam-backlinks-node-read
    "r" #'org-roam-node-random
    )
  (add-to-list 'embark-keymap-alist '(org-roam-node . embark-org-roam-map)))
```


#### <kbd>tag</kbd> and <kbd>filter</kbd> search {#tag-and-filter-search}

```elisp
(defun my/org-roam-get-all-tags ()
  "Save all roam tags to a buffer visting the file ~/Test."
  (interactive)
  (with-current-buffer (get-buffer-create "*Tags*")
    (erase-buffer)
    (mapc #'(lambda (n) (insert (car n) "\n"))
          (org-roam-db-query [:select :distinct [tag] :from tags ]))
    (pop-to-buffer (current-buffer))))

(defun my/roam-tag-filter (tag)
  "Return function that filters based on TAG."
  (lambda (n) (member tag (org-roam-node-tags n))))

;; To be used in `org-roam-dailies-capture-template'.
(defun my/problem-org-output ()
  "Return org structure for each org-roam problem."
  (mapconcat
   (lambda (node) (format "- [[id:%s][%s]]: " (org-roam-node-id node) (org-roam-node-title node)))
   (-filter (my/roam-tag-filter "problem") (org-roam-node-list))
   "\n"))

;; Set up a new link type for org
(require 'ol)
(org-link-set-parameters "roam"
                         :follow #'my/org-roam-open-link
                         :store #'my/org-roam-store-link)
(defun my/org-roam-open-link (id _)
  "Visit the org-roam page TITLE."
  (org-roam-node-visit (org-roam-node-from-id id)))

(defun my/org-roam-store-link ()
  (when (org-roam-buffer-p)
    (let ((node (org-roam-node-at-point)))
      (org-link-store-props
       :type "roam"
       :link (format "roam:%s" (org-roam-node-id node))
       :description (org-roam-node-title node)))))

(defun my/org-roam-tag-search ()
  (interactive)
  (let ((org-roam-node-display-template "${tags:25} ${title}"))
    (org-roam-node-open
     (org-roam-node-read nil nil nil t "Tag: "))))

(defun my/org-roam-complete-tag (tag)
  (org-roam-node-open (org-roam-node-read nil (lambda (n) (member tag (org-roam-node-tags n))) nil t (concat (s-upcase tag) ": "))))

;; term
(defun my/org-roam-node-find-terms ()
  (interactive)
  (my/org-roam-complete-tag "terms"))

;; main
(defun my/org-roam-node-find-notes ()
  (interactive)
  (my/org-roam-complete-tag "notes"))

;; reference
(defun my/org-roam-node-find-references ()
  (interactive)
  (my/org-roam-complete-tag "references"))

;; article
(defun my/org-roam-node-find-articles ()
  (interactive)
  (my/org-roam-complete-tag "articles"))

;; person
(defun my/org-roam-node-find-person ()
  (interactive)
  (my/org-roam-complete-tag "person"))
```


#### Filter org-roam-node-find by subdirectories {#filter-org-roam-node-find-by-subdirectories}

```elisp
(defun my/org-roam-find-posts-dir ()
  (interactive)
  (my/org-roam-node-find-in-selected-dirs (list "posts" )))

(defun my/org-roam-find-terms-dir ()
  (interactive)
  (my/org-roam-node-find-in-selected-dirs (list "terms" )))

(defun my/org-roam-find-notes-dir ()
  (interactive)
  (my/org-roam-node-find-in-selected-dirs (list "notes" )))

(defun my/org-roam-find-refs-dir ()
  (interactive)
  (my/org-roam-node-find-in-selected-dirs (list "refs" )))

(defun my/org-roam-find-configs-dir ()
  (interactive)
  (my/org-roam-node-find-in-selected-dirs (list "configs" )))

(defun my/org-roam-find-in-only-subset ()
  (interactive)
  (my/org-roam-node-find-in-selected-dirs (list "posts" "terms" "notes")))

(defun my/org-roam-find-except-daily ()
  (interactive)
  (my/org-roam-node-find-in-selected-dirs (list "terms") 'EXCLUDE))
;; you can pass t instead of 'EXCLUDE

;; Below is an adjusted version of the main command to achieve the preset functions like those above
(defun my/org-roam-node-find-in-selected-dirs (&optional dirs exclude)
  "Show list of `org-roam-node-find' only in selected directories.

You will get a completion in minibuffer to choose one or more
directories from a pre-defined candidate list.

Optionally You can pass EXCLUDE to exclude files in the selected directories
with using `universal-argument' (\\[universal-argument]).

Optionally in Elisp, you can pass DIRS, a list of
directories. In this case, you do not get the completion in
minibuffer.

This command assumes that the subdirectories in the list are
relative to `org-roam-directory`.

Directly change the list in the program."
  (interactive)
  (let* ((exclude (or exclude current-prefix-arg))
         (dirs-selected
          (if dirs dirs
            (completing-read-multiple "Select dir(s): "
                                      (list "notes" "posts" "refs"))))
         (abs-dir-names (mapcar (lambda (dir)
                                  (expand-file-name dir org-roam-directory))
                                dirs-selected)))
    (org-roam-node-find
     nil nil
     (lambda (node)
       (let ((file (org-roam-node-file node))
             (result nil))
         (dolist (dir abs-dir-names result)
           ;; Ensure to do all the dirs in
           ;; abs-dir-names, but once result is t,
           ;; don't override it.
           (unless result
             ;; `file-in-directory-p' seems work to when the file is
             ;; directly under the directory. It returns nil when the
             ;; file is a farther descendant. `string-prefix-p' can be
             ;; used instead if both dir and file are absolute file
             ;; names, and see if file is a farther descendant of dir
             (setq result (string-prefix-p dir file))))
         ;; When exclude, the result needs to be reversed: t->nil,
         ;; nil->t Note `not' is not suitable because nil returns nil.
         (when exclude
           (if result (setq result nil) (setq result t)))
         result)))))
```


#### `Org-roam-capture-templates` {#org-roam-capture-templates}

캡처 정책을 어떻게 가져갈 것인가? 이런게 정말 어려운 문제다.

> [How I Take Notes with Org-roam](https://jethrokuan.github.io/org-roam-guide/)
> 이 글에 중요한 핵심이 있다. 제텔카스텐 이야기다.
> 아. 이 친구 이야기에 놀랍다. 이게 모든 기능이 다 있다고 해서 좋은게 아니다.
> 가볍게 쓰고 핵심에 다가서는게 가장 중요하다는 말이다. 이거 내가
> 사용하는 시스템도 무슨 의미인가 깔끔하게 정돈이 안되어 있다. 이게
> 문제다. 저널은 사실 없어야 한다. 단일 파일로 관리하고 어젠다에
> 집중해야 한다. 이 글 마저도 분산되어 있어서 뭘 봐야 할지 모르게된다.

캡처 코드는 아래와 같다.

```elisp
;;;;; org-roam-capture-templates

(setq org-roam-capture-templates
      '(
        ("t" "terms" plain
         "%?"
         :if-new
         (file+head
          "terms/${slug}.org"
          "#+title: ${title}\n#+DATE: %T\n#+Time-stamp: <>\n#+filetags: :terms:\n\n")
         :immediate-finish t
         :unnarrowed t)

        ("n" "notes" plain
         "%?"
         :if-new
         (file+head
          "notes/${slug}.org"
          "#+title: ${title}\n#+DATE: %T\n#+Time-stamp: <>\n#+filetags: :notes:\n\n")
         :immediate-finish t
         :unnarrowed t)

        ("a" "articles" plain "%?"
         :if-new
         (file+head
          "posts/${slug}.org"
          "#+title: ${title}\n#+DATE: %T\n#+Time-stamp: <>\n#+filetags: :articles:\n\n")
         :immediate-finish t
         :unnarrowed t)
        ))
;;         ("r" "reference" plain "%?"
;;          :if-new
;;          (file+head "notes/${slug}.org"
;;                     "#+title: ${title}\n#+DATE: %T\n#+filetags: :reference:\n\n")
;;          :immediate-finish t
;;          :unnarrowed t)
```


#### Org roam hacks for better productivity {#org-roam-hacks-for-better-productivity}

<https://systemcrafters.net/build-a-second-brain-in-emacs/5-org-roam-hacks/>

위 글과 영상을 보면 다 필요할 것 같다. 있으면 좋을까? 그게 아니더라.

```elisp
(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (push arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

(defun my/org-roam-filter-by-tag (tag-name)
  (lambda (node)
    (member tag-name (org-roam-node-tags node))))

(defun my/org-roam-list-notes-by-tag (tag-name)
  (mapcar #'org-roam-node-file
          (seq-filter
           (my/org-roam-filter-by-tag tag-name)
           (org-roam-node-list))))
```


#### Citation and Bibliography management {#citation-and-bibliography-management}

<!--list-separator-->

-  Enable `citar-org-roam`

    ```elisp
    (require 'citar-org-roam)
    (setq citar-org-roam-subdir "refs")
    ;; enable citar-org-roam
    (citar-org-roam-mode 1)
    ```

<!--list-separator-->

-  citar-org-roam--create-capture-note

    결국 이렇게 정착했다.

    ```elisp
    ;; (require 'bibtex)
    ;; citar-org-roam only offers the citar-org-roam-note-title-template variable
    ;; for customizing the contents of a new note and no way to specify a custom
    ;; capture template. And the title template uses citar's own format, which means
    ;; we can't run arbitrary functions in it.
    ;;
    ;; Left with no other options, we override the
    ;; citar-org-roam--create-capture-note function and use our own template in it.

    (defun dh/citar-org-roam--create-capture-note (citekey entry)
      "Open or create org-roam node for CITEKEY and ENTRY."
      ;; adapted from https://jethrokuan.github.io/org-roam-guide/#orgc48eb0d
      (let ((title (citar-format--entry
                    citar-org-roam-note-title-template entry)))
        (org-roam-capture-
         :templates
         '(("r" "references" plain "%?" :if-new
            (file+head
             "%(concat
     (when citar-org-roam-subdir (concat citar-org-roam-subdir \"/\")) \"${citekey}.org\")"
             "#+title: ${title}\n#+date: %T\n#+Time-stamp: <>\n#+filetags: :references:\n\n")
            :immediate-finish t
            :unnarrowed t))
         :info (list :citekey citekey)
         :node (org-roam-node-create :title title)
         :props '(:finalize find-file))
        (org-roam-ref-add (concat "@" citekey))))

    (advice-add #'citar-org-roam--create-capture-note :override #'dh/citar-org-roam--create-capture-note)

    (defun dh/org-cite-export-bibliography-advice (fn keyword _ info)
      (if (org-cite-list-keys info)
          (funcall fn keyword nil info)))

    ;; The CSL style we use causes an error when trying to export an empty bibliography. Wrap the relevant function to
    ;; prevent that from happening.
    (advice-add #'org-cite-export-bibliography :around #'dh/org-cite-export-bibliography-advice)
    ```


#### `Private Draft and Noexport` management {#private-draft-and-noexport-management}



<!--list-separator-->

-  `org-hugo-link` with org-link-advice and org-link-by-id



    -   noexport 태그를 헤딩에 넣으면 해당 헤딩은 md 로 출력하지 않는다.
        즉 해당 글은 완전히 공개 되지 않는 것이다.

    -   :PRIVATE: 를 프로퍼티 넣으면 링크 연결을 제거한다. 파일은 md 로 변환 되었기
        때문에 사실 의미가 없다.

    -   :EXPORT_FILE_NAME: excluded-post
        는 파일 전체를 Export 하지 않는다. 이건 문제가 될 수 있다.

    <!--listend-->

    ```elisp
    (defun dh/org-link-advice (fn link desc &rest rest)
      (if (string= "id" (org-element-property :type link))
          (dh/org-link-by-id fn link desc rest)
        (apply fn link desc rest)))

    (defun dh/org-link-by-id (fn link desc rest)
      (let ((node (org-roam-node-from-id (org-element-property :path link)))
            (protocols '("http://" "https://" "ftp://")))
        (if (assoc-string "PRIVATE" (org-roam-node-properties node))
            ;; The linked-to note is private. If it has a ROAM_REFS property with a URL in it, link to that URL, otherwise
            ;; only insert the link description, but no target.
            (if-let ((url (seq-find (lambda (arg) (cl-some (lambda (p) (string-prefix-p p arg)) protocols))
                                    (split-string-and-unquote (or (cdr (assoc-string "ROAM_REFS" (org-roam-node-properties node))) "")))))
                (format "[%s](%s)" desc url)
              desc)
          ;; Note isn't private, use original FN.
          (apply fn link desc rest))))

    (advice-add #'org-hugo-link :around #'dh/org-link-advice)
    ```


#### <span class="org-todo todo TODO">TODO</span> `Export` management {#export-management}

수정이 필요하다. 일단 나는 수동으로 한다. 지식 관리하는데 자동화를
다하려고 한다?! 하나 씩 귀하게 여겨야 한다.

<!--list-separator-->

-  website generation

    ```elisp
    (defun dh/org-roam-node-directory (node)
      (string-remove-suffix
       "/"
       (string-remove-prefix
        "/"
        (string-remove-prefix
         org-roam-directory
         (file-name-directory (org-roam-node-file node))))))

    (defun dh/org-roam-articles ()
      (cl-remove-if-not
       (lambda (node)
         (string= "articles" (cdr (assoc-string "KIND" (org-roam-node-properties node)))))
       (org-roam-node-list)))

    (defun dh/org-roam-to-hugo (section files)
      "Call `org-hugo-export-to-md' on all Org FILES.
    All files have to be in `org-roam-directory'. Output is written
    relative to SECTION in `org-hugo-base-dir'. Org files in
    subdirectories of `org-roam-directory' will get matching
    subdirectories underneath SECTION."
      (mapcar
       (lambda (node)
         (with-current-buffer (find-file-noselect (org-roam-node-file node))
           (let ((org-hugo-section (file-name-concat section (dh/org-roam-node-directory node))))
             (org-hugo-export-to-md))))
       files))

    (defun dh/org-insert-date-keyword ()
      (org-roam-set-keyword "date" (format-time-string "[%Y-%m-%d %a]" (current-time))))

    (add-hook 'org-roam-capture-new-node-hook #'dh/org-insert-date-keyword)

    (defun dh/org-export-before-parsing (backend)
      (when (string= backend "hugo")
        (org-roam-set-keyword
         "hugo_lastmod"
         (format-time-string "%Y-%m-%d" (file-attribute-modification-time (file-attributes (buffer-file-name)))))))

    ;; (dh/org-roam-to-hugo "posts" (dh/org-roam-articles))
    ```

<!--list-separator-->

-  `PRIVATE` org-roam-public-notes :: export

    article 또는 PRIVATE 이 붙어 있지 않는 모든 노트는 notes 섹션으로
    보냅니다.

    ```elisp
    (defun dh/org-roam-public-notes ()
      (cl-remove-if
       (lambda (node)
         (or
          (cdr (assoc-string "PRIVATE" (org-roam-node-properties node)))
          (string= "articles" (cdr (assoc-string "KIND" (org-roam-node-properties node))))))
       (org-roam-node-list)))
    ;; (dh/org-roam-to-hugo "notes" (dh/org-roam-public-notes))
    ```

<!--list-separator-->

-  export and update org-id

    ```elisp
    (defun custom-org-protocol-focus-advice (orig &rest args)
      (x-focus-frame nil)
      (apply orig args))

    (advice-add 'org-roam-protocol-open-ref :around
                #'custom-org-protocol-focus-advice)
    (advice-add 'org-roam-protocol-open-file :around
                #'custom-org-protocol-focus-advice)

    ;; (defun my/org-roam-export-all ()
    ;;   "Re-exports all Org-roam files to Hugo markdown."
    ;;   (interactive)

    ;;   (dolist (f (org-roam-list-files))
    ;;     (with-current-buffer (find-file f)
    ;;       (when (s-contains? "SETUPFILE" (buffer-string))
    ;;         (org-hugo-export-wim-to-md)))))
    ;; (remove-hook 'find-file-hook #'+org-roam-open-buffer-maybe-h)

    ;;   (defun my/org-update-org-ids ()
    ;;     "Update all org ids."
    ;;     (interactive)
    ;;     (org-id-update-id-locations
    ;;      (directory-files-recursively
    ;;       org-roam-directory ".org$\\|.org.gpg$")))

    (defun my/org-id-update-org-roam-files ()
      "Update Org-ID locations for all Org-roam files."
      (interactive)
      (org-id-update-id-locations (org-roam-list-files)))

    (defun my/org-id-update-id-current-file ()
      "Scan the current buffer for Org-ID locations and update them."
      (interactive)
      (org-id-update-id-locations (list (buffer-file-name (current-buffer)))))
    ```


#### <kbd>HYDRA</kbd> and <kbd>Transient</kbd> for easy access {#hydra-and-transient-for-easy-access}

<!--list-separator-->

- <span class="org-todo todo TODO">TODO</span>  `transient` :: org-roam `dh-do-stuff`

    흠. 하이드라로 통합 예정. 나는 마짓 스타일이 잘 안맞는다.

    ```elisp
    (transient-define-prefix dh-do-stuff ()
      ""
      ["Org-roam"
       [("oc" "org-capture" org-capture)
        ("ol" "org-store-link" org-store-link)
        ("ornf" "org-roam-node-find" org-roam-node-find)
        ("orni" "org-roam-node-insert" org-roam-node-insert)
        ("ornc" "org-roam-note-from-cite" my/org-roam-node-from-cite)
        ("co" "citar-open" citar-open)]])
    ```

<!--list-separator-->

-  `hydra` org-roam-hydra-dir

    ```elisp
    (require 'hydra)
    (defhydra my/org-roam-hydra-dir
      (:color amaranth)
      "Org-roam find nodes in subdirs"
      ("t" my/org-roam-find-terms-dir "[terms]")
      ("m" my/org-roam-find-posts-dir "[posts]")
      ("r" my/org-roam-find-refs-dir "[refs]")
      ("a" my/org-roam-find-notes-dir "[notes]")
      ("q" nil "Quit" :color blue))
    ```


#### End Configuration <span class="tag"><span class="donotmove">donotmove</span></span> {#end-configuration}

```elisp
)
```


### Consult-org-roam {#consult-org-roam}

```elisp
(defun jh-pkm/init-consult-org-roam ()
  (use-package consult-org-roam
    :after org-roam consult
    :config
    ;; (setq consult-org-roam-buffer-after-buffers t) ; ?
    (setq consult-org-roam-grep-func #'consult-ripgrep)
    (consult-customize
     ;; Eventually suppress previewing for certain functions
     consult-org-roam-file-find
     consult-org-roam-search
     consult-org-roam-backlinks
     consult-org-roam-forward-links
     :preview-key '("M-." "C-SPC"
                    ;; :debounce 0.3 "C-M-j" "C-M-k" ; conflict puni
                    :debounce 0.3 "<up>" "<down>" "C-n" "C-p"
                    ))
    ;; Activate the minor-mode
    (consult-org-roam-mode 1)))
```


## Funcs {#funcs}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
```


### org-insert-link-dwim {#org-insert-link-dwim}

I cribbed the following function from [Emacs DWIM: do what ✨I✨ mean](https://xenodium.com/emacs-dwim-do-what-i-mean/).

```elisp
(defun my/org-insert-link-dwim ()
  "Like `org-insert-link' but with personal dwim preferences."
  (interactive)
  (let* ((point-in-link (org-in-regexp org-link-any-re 1))
         (clipboard-url (when (string-match-p "^http" (current-kill 0))
                          (current-kill 0)))
         (region-content (when (region-active-p)
                           (buffer-substring-no-properties (region-beginning)
                                                           (region-end)))))
    (cond ((and region-content clipboard-url (not point-in-link))
           (delete-region (region-beginning) (region-end))
           (insert (org-make-link-string clipboard-url region-content)))
          ((and clipboard-url (not point-in-link))
           (insert (org-make-link-string
                    clipboard-url
                    (read-string "Title: "
                                 (with-current-buffer (url-retrieve-synchronously clipboard-url)
                                   (dom-text (car
                                              (dom-by-tag (libxml-parse-html-region
                                                           (point-min)
                                                           (point-max))
                                                          'title))))))))
          (t
           (call-interactively 'org-insert-link)))))
```


### assistance `rogue's tips` {#assistance-rogue-s-tips}

<span class="timestamp-wrapper"><span class="timestamp">[2023-04-22 Sat 10:52]</span></span>
/home/junghan/sync/man/dotsamples/spacemacs/rogue-dot-spacemacs/funcs.el

```elisp
(defun range (n)
  "Python like range function returning list."
  (cl-loop for i from 0 to (- n 1)
           collect i))

(defun shuffle-list (its)
  "Destructive but inefficient list shuffling."
  (cl-loop for i downfrom (- (length its) 1) to 1
           do (let ((i-val (nth i its))
                    (j (random (+ i 1))))
                (setf (nth i its) (nth j its))
                (setf (nth j its) i-val)))
  its)

(defun shuffle-org-list ()
  "Shuffle list at point."
  (interactive)
  (save-excursion
    (let ((org-list (org-list-to-lisp t)))
      (insert (org-list-to-org (cons (car org-list) (shuffle-list (cdr org-list)))))
      (org-list-repair))))

(defun reading-time (&optional wpm)
  (/ (count-words (point-min) (point-max)) (or wpm 200)))

(defun firefox-profile-directory ()
  "Return profile directory for firefox."
  (-find (lambda (d) (string-match "default$" d)) (f-directories "~/.mozilla/firefox")))

(defmacro --with-temp-copy (file-path &rest body)
  "Run BODY after making a temporary copy of given FILE-PATH.

  In the BODY forms, `it' provides the path for the copy."
  (declare (indent defun))
  `(let ((it (make-temp-file (f-base ,file-path))))
     (unwind-protect
         (progn
           (copy-file ,file-path it t)
           ,@body)
       (f-delete it))))

(defun youtube-history ()
  "Return youtube history."
  (--with-temp-copy (f-join (firefox-profile-directory) "places.sqlite")
    (json-parse-string
     (shell-command-to-string
      (format "sqlite3 -json %s %s"
              (shell-quote-argument it)
              (shell-quote-argument "SELECT url, title FROM moz_places WHERE title IS NOT NULL AND rev_host LIKE '%utuoy%' AND url LIKE '%watch%' ORDER BY last_visit_date DESC")))
     :array-type 'list
     :object-type 'alist)))

(defvar youtube-process nil
  "Process for keeping youtube player.")

;; (defun youtube-play-url (url)
;;   (when (and youtube-process (process-live-p youtube-process))
;;     (kill-process youtube-process))
;;   (setq youtube-process (start-process "youtube-play" nil "mpv" "--no-video" url)))

;; (defun youtube-history-play ()
;;   (interactive)
;;   (helm :sources (helm-build-sync-source "youtube-history"
;;                                          :candidates (mapcar (lambda (it) (cons (alist-get 'title it) (alist-get 'url it))) (youtube-history))
;;                                          :action `(("Play audio" . youtube-play-url)))
;;         :buffer "*helm youtube history*"
;;         :prompt "Title: "))

(defun aleatory-assitance ()
  "Give a random strategy to get unstuck."
  (interactive)
  (let ((strategies (s-split "\n" (s-trim "1. Take the braver decision
    2. Take a nap
    3. What's the title of this book?
    4. What's the choice between?
    5. Ask ChatGPT for the final decision
    6. What will make you proud of yourself?
    7. Choose freedom
    8. Start reading a new book
    9. Be kind to people involved
    10. Name this
    11. Start a repository
    12. Where's the money coming from?
    13. Close everything, start again
    14. Connect with an expert in the area
    15. How would you have done it?
    16. Combine two unrelated concepts
    17. Toss a coin
    18. Explain it to a business person
    19. How much time will it take? Take 3 times more
    20. Talk to the nearest human
    21. What are the ingredients? What's missing?
    22. Search old notes
    23. How will this look like in the future?
    24. Find an equivalent problem
    25. Work in a different domain
    26. Take out another card
    27. What's the most ambitious option?
    28. List risks
    29. Run an experiment
    30. Record a video on current status
    31. Ship right now!
    32. What's the strongest feeling right now?
    33. What's one bias you can remove right now?
    34. Write an email
    35. What's the weather trend these days?
    36. Use a new animal
    37. Make a plot
    38. Collect data
    39. Make it efficient
    40. Remove the most meaningless portion
    41. Make a mistake
    42. What do you need other than time? Ask for it.
    "))))
    (print (car (shuffle-list strategies)))))
```


### org-hide-properties {#org-hide-properties}



```elisp
(defun org-hide-properties ()
  "Hide all org-mode headline property drawers in buffer. Could be slow if it has a lot of overlays."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward
            "^ *:properties:\n\\( *:.+?:.*\n\\)+ *:end:\n" nil t)
      (let ((ov_this (make-overlay (match-beginning 0) (match-end 0))))
        (overlay-put ov_this 'display "")
        (overlay-put ov_this 'hidden-prop-drawer t))))
  (put 'org-toggle-properties-hide-state 'state 'hidden))

(defun org-show-properties ()
  "Show all org-mode property drawers hidden by org-hide-properties."
  (interactive)
  (remove-overlays (point-min) (point-max) 'hidden-prop-drawer t)
  (put 'org-toggle-properties-hide-state 'state 'shown))

(defun org-toggle-properties ()
  "Toggle visibility of property drawers."
  (interactive)
  (if (eq (get 'org-toggle-properties-hide-state 'state) 'hidden)
      (org-show-properties)
    (org-hide-properties)))
```


## Keybindings {#keybindings}

```elisp
;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-

;;   "o" 'link-hint-open-link
;;   "r" 'org-roam-buffer-refresh

;; 'C-c n' my-org-roam-map
(define-prefix-command 'my-org-roam-map)
(define-key global-map (kbd "C-c n") 'my-org-roam-map)
(define-key org-mode-map (kbd "C-M-i") 'completion-at-point)

;; 2023-05-28 project, agenda 관련 부분은 org-roam 에서 제거한다.
(let ((map my-org-roam-map))
  (define-key map (kbd "a") 'org-roam-alias-add)
  (define-key map (kbd "A") 'my/org-roam-get-all-tags)

  (define-key map (kbd "c") #'org-roam-capture)
  (define-key map (kbd "d") #'dh-do-stuff)
  (define-key map (kbd "f") #'consult-org-roam-file-find)
  (define-key map (kbd "h") #'my/org-roam-hydra-dir/body)

  (define-key map (kbd "g") #'org-roam-graph)
  (define-key map (kbd "G") #'org-id-get-create)
  (define-key map (kbd "i") #'org-roam-node-insert)
  (define-key map (kbd "I") #'org-roam-node-insert-immediate) ; ADD
  (define-key map (kbd "l") #'org-roam-buffer-toggle)

  ;; org-projectile 을 프로젝트 관리로 사용한다. 프로젝트 산출물 (코드, 문서)
  ;; 가 모여있는 git 리포지토리에 대한 전역 투두 관리이다.
  ;; org-roam 은 글을 쓰고 연결하는 곳이다. 프로젝트 세부 내용은 매우
  ;; 가변적이다. 흘러갈 내용이다.
  (define-key map (kbd "p") 'org-projectile-project-todo-completing-read)

  (define-key map (kbd "r") 'org-roam-ref-find)
  (define-key map (kbd "R") 'org-roam-ref-add)
  (define-key map (kbd "S") 'org-roam-db-sync)

  (define-key map (kbd "T") 'my/org-roam-tag-search)
  (define-key map (kbd "L") 'my/org-insert-link-dwim)

  (define-key map (kbd ",") 'aleatory-assitance)
  (define-key map (kbd ".") 'consult-org-roam-search)

  (define-key map (kbd "[") 'consult-org-roam-backlinks)
  (define-key map (kbd "]") 'consult-org-roam-forward-links)
  )

(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "rI" 'org-roam-node-insert-immediate
  "rS" 'org-roam-db-sync
  "rT" 'my/org-roam-tag-search
  "rL" 'my/org-insert-link-dwim
  )
```
